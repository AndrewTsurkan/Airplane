//
//  RecordViewController.swift
//  AirplanAston
//
//  Created by Андрей Цуркан on 10.10.2023.
//

import UIKit

class RecordViewController: UIViewController {
    //MARK: - Property
    var recordsTableView = UITableView()
    var customNavigationBar = UIView()
    var titleLabel = UILabel()
    private lazy var backScreenButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backScreen"), for: .normal)
        button.tag = 2
        button.addTarget(self, action: #selector(returnToPreviousScreen), for: .touchUpInside)
        return button
    }()
    
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRecordsTableView()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
    }
    //MARK: - Func
    func setupRecordsTableView() {
        view.addSubview(recordsTableView)
        recordsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        recordsTableView.dataSource = self
        recordsTableView.delegate = self
        recordsTableView.register(RecordsCell.self, forCellReuseIdentifier: RecordsCell.identifier)
        
        recordsTableView.separatorColor = .white
        
        
        NSLayoutConstraint.activate([
            
            recordsTableView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            recordsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            recordsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            recordsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    func setupView() {
        view.addSubview(customNavigationBar)
        customNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        customNavigationBar.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        customNavigationBar.addSubview(backScreenButton)
        backScreenButton.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Records"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        
        NSLayoutConstraint.activate([
            customNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            customNavigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            customNavigationBar.heightAnchor.constraint(equalToConstant: 60),
            
            backScreenButton.topAnchor.constraint(equalTo: customNavigationBar.topAnchor),
            backScreenButton.leftAnchor.constraint(equalTo: customNavigationBar.leftAnchor, constant: 10),
            backScreenButton.widthAnchor.constraint(equalToConstant: 30),
            backScreenButton.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.topAnchor.constraint(equalTo: backScreenButton.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: customNavigationBar.leftAnchor, constant: 10)])
    }
    
    @objc private func returnToPreviousScreen() {
        navigationController?.popViewController(animated: true)
    }
}
//MARK: - extension UITableViewDelegate, UITableViewDataSource
extension RecordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordsCell.identifier, for: indexPath) as? RecordsCell else { return UITableViewCell() }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    
}
