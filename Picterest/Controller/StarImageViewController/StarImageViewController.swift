//
//  StarImageViewController.swift
//  Picterest
//
//  Created by J_Min on 2022/07/25.
//

import UIKit
import Combine

final class StarImageViewController: UIViewController {
    
    // MARK: - ViewProperties
    private lazy var starImageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCollectionViewCell.self,
                                forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        
        return collectionView
    }()
    
    // MARK: - Properties
    private let starImageViewModel = StarImageViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigation()
        configureSubView()
        setConstraintsOfRandomImageCollectionView()
        bindingViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        starImageViewModel.fetcnStarImages()
    }
}

// MARK: - Binding
extension StarImageViewController {
    private func bindingViewModel() {
        starImageViewModel.updateStarImages
            .sink { [weak self] in
                self?.starImageCollectionView.reloadSections(IndexSet(0...0))
            }.store(in: &subscriptions)
    }
}

// MARK: - UI
extension StarImageViewController {
    
    private func configureNavigation() {
        navigationItem.title = "Star Images"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureSubView() {
        view.addSubview(starImageCollectionView)
    }
    
    private func setConstraintsOfRandomImageCollectionView() {
        NSLayoutConstraint.activate([
            starImageCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            starImageCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            starImageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            starImageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension StarImageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return starImageViewModel.starImageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension StarImageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - (collectionView.contentInset.left + collectionView.contentInset.right))
        
        return CGSize(width: width, height: width)
    }
}
