//
//  GameViewController.swift
//  AirplanAston
//
//  Created by Андрей Цуркан on 08.09.2023.
//

import UIKit

private extension CGFloat {
    static let backScreenButtonLeftAnchor = 30.0
    static let foutyOffset = 35.0
    static let backScreenButtonWithAndHeight = 35.0
}

class GameViewController: UIViewController {
    
    var timer: Timer!
    var airplainX: NSLayoutConstraint?
    var UFOX: NSLayoutConstraint?
    var counter: CGFloat = 0
    
    private lazy var backScreenButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backScreen"), for: .normal)
        button.tag = 2
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        return button
    }()
    private let leftShore: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shoreLeft")
        return image
    }()
    private let rightShore: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shoreRight")
        return image
    }()
    private let airplaneImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: .airplaneArr[0])
        return image
    }()
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.tag = 0
        button.setImage(UIImage(named: "right"), for: .normal)
        button.addTarget(self, action: #selector(actionMoveAirplane), for: .touchUpInside)
        return button
    }()
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.setImage(UIImage(named: "left"), for: .normal)
        button.addTarget(self, action: #selector(actionMoveAirplane), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        animationImage()
        view.layer.contents = UIImage(imageLiteralResourceName: "background").cgImage
        navigationController?.isNavigationBarHidden = true
        createObstacle()
    }
    
    private func createObstacle() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [ weak self ] timer in
            guard let self else { return }
            let image = UIImageView()
            image.image = UIImage(named: "UFO")
            
            self.view.insertSubview(image, at: 0)
            image.translatesAutoresizingMaskIntoConstraints = false
            
            let constant = CGFloat(Int.random(in: -150...150))
            let yConstraint = image.topAnchor.constraint(equalTo: self.view.topAnchor, constant:  -100)
            yConstraint.isActive = true
            
            NSLayoutConstraint.activate([
                image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: constant),
                image.heightAnchor.constraint(equalToConstant: 50),
                image.widthAnchor.constraint(equalToConstant: 50)])
            self.view.layoutIfNeeded()
            
            yConstraint.constant = self.view.frame.height + 100
            
            UIView.animate(withDuration: 5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func setupViews() {
        view.addSubview(leftShore)
        leftShore.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(rightShore)
        rightShore.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(airplaneImage)
        airplaneImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(rightButton)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(leftButton)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backScreenButton)
        backScreenButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backScreenButton.topAnchor.constraint(equalTo: view.topAnchor, constant: .foutyOffset),
            backScreenButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .backScreenButtonLeftAnchor),
            backScreenButton.widthAnchor.constraint(equalToConstant: .backScreenButtonWithAndHeight),
            backScreenButton.heightAnchor.constraint(equalToConstant: .backScreenButtonWithAndHeight),
            
            leftShore.topAnchor.constraint(equalTo: view.topAnchor),
            leftShore.leftAnchor.constraint(equalTo: view.leftAnchor),
            leftShore.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leftShore.widthAnchor.constraint(equalToConstant: 30),
            
            rightShore.topAnchor.constraint(equalTo: view.topAnchor),
            rightShore.rightAnchor.constraint(equalTo: view.rightAnchor),
            rightShore.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            airplaneImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -115),
            airplaneImage.widthAnchor.constraint(equalToConstant: 50),
            airplaneImage.heightAnchor.constraint(equalToConstant: 50),
            
            leftButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            leftButton.leftAnchor.constraint(equalTo: leftShore.rightAnchor, constant: 40),
            leftButton.widthAnchor.constraint(equalToConstant: 70),
            leftButton.heightAnchor.constraint(equalToConstant: 60),
            
            rightButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            rightButton.rightAnchor.constraint(equalTo: rightShore.leftAnchor, constant: -40),
            rightButton.widthAnchor.constraint(equalToConstant: 70),
            rightButton.heightAnchor.constraint(equalToConstant: 60)])
        
        airplainX = airplaneImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        airplainX?.isActive = true
    }
    
    private func animationImage() {
        UIView.animate(withDuration: 3) {
            self.leftShore.frame.origin.y = self.view.frame.height * 2
            self.rightShore.frame.origin.y = self.view.frame.height * 2
        }
    }
    
    @objc func actionMoveAirplane(sander: UIButton) {
        if sander.tag == 0 {
            if counter < 100 {
                counter += 100
            }
        }
        
        if sander.tag == 1 {
            if counter > -100 {
                counter -= 100
            }
        }
        
        self.airplainX?.constant = self.counter
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func actionButton(sender: UIButton) {
        if sender.tag == 2 {
            navigationController?.popViewController(animated: true)
        }
    }
}
