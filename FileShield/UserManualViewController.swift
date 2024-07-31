//
//  UserManualViewController.swift
//  FileShield
//
//  Created by Mete Vesek on 31.07.2024.
//

import UIKit

class UserManualViewController: UIViewController {

    // UI Elements
    private let scrollView = UIScrollView()
    private let manualTextView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        loadUserManualContent()
    }

    private func setupUI() {
        // Background dimming
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        // ScrollView setup
        scrollView.backgroundColor = .white
        scrollView.layer.cornerRadius = 10
        scrollView.layer.masksToBounds = true
        view.addSubview(scrollView)
        
        // Manual TextView setup
        manualTextView.isEditable = false
        manualTextView.font = UIFont.systemFont(ofSize: 16)
        manualTextView.textColor = .black
        scrollView.addSubview(manualTextView)
        
        // Add tap gesture to dismiss the pop-up when tapping outside
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        manualTextView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints for scrollView
        NSLayoutConstraint.activate([
            scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
        ])
        
        // Set constraints for manualTextView
        NSLayoutConstraint.activate([
            manualTextView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            manualTextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            manualTextView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            manualTextView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
    
    private func loadUserManualContent() {
        // Load the user manual content based on the selected language
        // For example, you can load it from a file or hardcode it for testing
        let selectedLanguage = "en" // This should be dynamically selected
        if let manualFilePath = Bundle.main.path(forResource: "UserManual_\(selectedLanguage)", ofType: "md") {
            if let manualContent = try? String(contentsOfFile: manualFilePath) {
                manualTextView.text = manualContent
            }
        } else {
            manualTextView.text = "User manual content is not available."
        }
    }
    
    @objc private func dismissPopUp() {
        dismiss(animated: true, completion: nil)
    }
}
