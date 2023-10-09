//
//  СartridgeImageView.swift
//  AirplanAston
//
//  Created by Андрей Цуркан on 06.10.2023.
//

import UIKit

class СartridgeImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        let image = UIImage(named: "cartridge")
        self.image = image
    }
}
