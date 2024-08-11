import UIKit
import CommonCrypto

class MainViewController: UIViewController, UIDocumentPickerDelegate {
    
    // UI Elements
    var filePathTextField: UITextField!
    var passwordTextField: UITextField!
    var confirmPasswordTextField: UITextField!
    var algorithmSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
        setupUI()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupUI() {
        
        // Big Encrypt Icon Button
        let bigEncryptButton = UIButton(type: .system)
        bigEncryptButton.setImage(UIImage(systemName: "lock.shield.fill"), for: .normal)
        bigEncryptButton.tintColor = .white
        bigEncryptButton.transform = CGAffineTransform(scaleX: 3, y: 3) // Scale up the icon size
        bigEncryptButton.isUserInteractionEnabled = false // Disable interaction
        bigEncryptButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bigEncryptButton)
        
        // Title Label
        let titleLabel = UILabel()
        titleLabel.text = "FileShield"
        titleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 48)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        
        // File Path TextField
        filePathTextField = UITextField()
        filePathTextField.placeholder = "Select File"
        filePathTextField.font = UIFont(name: "AvenirNext-Regular", size: 16)
        filePathTextField.textColor = .white
        filePathTextField.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        filePathTextField.borderStyle = .roundedRect
        filePathTextField.attributedPlaceholder = NSAttributedString(string: "Select File", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        filePathTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filePathTextField)
        
        // Setting a fixed width for the filePathTextField
        let fixedWidth: CGFloat = 200 // Set the desired width here
        NSLayoutConstraint.activate([
            filePathTextField.widthAnchor.constraint(equalToConstant: fixedWidth)
        ])
        
        // Browse Button with Icon
        let browseButton = UIButton(type: .system)
        browseButton.setTitle(" Browse", for: .normal)
        browseButton.setTitleColor(.white, for: .normal)
        browseButton.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 18)
        browseButton.setImage(UIImage(systemName: "folder"), for: .normal)
        browseButton.tintColor = .white
        browseButton.semanticContentAttribute = .forceRightToLeft
        browseButton.addTarget(self, action: #selector(selectFile), for: .touchUpInside)
        browseButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(browseButton)
        
        // Password TextField
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont(name: "AvenirNext-Regular", size: 16)
        passwordTextField.textColor = .white
        passwordTextField.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        // Confirm Password TextField
        confirmPasswordTextField = UITextField()
        confirmPasswordTextField.placeholder = "Confirm Password"
        confirmPasswordTextField.font = UIFont(name: "AvenirNext-Regular", size: 16)
        confirmPasswordTextField.textColor = .white
        confirmPasswordTextField.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.borderStyle = .roundedRect
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(confirmPasswordTextField)
        
        // Algorithm Segmented Control
        algorithmSegmentedControl = UISegmentedControl(items: ["AES", "DES", "Blowfish"])
        algorithmSegmentedControl.selectedSegmentIndex = 0
        algorithmSegmentedControl.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)

        // Normal durum için font ayarı
        let normalFont = UIFont(name: "HelveticaNeue-Light", size: 16) ?? UIFont.systemFont(ofSize: 18)
        algorithmSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: normalFont], for: .normal)

        // Seçili durum için font ayarı
        let selectedFont = UIFont(name: "AvenirNext-Bold", size: 16) ?? UIFont.boldSystemFont(ofSize: 18)
        algorithmSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: selectedFont], for: .selected)

        algorithmSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(algorithmSegmentedControl)

        
        // Encrypt Button with Icon
        let encryptButton = UIButton(type: .system)
        encryptButton.setTitle(" Encrypt", for: .normal)
        encryptButton.setTitleColor(.white, for: .normal)
        encryptButton.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 18)
        encryptButton.setImage(UIImage(systemName: "lock.shield"), for: .normal)
        encryptButton.tintColor = .white
        encryptButton.semanticContentAttribute = .forceRightToLeft
        encryptButton.addTarget(self, action: #selector(encryptFile), for: .touchUpInside)
        encryptButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(encryptButton)
        
        // Decrypt Button with Icon
        let decryptButton = UIButton(type: .system)
        decryptButton.setTitle(" Decrypt", for: .normal)
        decryptButton.setTitleColor(.white, for: .normal)
        decryptButton.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 18)
        decryptButton.setImage(UIImage(systemName: "key"), for: .normal) // Changed icon to "key"
        decryptButton.tintColor = .white
        decryptButton.semanticContentAttribute = .forceRightToLeft
        decryptButton.addTarget(self, action: #selector(decryptFile), for: .touchUpInside)
        decryptButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(decryptButton)
        
        // Layout Constraints
        NSLayoutConstraint.activate([
           
            
            bigEncryptButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            bigEncryptButton.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -40),
            bigEncryptButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: bigEncryptButton.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            filePathTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            filePathTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            filePathTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -140),
            
            browseButton.centerYAnchor.constraint(equalTo: filePathTextField.centerYAnchor),
            browseButton.leadingAnchor.constraint(equalTo: filePathTextField.trailingAnchor, constant: 10),
            browseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            passwordTextField.topAnchor.constraint(equalTo: filePathTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            algorithmSegmentedControl.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 20),
            algorithmSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            algorithmSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            encryptButton.topAnchor.constraint(equalTo: algorithmSegmentedControl.bottomAnchor, constant: 20),
            encryptButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -12),
            
            decryptButton.topAnchor.constraint(equalTo: algorithmSegmentedControl.bottomAnchor, constant: 20),
            decryptButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 12),
            
        ])
        
        // Adjust the window size and disable resizing
        view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
        view.autoresizingMask = []

    }
    
    @objc func selectFile() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.data], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let selectedFileURL = urls.first {
            filePathTextField.text = selectedFileURL.path
        }
    }
    
    @objc func encryptFile() {
        guard let filePath = filePathTextField.text, !filePath.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, confirmPassword == password else {
            showAlert(message: "Please ensure all fields are filled correctly.")
            return
        }
        
        let algorithm = algorithmSegmentedControl.titleForSegment(at: algorithmSegmentedControl.selectedSegmentIndex) ?? "AES"
        
        do {
            let fileData = try Data(contentsOf: URL(fileURLWithPath: filePath))
            let key = Data(password.utf8).sha256()
            
            var encryptedData: Data?
            
            switch algorithm {
            case "AES":
                encryptedData = aesEncrypt(data: fileData, key: key)
            case "DES":
                encryptedData = desEncrypt(data: fileData, key: key)
            case "Blowfish":
                encryptedData = blowfishEncrypt(data: fileData, key: key)
            default:
                showAlert(message: "Unsupported algorithm selected.")
                return
            }
            
            if let encryptedData = encryptedData {
                let encryptedFilePath = URL(fileURLWithPath: filePath).deletingPathExtension().appendingPathExtension("enc")
                try encryptedData.write(to: encryptedFilePath)
                showAlert(message: "File encrypted successfully using \(algorithm). Saved to \(encryptedFilePath.path).")
            } else {
                showAlert(message: "Encryption failed.")
            }
        } catch {
            showAlert(message: "File encryption failed: \(error.localizedDescription)")
        }
    }
    
    @objc func decryptFile() {
        guard let filePath = filePathTextField.text, !filePath.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please ensure all fields are filled correctly.")
            return
        }
        
        let algorithm = algorithmSegmentedControl.titleForSegment(at: algorithmSegmentedControl.selectedSegmentIndex) ?? "AES"
        
        do {
            let encryptedData = try Data(contentsOf: URL(fileURLWithPath: filePath))
            let key = Data(password.utf8).sha256()
            
            var decryptedData: Data?
            
            switch algorithm {
            case "AES":
                decryptedData = aesDecrypt(data: encryptedData, key: key)
            case "DES":
                decryptedData = desDecrypt(data: encryptedData, key: key)
            case "Blowfish":
                decryptedData = blowfishDecrypt(data: encryptedData, key: key)
            default:
                showAlert(message: "Unsupported algorithm selected.")
                return
            }
            
            if let decryptedData = decryptedData {
                let decryptedFilePath = URL(fileURLWithPath: filePath).deletingPathExtension().appendingPathExtension("dec")
                try decryptedData.write(to: decryptedFilePath)
                showAlert(message: "File decrypted successfully using \(algorithm). Saved to \(decryptedFilePath.path).")
            } else {
                showAlert(message: "Decryption failed.")
            }
        } catch {
            showAlert(message: "File decryption failed: \(error.localizedDescription)")
        }
    }
    
    @objc func closeApp() {
        exit(0) // Exits the application
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // AES Encryption and Decryption Functions
    func aesEncrypt(data: Data, key: Data) -> Data? {
        return crypt(data: data, key: key, algorithm: CCAlgorithm(kCCAlgorithmAES))
    }
    
    func aesDecrypt(data: Data, key: Data) -> Data? {
        return crypt(data: data, key: key, algorithm: CCAlgorithm(kCCAlgorithmAES), operation: CCOperation(kCCDecrypt))
    }
    
    // DES Encryption and Decryption Functions
    func desEncrypt(data: Data, key: Data) -> Data? {
        return crypt(data: data, key: key, algorithm: CCAlgorithm(kCCAlgorithmDES))
    }
    
    func desDecrypt(data: Data, key: Data) -> Data? {
        return crypt(data: data, key: key, algorithm: CCAlgorithm(kCCAlgorithmDES), operation: CCOperation(kCCDecrypt))
    }
    
    // Blowfish Encryption and Decryption Functions
    func blowfishEncrypt(data: Data, key: Data) -> Data? {
        return crypt(data: data, key: key, algorithm: CCAlgorithm(kCCAlgorithmBlowfish))
    }
    
    func blowfishDecrypt(data: Data, key: Data) -> Data? {
        return crypt(data: data, key: key, algorithm: CCAlgorithm(kCCAlgorithmBlowfish), operation: CCOperation(kCCDecrypt))
    }
    
    // Common Crypt Function
    func crypt(data: Data, key: Data, algorithm: CCAlgorithm, operation: CCOperation = CCOperation(kCCEncrypt)) -> Data? {
        var keyLength = 0
        switch algorithm {
        case CCAlgorithm(kCCAlgorithmAES):
            keyLength = kCCKeySizeAES256
        case CCAlgorithm(kCCAlgorithmDES):
            keyLength = kCCKeySizeDES
        case CCAlgorithm(kCCAlgorithmBlowfish):
            keyLength = kCCKeySizeMaxBlowfish
        default:
            return nil
        }
        
        var numBytesEncrypted: size_t = 0
        let dataOut = UnsafeMutableRawPointer.allocate(byteCount: data.count + kCCBlockSizeAES128, alignment: 1)
        defer { dataOut.deallocate() }
        
        let cryptStatus = data.withUnsafeBytes { dataBytes in
            key.withUnsafeBytes { keyBytes in
                CCCrypt(
                    operation,
                    algorithm,
                    CCOptions(kCCOptionPKCS7Padding),
                    keyBytes.baseAddress, keyLength,
                    nil,
                    dataBytes.baseAddress, data.count,
                    dataOut, data.count + kCCBlockSizeAES128,
                    &numBytesEncrypted
                )
            }
        }
        
        if cryptStatus == kCCSuccess {
            return Data(bytes: dataOut, count: numBytesEncrypted)
        } else {
            return nil
        }
    }
}

extension Data {
    func sha256() -> Data {
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        self.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(self.count), &hash)
        }
        return Data(hash)
    }
}
