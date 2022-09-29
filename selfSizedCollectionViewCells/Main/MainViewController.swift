//
//  ViewController.swift
//  selfSizedCollectionViewCells
//
//  Created by Sergey Shabelnik on 29.09.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .vertical
        collectionFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        
        collectionView.register(SelfSizedCollectionViewCell.self)
        return collectionView
    }()
    
    private var viewControllersForCells: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fillControllers()
    }
    
    private func setupCollectionView() {
        view.insertSubview(collectionView, at: 0)
        collectionView.frame = view.bounds
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.bounces = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.keyboardDismissMode = .onDrag
        collectionView.bounces = true
    }
    
    private func fillControllers() {
        let viewController = ImageWithTitleViewController()
        for _ in 1...3 {
            viewControllersForCells.append(viewController)
        }
        collectionView.reloadData()
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? SelfSizedCollectionViewCell else { return }
        cell.addContentViewController(self)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? SelfSizedCollectionViewCell else { return }
        cell.removeContentViewController()
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewControllersForCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SelfSizedCollectionViewCell = collectionView.dequeueCell(for: indexPath)
        cell.contentViewController = viewControllersForCells[indexPath.item]
        cell.addContentViewController(self)
        return cell
    }
    
    
    
}
