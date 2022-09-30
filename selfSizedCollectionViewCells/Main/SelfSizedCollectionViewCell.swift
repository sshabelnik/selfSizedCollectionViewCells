//
//  SelfSizedCollectionViewCell.swift
//  selfSizedCollectionViewCells
//
//  Created by Sergey Shabelnik on 29.09.2022.
//

import UIKit
import SnapKit

final class SelfSizedCollectionViewCell: UICollectionViewCell {
    
    var mainView = UIView()
    
    var contentViewController: UIViewController?

    var isHeightCalculated = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(mainView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            
        }
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
//            $0.width.equalTo(UIScreen.main.bounds.width).priority(999)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isHeightCalculated = false
    }

    
    override func systemLayoutSizeFitting(
        _ targetSize: CGSize,
        withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
        verticalFittingPriority: UILayoutPriority) -> CGSize {
            var targetSize = targetSize
            targetSize.height = 0

            let size = super.systemLayoutSizeFitting(
                targetSize,
                withHorizontalFittingPriority: .required,
                verticalFittingPriority: .fittingSizeLevel
            )
            
            print("SIZE IS: \(size)")
            return size
        }
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        if !isHeightCalculated {
//            let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
//            setNeedsLayout()
//            layoutIfNeeded()
//
//            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//            var frame = layoutAttributes.frame
//            frame.size.height = ceil(size.height)
//            layoutAttributes.frame = frame
//            isHeightCalculated = true
//            print("NEW FRAME IS: \(frame)")
//        }
//        return layoutAttributes
//    }
    
    func addContentViewController(_ parentViewController: UIViewController) {
        guard let contentViewController = contentViewController else { return }
        contentViewController.willMove(toParent: parentViewController)
        parentViewController.addChild(contentViewController)
        contentViewController.didMove(toParent: parentViewController)
        mainView.addSubview(contentViewController.view)
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
