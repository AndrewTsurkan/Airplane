//
//  imageView.swift
//  AirplanAston
//
//  Created by Андрей Цуркан on 03.10.2023.
//

import UIKit

class UFOImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        let image = UIImage(named: "UFO")
        self.image = image
    }
}


