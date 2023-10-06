//
//  GameViewController.swift
//  AirplanAston
//
//  Created by Андрей Цуркан on 08.09.2023.
//

import UIKit
//MARK: - extension CGFloat
private extension CGFloat {
    static let backScreenButtonLeftAnchor = 30.0
    static let foutyOffset = 35.0
    static let backScreenButtonWithAndHeight = 35.0
    static let screenHeight = UIScreen.main.bounds.height
    static let oneHundred = 100.0
    static let fifty = 50.0
    static let sixty = 60.0
    static let seventy = 70.0
    static let twoGundredAndFifty = 250.0
    static let twenty = 20.0
    static let fiftyFive = 55.0
}

class GameViewController: UIViewController {
    //MARK: - properties
    var modelAirplaine = ""
    private var timer: Timer!
    private var airplainX: NSLayoutConstraint?
    private var UFOX: NSLayoutConstraint?
    private var counter: CGFloat = 0
    private var displayLink: CADisplayLink?
    
    private var gameOverImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "gameOver")
        image.isHidden = true
        return image
    }()
    private lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "tryAgain"), for: .normal)
        button.tag = 3
        button.isHidden = true
        button.addTarget(self, action: #selector(actionTryAgainButton), for: .touchUpInside)
        return button
    }()
    private lazy var backScreenButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backScreen"), for: .normal)
        button.addTarget(self, action: #selector(actionBackButton), for: .touchUpInside)
        return button
    }()
    private let leftShore: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shoreLeft")
        return image
    }()
    private let leftShoreSup: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shoreLeft")
        return image
    }()
    private let rightShore: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shoreRight")
        return image
    }()
    private let rightShoreSup: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shoreRight")
        return image
    }()
    private let airplaneImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: .airplaneArr[UserSettings.modelAirplane ?? 0])
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
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsSuperview()
        setupViews()
        animationImage()
        createObstacle()
    }
    
    //MARK: - Func
    private func settingsSuperview() {
        view.layer.contents = UIImage(imageLiteralResourceName: "background").cgImage
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupViews() {
        view.addSubview(gameOverImage)
        gameOverImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tryAgainButton)
        tryAgainButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(airplaneImage)
        airplaneImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(rightButton)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(leftButton)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backScreenButton)
        backScreenButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gameOverImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gameOverImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameOverImage.heightAnchor.constraint(equalToConstant: .twoGundredAndFifty),
            gameOverImage.widthAnchor.constraint(equalToConstant: .twoGundredAndFifty),
            
            tryAgainButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: .screenHeight / 6),
            tryAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tryAgainButton.widthAnchor.constraint(equalToConstant: .fifty),
            tryAgainButton.heightAnchor.constraint(equalToConstant: .fifty),
            
            backScreenButton.topAnchor.constraint(equalTo: view.topAnchor, constant: .foutyOffset),
            backScreenButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .backScreenButtonLeftAnchor),
            backScreenButton.widthAnchor.constraint(equalToConstant: .backScreenButtonWithAndHeight),
            backScreenButton.heightAnchor.constraint(equalToConstant: .backScreenButtonWithAndHeight),
            
            airplaneImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -.oneHundred - 15),
            airplaneImage.widthAnchor.constraint(equalToConstant: .fifty),
            airplaneImage.heightAnchor.constraint(equalToConstant: .fifty),
            
            leftButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -.fifty),
            leftButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: .oneHundred),
            leftButton.widthAnchor.constraint(equalToConstant: .seventy),
            leftButton.heightAnchor.constraint(equalToConstant: .sixty),
            
            rightButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -.fifty),
            rightButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -.oneHundred),
            rightButton.widthAnchor.constraint(equalToConstant: .seventy),
            rightButton.heightAnchor.constraint(equalToConstant: .sixty)])
        
        airplainX = airplaneImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        airplainX?.isActive = true
    }
    
    private func animationImage() {
        view.addSubview(leftShore)
        leftShore.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(rightShore)
        rightShore.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(leftShoreSup)
        leftShoreSup.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(rightShoreSup)
        rightShoreSup.translatesAutoresizingMaskIntoConstraints = false
        
        let yConstraintLeftShore = leftShore.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -.screenHeight)
        yConstraintLeftShore.isActive = true
        
        let yConstraintRightShore = rightShore.topAnchor.constraint(equalTo: self.view.topAnchor, constant:  -.screenHeight)
        yConstraintRightShore.isActive = true
        
        let yConstraintLeftShoreSup = leftShoreSup.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -.screenHeight)
        yConstraintLeftShoreSup.isActive = true
        
        let yConstraintRightShoreSup = rightShoreSup.topAnchor.constraint(equalTo: self.view.topAnchor, constant:  -.screenHeight)
        yConstraintRightShoreSup.isActive = true
        
        NSLayoutConstraint.activate([
            leftShore.leftAnchor.constraint(equalTo: view.leftAnchor),
            leftShore.heightAnchor.constraint(equalToConstant: .screenHeight + .twenty),
            
            rightShore.rightAnchor.constraint(equalTo: view.rightAnchor),
            rightShore.heightAnchor.constraint(equalToConstant: .screenHeight + .twenty),
            
            leftShoreSup.leftAnchor.constraint(equalTo: view.leftAnchor),
            leftShoreSup.heightAnchor.constraint(equalToConstant: .screenHeight + .twenty),
            
            rightShoreSup.rightAnchor.constraint(equalTo: view.rightAnchor),
            rightShoreSup.heightAnchor.constraint(equalToConstant: .screenHeight + .twenty)
        ])
        self.view.layoutIfNeeded()
        
        yConstraintLeftShore.constant = .screenHeight + .oneHundred
        yConstraintRightShore.constant = .screenHeight + .oneHundred
        
        UIView.animate(withDuration: 5, delay: 0, options: [.repeat, .curveLinear]) {
            self.view.layoutIfNeeded()
        }
        
        yConstraintLeftShoreSup.constant = .screenHeight + .oneHundred
        yConstraintRightShoreSup.constant = .screenHeight + .oneHundred
        
        UIView.animate(withDuration: 5, delay: 2.5, options: [.curveLinear, .repeat]) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func createObstacle() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [ weak self ] timer in
            guard let self else { return }
            let image = UFOImageView(frame: .zero)
            
            self.view.insertSubview(image, at: 0)
            image.translatesAutoresizingMaskIntoConstraints = false
            
            let constant = CGFloat(Int.random(in: -150...150))
            let yConstraint = image.topAnchor.constraint(equalTo: self.view.topAnchor, constant:  -.oneHundred)
            yConstraint.isActive = true
            
            NSLayoutConstraint.activate([
                image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: constant),
                image.heightAnchor.constraint(equalToConstant: .fifty),
                image.widthAnchor.constraint(equalToConstant: .fifty)
            ])
            self.view.layoutIfNeeded()
            
            yConstraint.constant = .screenHeight + .oneHundred
            
            UIView.animate(withDuration: 5, delay: 0, options: .curveLinear) {
                self.view.layoutIfNeeded()
            }
            startDisplayLink()
        }
    }
    
    //MARK: - Sup func
    func startDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(checkForCollision))
        displayLink?.add(to: .current, forMode: .common)
    }
    
    //MARK: - @objc func
    @objc func checkForCollision() {
        for subview in view.subviews {
            if subview is UFOImageView {
                guard let airplaneFrame = airplaneImage.layer.presentation()?.frame,
                      let UFOFrame = subview.layer.presentation()?.frame else { return }
                
                if airplaneFrame.intersects(UFOFrame) {
                    timer.invalidate()
                    view.subviews.forEach{ $0.layer.removeAllAnimations()}
                    gameOverImage.isHidden = false
                    tryAgainButton.isHidden = false
                    leftButton.isEnabled = false
                    rightButton.isEnabled = false
                }
            }
        }
    }
    
    @objc func actionMoveAirplane(sander: UIButton) {
        let screen = UIScreen.main.bounds.width
        if sander.tag == 0 {
            if counter < screen / 2 - .fiftyFive {
                counter += (screen / 4 - leftShore.bounds.width - 5)
            }
        }
        
        if sander.tag == 1 {
            if counter > -screen / 2 + .fiftyFive {
                counter -= (screen / 4 - leftShore.bounds.width - 5)
            }
        }
        
        self.airplainX?.constant = self.counter
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func actionBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func actionTryAgainButton() {
        for subview in view.subviews {
            if subview is UFOImageView {
                subview.removeFromSuperview()
            }
        }
        leftShoreSup.removeFromSuperview()
        leftShore.removeFromSuperview()
        rightShore.removeFromSuperview()
        rightShoreSup.removeFromSuperview()
        
        view.reloadInputViews()
        animationImage()
        createObstacle()
        gameOverImage.isHidden = true
        tryAgainButton.isHidden = true
        leftButton.isEnabled = true
        rightButton.isEnabled = true
    }
}
