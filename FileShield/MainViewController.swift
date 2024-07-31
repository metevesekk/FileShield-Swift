import UIKit

class MainViewController: UIViewController {

    // UI Elements
    private let filePathView = UIView()
    private let filePathLabel = UILabel() // Label to display the file path
    private let clearButton = UIButton(type: .system) // Button to clear the file path label
    private let selectFileButton = UIButton(type: .system) // Button to select a file manually
    private let encryptButton = UIButton(type: .system)
    private let decryptButton = UIButton(type: .system)
    private let settingsButton = UIButton(type: .system) // Settings button
    
    private let passwordTextField = UITextField() // Password text field
    private let confirmPasswordTextField = UITextField() // Confirm password text field
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        customizeNavigationBar()

    }
    
    private func customizeNavigationBar() {
        // Set the title with a custom font and size
        let titleLabel = UILabel()
        titleLabel.text = "FileShield"
        titleLabel.font = UIFont.systemFont(ofSize: 40, weight: .semibold) // Modern font and weight
        titleLabel.textColor = UIColor.systemYellow // Customize the color to fit the modern theme
        titleLabel.textAlignment = .center
        
        // Use the titleLabel as the title view of the navigation item
        navigationItem.titleView = titleLabel
        
        // Optional: Customize the navigation bar's background color
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setupUI() {
        // Set the main view's background color
        view.backgroundColor = .white
        // title = "FileShield" // Set the title for the navigation bar
        
        // File Path View
        filePathView.backgroundColor = UIColor.systemGray5
        filePathView.layer.cornerRadius = 10
        filePathView.layer.borderWidth = 0
        filePathView.layer.cornerRadius = 0

        filePathView.layer.borderColor = UIColor.systemGray.cgColor
        view.addSubview(filePathView)
        
        // File Path Label
        filePathLabel.text = "Select a file"
        filePathLabel.font = UIFont.systemFont(ofSize: 14)
        filePathLabel.textAlignment = .center
        filePathLabel.textColor = .darkGray
        filePathView.addSubview(filePathLabel)
        
        // Clear Button
        clearButton.setImage(UIImage(named: "clearIcon")?.withRenderingMode(.alwaysOriginal), for: .normal) // Set image for clear button
        clearButton.imageView?.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(clearFilePath), for: .touchUpInside)
        view.addSubview(clearButton)
        
        // Select File Button
        selectFileButton.setImage(UIImage(named: "selectFileIcon")?.withRenderingMode(.alwaysOriginal), for: .normal) // Set image for select file button
        selectFileButton.imageView?.contentMode = .scaleAspectFit
        selectFileButton.addTarget(self, action: #selector(selectFile), for: .touchUpInside)
        view.addSubview(selectFileButton)
        
        // Password TextField
        passwordTextField.placeholder = "Enter password"
        passwordTextField.isSecureTextEntry = true // Hide input with dots
        passwordTextField.borderStyle = .roundedRect
        view.addSubview(passwordTextField)
        
        // Confirm Password TextField
        confirmPasswordTextField.placeholder = "Confirm password"
        confirmPasswordTextField.isSecureTextEntry = true // Hide input with dots
        confirmPasswordTextField.borderStyle = .roundedRect
        view.addSubview(confirmPasswordTextField)
        
        // Encrypt Button
        encryptButton.setImage(UIImage(named: "encryptIcon")?.withRenderingMode(.alwaysOriginal), for: .normal) // Set image for encrypt button
        encryptButton.imageView?.contentMode = .scaleAspectFit
        encryptButton.backgroundColor = .systemBackground
        encryptButton.layer.cornerRadius = 8
        view.addSubview(encryptButton)
        
        // Decrypt Button
        decryptButton.setImage(UIImage(named: "decryptIcon")?.withRenderingMode(.alwaysOriginal), for: .normal) // Set image for decrypt button
        decryptButton.imageView?.contentMode = .scaleAspectFit
        decryptButton.backgroundColor = .systemBackground
        decryptButton.layer.cornerRadius = 8
        view.addSubview(decryptButton)
        
        // Settings Button
        settingsButton.setImage(UIImage(named: "settingsIcon")?.withRenderingMode(.alwaysOriginal), for: .normal) // Set image for settings button
        settingsButton.imageView?.contentMode = .scaleAspectFit
        settingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        view.addSubview(settingsButton)
    }
    
    private func setupConstraints() {
        filePathView.translatesAutoresizingMaskIntoConstraints = false
        filePathLabel.translatesAutoresizingMaskIntoConstraints = false
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        selectFileButton.translatesAutoresizingMaskIntoConstraints = false
        encryptButton.translatesAutoresizingMaskIntoConstraints = false
        decryptButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints for filePathView
        NSLayoutConstraint.activate([
            filePathView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filePathView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            filePathView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            filePathView.heightAnchor.constraint(equalToConstant: 40) // Single line height
        ])
        
        // Set constraints for filePathLabel
        NSLayoutConstraint.activate([
            filePathLabel.centerXAnchor.constraint(equalTo: filePathView.centerXAnchor),
            filePathLabel.centerYAnchor.constraint(equalTo: filePathView.centerYAnchor),
            filePathLabel.widthAnchor.constraint(equalTo: filePathView.widthAnchor, multiplier: 0.9),
            filePathLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // Set constraints for passwordTextField
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: filePathView.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: filePathView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: filePathView.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Set constraints for confirmPasswordTextField
        NSLayoutConstraint.activate([
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: filePathView.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: filePathView.trailingAnchor),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Set constraints for encryptButton
        NSLayoutConstraint.activate([
            encryptButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 10),
            encryptButton.leadingAnchor.constraint(equalTo: filePathView.leadingAnchor),
            encryptButton.widthAnchor.constraint(equalTo: filePathView.widthAnchor, multiplier: 0.45),
            encryptButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Set constraints for decryptButton
        NSLayoutConstraint.activate([
            decryptButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 10),
            decryptButton.trailingAnchor.constraint(equalTo: filePathView.trailingAnchor),
            decryptButton.widthAnchor.constraint(equalTo: filePathView.widthAnchor, multiplier: 0.45),
            decryptButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Set constraints for clearButton
        NSLayoutConstraint.activate([
            clearButton.centerYAnchor.constraint(equalTo: filePathView.centerYAnchor),
            clearButton.leadingAnchor.constraint(equalTo: filePathView.trailingAnchor, constant: 10),
            clearButton.widthAnchor.constraint(equalToConstant: 50),
            clearButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Set constraints for selectFileButton
        NSLayoutConstraint.activate([
            selectFileButton.centerYAnchor.constraint(equalTo: filePathView.centerYAnchor),
            selectFileButton.trailingAnchor.constraint(equalTo: filePathView.leadingAnchor, constant: -10),
            selectFileButton.widthAnchor.constraint(equalToConstant: 50),
            selectFileButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Set constraints for settingsButton
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            settingsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 225),
            settingsButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func clearFilePath() {
        filePathLabel.text = "Select a file"
    }
    
    @objc private func selectFile() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.item], asCopy: true)
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    @objc private func openSettings() {
        let settingsViewController = SettingsViewController()
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
}

extension MainViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let selectedFileURL = urls.first {
            filePathLabel.text = selectedFileURL.path
        }
    }
}
