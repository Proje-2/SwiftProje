import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let textField = UITextField()
    let speakButton = UIButton(type: .system)
    let statusLabel = UILabel()
    let speechSynthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    func setupUI() {
        // Metin alanı
        textField.placeholder = "Metin girin"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        
        // Buton
        speakButton.setTitle("Seslendir", for: .normal)
        speakButton.addTarget(self, action: #selector(speakText), for: .touchUpInside)
        speakButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(speakButton)
        
        // Durum etiketi
        statusLabel.text = "Hazır"
        statusLabel.textAlignment = .center
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusLabel)
        
        // Auto Layout
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            textField.widthAnchor.constraint(equalToConstant: 250),
            
            speakButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            speakButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.topAnchor.constraint(equalTo: speakButton.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func speakText() {
        guard let text = textField.text, !text.isEmpty else {
            statusLabel.text = "Lütfen metin girin"
            return
        }
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "tr-TR") // Türkçe seslendirme
        speechSynthesizer.speak(utterance)
        
        statusLabel.text = "Seslendiriliyor..."
    }
}
