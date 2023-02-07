//
//  ConstantUIComponets.swift
//  RxNews
//
//  Created by Sezgin Çiftci on 7.02.2023.
//

import UIKit.UILabel

class MakeProperty {
    static func makeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .secondarySystemBackground
        label.backgroundColor = .systemIndigo
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }
}
