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
        collectionFlowLayout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 0)
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        
        collectionView.register(SelfSizedCollectionViewCell.self)
        return collectionView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update Layout", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private var viewControllersForCells: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupButton()
        fillControllers()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.bounces = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.keyboardDismissMode = .onDrag
        collectionView.bounces = true
    }
    
    private func setupButton() {
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func fillControllers() {
        for _ in 1...10 {
            let viewController = ImageWithTitleViewController()
            viewControllersForCells.append(viewController)
        }
        collectionView.reloadData()
    }
    
    @objc func buttonPressed(_ : UIControl) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        guard let cell = cell as? SelfSizedCollectionViewCell else { return }
//        cell.addContentViewController(self)
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
