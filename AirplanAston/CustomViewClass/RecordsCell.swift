//
//  RecordsCell.swift
//  AirplanAston
//
//  Created by Андрей Цуркан on 10.10.2023.
//

import UIKit

class RecordsCell: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    var nameLabel = UILabel()
    var emptyView = UIView()
    var scoreLabel = UILabel()
    var stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStackView()
        setupSubView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        scoreLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    
    func setupSubView() {
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(emptyView)
        stackView.addArrangedSubview(scoreLabel)
        
        nameLabel.text = UserSettings.records?.name
    }
}
