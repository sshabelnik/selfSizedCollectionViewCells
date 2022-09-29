//
//  ReusableExtension.swift
//  selfSizedCollectionViewCells
//
//  Created by Sergey Shabelnik on 29.09.2022.
//

import UIKit

/// Протокол для любой вьюшки, которая имеет reuseIdentifier.
/// Протоколу следуют UITableViewCell, UITableViewHeaderFooterView, UITableViewHeaderFooterView и
/// UICollectionReusableView (соответственно, так же UICollectionViewCell)
public protocol Reusable: AnyObject {
    /// По умолчанию совпадает с названием типа. При необходимости можно переопределить.
    static var reuseIdentifier: String { get }
    
    /// Соответствующий Nib-файл. По умолчанию проверяет есть ли Nib с названием, совпадающим с названием класса, и,
    /// если есть, возвращает его, в противном случае возвращает nil. При необходимости можно переопределить.
    static func nib() -> UINib?
}

public extension Reusable {
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    static func nib() -> UINib? {
        guard Bundle(for: self).path(forResource: String(describing: self), ofType: "nib") != nil else {
            return  nil
        }
        
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

extension UITableViewCell: Reusable {}
extension UITableViewHeaderFooterView: Reusable {}
extension UICollectionReusableView: Reusable {}
