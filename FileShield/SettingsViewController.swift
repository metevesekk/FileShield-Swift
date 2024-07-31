//
//  SettingsViewController.swift
//  FileShield
//
//  Created by Mete Vesek on 31.07.2024.
//

import UIKit

class SettingsViewController: UIViewController {

    // UI Elements
    private let themeLabel = UILabel()
    private let themeSegmentedControl = UISegmentedControl(items: ["Light", "Dark", "Sepia"])
    
    private let languageLabel = UILabel()
    private let languageSegmentedControl = UISegmentedControl(items: ["English", "French", "German", "Spanish", "Portuguese", "Japanese", "Turkish"])
    
    private let userManualButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Settings"
        
        // Theme Label
        themeLabel.text = "Theme"
        themeLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        view.addSubview(themeLabel)
        
        // Theme Segmented Control
        themeSegmentedControl.selectedSegmentIndex = 0
        themeSegmentedControl.addTarget(self, action: #selector(themeChanged), for: .valueChanged)
        view.addSubview(themeSegmentedControl)
        
        // Language Label
        languageLabel.text = "Language"
        languageLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        view.addSubview(languageLabel)
        
        // Language Segmented Control
        languageSegmentedControl.selectedSegmentIndex = 0
        languageSegmentedControl.addTarget(self, action: #selector(languageChanged), for: .valueChanged)
        view.addSubview(languageSegmentedControl)
        
        // User Manual Button
        userManualButton.setTitle("User Manual", for: .normal)
        userManualButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        userManualButton.setTitleColor(.systemBlue, for: .normal)
        userManualButton.addTarget(self, action: #selector(openUserManual), for: .touchUpInside)
        view.addSubview(userManualButton)
    }
    
    private func setupConstraints() {
        themeLabel.translatesAutoresizingMaskIntoConstraints = false
        themeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        languageSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        userManualButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints for themeLabel
        NSLayoutConstraint.activate([
            themeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            themeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        // Set constraints for themeSegmentedControl
        NSLayoutConstraint.activate([
            themeSegmentedControl.topAnchor.constraint(equalTo: themeLabel.bottomAnchor, constant: 10),
            themeSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            themeSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Set constraints for languageLabel
        NSLayoutConstraint.activate([
            languageLabel.topAnchor.constraint(equalTo: themeSegmentedControl.bottomAnchor, constant: 30),
            languageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        // Set constraints for languageSegmentedControl
        NSLayoutConstraint.activate([
            languageSegmentedControl.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: 10),
            languageSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            languageSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Set constraints for userManualButton
        NSLayoutConstraint.activate([
            userManualButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            userManualButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func themeChanged() {
        // Handle theme change
        let selectedTheme = themeSegmentedControl.selectedSegmentIndex
        // Add code to change theme based on selectedTheme
    }
    
    @objc private func languageChanged() {
        // Handle language change
        let selectedLanguage = languageSegmentedControl.selectedSegmentIndex
        // Add code to change language based on selectedLanguage
    }
    
    @objc private func openUserManual() {
        // Action to open user manual as a scrollable pop-up
        let userManualViewController = UserManualViewController()
        userManualViewController.modalPresentationStyle = .overFullScreen
        present(userManualViewController, animated: true, completion: nil)
    }
}


