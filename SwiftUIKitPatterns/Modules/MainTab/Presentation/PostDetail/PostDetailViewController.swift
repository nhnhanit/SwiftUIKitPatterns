//
//  PostDetailViewController.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 26/5/25.
//

import UIKit

final class PostDetailViewController: UIViewController {
    private let viewModel: PostDetailViewModel

    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let favoriteSwitch = UISwitch()
    private let userLabel = UILabel()
    private let commentStack = UIStackView()
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
        setupUI()
        loadData()
    }

    private func loadData() {
        
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Post Detail"

        titleLabel.font = .boldSystemFont(ofSize: 24)
        bodyLabel.numberOfLines = 0
        userLabel.font = .italicSystemFont(ofSize: 14)
        commentStack.axis = .vertical
        commentStack.spacing = 8

        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        let deleteButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteTapped))
        navigationItem.rightBarButtonItems = [deleteButton, editButton]

        favoriteSwitch.addTarget(self, action: #selector(favoriteToggled), for: .valueChanged)

        let content = UIStackView(arrangedSubviews: [titleLabel, bodyLabel, favoriteSwitch, userLabel, commentStack])
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

    private func updateUI() {
        guard let post = viewModel.post else { return }
        titleLabel.text = post.title
        bodyLabel.text = post.body
        favoriteSwitch.isOn = post.isFavorite

        if let user = viewModel.user {
            userLabel.text = "By: \(user.name)"
        }

        commentStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for comment in viewModel.comments {
            let label = UILabel()
            label.text = "• \(comment.name): \(comment.body)"
            label.numberOfLines = 0
            commentStack.addArrangedSubview(label)
        }
    }

    @objc private func editTapped() {
//        viewModel.editPost()
    }

    @objc private func deleteTapped() {
//        viewModel.deletePost()
    }

    @objc private func favoriteToggled() {
//        viewModel.toggleFavorite()
    }
}
