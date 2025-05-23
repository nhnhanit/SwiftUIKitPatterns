//
//  PostsListViewController.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 14/5/25.
//

import UIKit
import Combine

final class PostsListViewController: UIViewController {
    
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let endOfListFooterView = EndOfListFooterView()
    
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: PostsListViewModel
    
    init(viewModel: PostsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts List"
        view.backgroundColor = .systemBackground
        
        setupLayout()
        configureUI()
        bindViewModel()
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.tableFooterView = UIView()
        endOfListFooterView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 44)
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func bindViewModel() {
        // Observe posts changes
        viewModel.$posts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] posts in
                guard let self else { return }
                self.tableView.reloadData()
                self.navigationItem.title = "Posts List \(posts.count)"
                
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
            }
            .store(in: &cancellables)
        
        // Observe loading state
        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoading in
                guard let self else { return }
                isLoading ? self.showLoadingIndicator() : self.hideLoadingIndicator()
            }
            .store(in: &cancellables)
        
        // Observe if last page is reached
        viewModel.$isLastPage
            .receive(on: RunLoop.main)
            .sink { [weak self] isLastPage in
                guard let self else { return }
                if isLastPage {
                    self.tableView.tableFooterView = self.endOfListFooterView
                } else {
                    self.tableView.tableFooterView = UIView()
                }
            }
            .store(in: &cancellables)
        
        // Show alert from view model
        viewModel.onShowAlert = { alertModel in
            AlertManager.shared.show(alertModel)
        }
        
        // Initial load
        Task {
            await viewModel.fetchPosts()
        }
    }
    
    @objc private func didPullToRefresh() {
        // Prevent accidental refresh triggers
        guard tableView.isDragging else {
            refreshControl.endRefreshing()
            return
        }
        
        viewModel.refreshPosts()
        refreshControl.endRefreshing()
    }
}

extension PostsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        
        let post = viewModel.posts[indexPath.row]
        cell.delegate = self
        cell.configure(with: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.loadMoreIfNeeded(currentIndex: indexPath.row)
    }
}

extension PostsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPost = viewModel.posts[indexPath.row]
        print("didSelectRowAt: \(selectedPost.id) - \(selectedPost.title)")
        // TODO: Navigate to post detail screen
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension PostsListViewController: PostTableViewCellDelegate {
    
    func postCellDidTapDelete(_ cell: PostTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let post = viewModel.posts[indexPath.row]
        
        Task {
            let success = await viewModel.deletePost(postId: post.id)
            guard success else { return }
            
            viewModel.removePost(postId: post.id)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func postCellDidTapFavorite(_ cell: PostTableViewCell, post: Post) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        Task {
            let newValue = !post.isFavorite
            let updatedPost = await viewModel.updateFavorite(postId: post.id, isFavorite: newValue)
            guard let updatedPost else { return }
            
            viewModel.updatePost(updatedPost)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
}
