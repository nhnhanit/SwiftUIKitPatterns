//
//  PostsListViewController.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 14/5/25.
//

import UIKit
import Combine

final class PostsListViewController: UIViewController {
    
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
    
    private func setupLayout() {}
    private func configureUI() {}

    private func bindViewModel() {
        viewModel.$posts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] posts in
                guard let self = self else { return }
                
                // reload tableView / collectionView
                
                self.title = "Posts List \(posts.count)"
            }
            .store(in: &cancellables)

        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self = self else { return }

                let alertModel = AlertModel(title: "Error", message: error)
                AlertManager.shared.show(alertModel, from: self)
            }
            .store(in: &cancellables)

        viewModel.fetchPosts()
    }
}


