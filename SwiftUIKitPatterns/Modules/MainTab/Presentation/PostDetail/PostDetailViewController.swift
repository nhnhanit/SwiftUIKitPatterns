//
//  PostDetailViewController.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 26/5/25.
//

import UIKit
import Combine

final class PostDetailViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: PostDetailViewModel
    
    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let favoriteSwitch = UISwitch()
    private let userLabel = UILabel()
    private let scrollView = UIScrollView()
    
    init(viewModel: PostDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        configUI()
        bindViewModel()
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemBackground
        title = "Post Detail"
        
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        bodyLabel.numberOfLines = 0
        userLabel.font = .italicSystemFont(ofSize: 14)
        
        let deleteButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(didTapDeleteButton))
        navigationItem.rightBarButtonItems = [deleteButton]
        
        favoriteSwitch.addTarget(self, action: #selector(didTapFavoriteButton), for: .valueChanged)
        
        let content = UIStackView(arrangedSubviews: [titleLabel, bodyLabel, favoriteSwitch, userLabel])
        content.axis = .vertical
        content.spacing = 16
        content.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(content)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            content.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            content.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            content.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            content.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            content.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }
    
    private func configUI() {
        //
    }
    
    private func bindViewModel() {
        
        viewModel.$post
            .receive(on: RunLoop.main)
            .sink { [weak self] post in
                guard let post = post else { return }
                self?.titleLabel.text = "#\(post.id). " + post.title
                self?.bodyLabel.text = post.body
                self?.favoriteSwitch.isOn = post.isFavorite
            }
            .store(in: &cancellables)
        
        viewModel.$user
            .receive(on: RunLoop.main)
            .sink { [weak self] user in
                guard let user = user else { return }
                self?.userLabel.text = "By: \(user.name)"
            }
            .store(in: &cancellables)
        
        viewModel.$comments
            .receive(on: RunLoop.main)
            .sink { comments in
                print("comments count: \(comments.count)")
            }
            .store(in: &cancellables)
        
        // Show alert from view model
        viewModel.onShowAlert = { alertModel in
            AlertManager.shared.show(alertModel)
        }
        
        Task {
            await viewModel.loadData()
        }
    }
    
    @objc private func didTapDeleteButton() {
        guard let post = viewModel.post else { return }
        
        Task {
            let success = await viewModel.deletePost(postId: post.id)
            guard success else { return }
            
            // Update UI
            viewModel.removePost(post: post)
            viewModel.coordinator.backToPostsList()
        }
    }
    
    @objc private func didTapFavoriteButton() {
        Task {
            await viewModel.favoriteButtonTapped()
        }
//        guard let post = viewModel.post else { return }
//        
//        Task {
//            let newValue = !post.isFavorite
//            let updatedPost = await viewModel.updateFavorite(postId: post.id, isFavorite: newValue)
//            guard let updatedPost else { return }
//            
//            await viewModel.updatePost(updatedPost)
//        }
    }
}
