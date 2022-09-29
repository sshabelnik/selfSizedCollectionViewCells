//
//  SelfSizedCollectionViewCell.swift
//  selfSizedCollectionViewCells
//
//  Created by Sergey Shabelnik on 29.09.2022.
//

import UIKit
import SnapKit

final class SelfSizedCollectionViewCell: UICollectionViewCell {
    var contentViewController: UIViewController?

    var isHeightCalculated = false
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isHeightCalculated = false
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        if !isHeightCalculated {
//            setNeedsLayout()
//            layoutIfNeeded()
            
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var frame = layoutAttributes.frame
            frame.size.width = UIScreen.main.bounds.width
            frame.size.height = ceil(size.height)
            layoutAttributes.frame = frame
            isHeightCalculated = true
            print("NEW FRAME IS: \(frame)")
//        }
        return layoutAttributes
    }
    
    func addContentViewController(_ parentViewController: UIViewController) {
        guard let contentViewController = contentViewController else { return }
        contentViewController.willMove(toParent: parentViewController)
        parentViewController.addChild(contentViewController)
        contentViewController.didMove(toParent: parentViewController)
        contentView.addSubview(contentViewController.view)
        contentViewController.view.layoutIfNeeded()
        setupConstraints()
    }
    
    func removeContentViewController() {
        guard let childViewController = contentViewController else { return }
        childViewController.willMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
        contentViewController = nil
    }
    
    private func setupConstraints() {
        contentViewController?.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
