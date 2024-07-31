//
//  ViewController.swift
//  FileShield
//
//  Created by Mete Vesek on 31.07.2024.
//

import UIKit

class MainViewController: UIViewController {

    // UI Elements
    private let dragAndDropView = UIView()
    private let encryptButton = UIButton(type: .system)
    private let decryptButton = UIButton(type: .system)
    private let settingsButton = UIButton(type: .system) // Settings button
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        // Set the main view's background color
        view.backgroundColor = .white
        title = "FileShield" // Set the title for the navigation bar
        
        // Drag and Drop View
        dragAndDropView.backgroundColor = UIColor.systemGray5
        dragAndDropView.layer.cornerRadius = 10
        dragAndDropView.layer.borderWidth = 2
        dragAndDropView.layer.borderColor = UIColor.systemGray.cgColor
        view.addSubview(dragAndDropView)
        
        // Encrypt Button
        encryptButton.setTitle("Encrypt", for: .normal)
        encryptButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        encryptButton.backgroundColor = .systemBlue
        encryptButton.setTitleColor(.white, for: .normal)
        encryptButton.layer.cornerRadius = 8
        view.addSubview(encryptButton)
        
        // Decrypt Button
        decryptButton.setTitle("Decrypt", for: .normal)
        decryptButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        decryptButton.backgroundColor = .systemGreen
        decryptButton.setTitleColor(.white, for: .normal)
        decryptButton.layer.cornerRadius = 8
        view.addSubview(decryptButton)
        
        // Settings Button
        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        settingsButton.setTitleColor(.systemBlue, for: .normal)
        settingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        view.addSubview(settingsButton)
    }
    
    private func setupConstraints() {
        dragAndDropView.translatesAutoresizingMaskIntoConstraints = false
        encryptButton.translatesAutoresizingMaskIntoConstraints = false
        decryptButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints for dragAndDropView
        NSLayoutConstraint.activate([
            dragAndDropView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dragAndDropView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            dragAndDropView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            dragAndDropView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // Set constraints for encryptButton
        NSLayoutConstraint.activate([
            encryptButton.topAnchor.constraint(equalTo: dragAndDropView.bottomAnchor, constant: 30),
            encryptButton.leadingAnchor.constraint(equalTo: dragAndDropView.leadingAnchor),
            encryptButton.widthAnchor.constraint(equalTo: dragAndDropView.widthAnchor, multiplier: 0.45),
            encryptButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Set constraints for decryptButton
        NSLayoutConstraint.activate([
            decryptButton.topAnchor.constraint(equalTo: dragAndDropView.bottomAnchor, constant: 30),
            decryptButton.trailingAnchor.constraint(equalTo: dragAndDropView.trailingAnchor),
            decryptButton.widthAnchor.constraint(equalTo: dragAndDropView.widthAnchor, multiplier: 0.45),
            decryptButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Set constraints for settingsButton
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            settingsButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func openSettings() {
        // Action to open settings view controller
        let settingsViewController = SettingsViewController()
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
}
