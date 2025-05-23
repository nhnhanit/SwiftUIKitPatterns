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
        viewModel.$posts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] posts in
                guard let self = self else { return }
                
                self.tableView.reloadData()
                self.navigationItem.title = "Posts List \(posts.count)"
                
                // 👇 Dừng refresh nếu đang refreshing
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                
                isLoading ? self.showLoadingIndicator() : self.hideLoadingIndicator()
                
            }
            .store(in: &cancellables)
        
        viewModel.$isLastPage
            .receive(on: RunLoop.main)
            .sink { [weak self] isLastPage in
                guard let self = self else { return }
                
                // 👉 Khi đã hết dữ liệu (cuối danh sách)
                if isLastPage {
                    self.endOfListFooterView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 44)
                    self.tableView.tableFooterView = self.endOfListFooterView
                } else {
                    self.tableView.tableFooterView = UIView()
                }
                
            }
            .store(in: &cancellables)
        
        viewModel.onShowAlert = { alertModel in
            AlertManager.shared.show(alertModel)
        }
        
        viewModel.fetchPosts()
    }
    
    @objc private func didPullToRefresh() {
        // Chỉ thực hiện nếu user đang kéo tableView
        guard tableView.isDragging else {
            refreshControl.endRefreshing() // Dừng lại ngay nếu không phải pull
            return
        }
        
        viewModel.refreshPosts() // Refresh lại từ đầu
        refreshControl.endRefreshing()
    }
}

extension PostsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
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
    // Có thể thêm các hàm delegate khác nếu cần, ví dụ:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // Bỏ chọn cell ngay lập tức
        let selectedPost = viewModel.posts[indexPath.row]
        print("didSelectRowAt: \(selectedPost.id) - \(selectedPost.title)")
        // TODO: Điều hướng đến màn hình chi tiết bài viết
    }
    
    // Tùy chỉnh chiều cao của cell nếu cần
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Giá trị ước tính, giúp tableView tính toán nhanh hơn
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension // Cho phép cell tự động tính chiều cao
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
    
}


