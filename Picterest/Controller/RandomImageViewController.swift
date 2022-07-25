//
//  RandomImageViewController.swift
//  Picterest
//
//  Created by J_Min on 2022/07/25.
//

import UIKit

final class RandomImageViewController: UIViewController {
    
    // MARK: - ViewProperties
    private lazy var randomImageCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCollectionViewCell.self,
                                forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        
        return collectionView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureSubView()
        setConfigurationsOfRandomImageCollectionView()
    }
}

// MARK: - UI
extension RandomImageViewController {
    private func configureNavigation() {
        navigationItem.title = "Random Image"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureSubView() {
        view.addSubview(randomImageCollectionView)
    }
    
    private func setConfigurationsOfRandomImageCollectionView() {
        NSLayoutConstraint.activate([
            randomImageCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            randomImageCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            randomImageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            randomImageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension RandomImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell()
        
        return cell
    }
}

extension RandomImageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right) - 7) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}
