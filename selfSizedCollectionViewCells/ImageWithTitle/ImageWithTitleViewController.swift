//
//  ImageWithTitleViewController.swift
//  selfSizedCollectionViewCells
//
//  Created by Sergey Shabelnik on 29.09.2022.
//

import UIKit

class ImageWithTitleViewController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "car")
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font.withSize(20)
        label.text = "BMW M5 Competition"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(imageView)
        view.addSubview(label)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        label.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.bottom.equalToSuperview().offset(-15)
        }
    }
}
