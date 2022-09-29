//
//  UICollectionView+Extension.swift
//  selfSizedCollectionViewCells
//
//  Created by Sergey Shabelnik on 29.09.2022.
//

import UIKit

public extension UICollectionView {
    // MARK: - UICollectionViewCell
    
    /// Регистрирует переданные типы ячеек. Если удалось найти nib-файл для типа, регистрирует nib, если нет, то
    /// регистрирует сам тип.
    final func register(_ cellTypes: [UICollectionViewCell.Type]) {
        cellTypes.forEach(register)
    }
    
    /// Регистрирует переданный тип ячейки. Если удалось найти nib-файл для типа, регистрирует nib, если нет, то
    /// регистрирует сам тип.
    final func register(_ cellType: UICollectionViewCell.Type) {
        if let nib = cellType.nib() {
            register(nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
        } else {
            register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
        }
    }
    
    /// Делает dequeueReusableCell(withReuseIdentifier:for:) и сразу кастит возвращаемую ячейку в нужный тип.
    /// В качестве идентификатора используется название класса. Для задания своего идентификатора нужно переопределить
    /// static var reuseIdentifier в классе ячейки.
    final func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Не удалось сделать dequeue ячейки с типом \(T.self) " +
                "и reuseIdentifier \(T.reuseIdentifier). " +
                "Убедитесь, что вы зарегистировали ячейку"
            )
        }
        
        return cell
    }
}
