//
//  ViewController.swift
//  textFieldsExample
//
//  Created by Jade Oliveira on 02/10/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    var textFields: [UITextField] = []
    @IBOutlet var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFields = [nameTextField, emailTextField, passwordTextField, confirmPasswordTextField]
        configTextFields(textField: nameTextField, placeholder: "Digite seu nome", keyboard: .alphabet, isSecure: false)
        configTextFields(textField: emailTextField, placeholder: "Digite seu email", keyboard: .emailAddress, isSecure: false)
        configTextFields(textField: passwordTextField, placeholder: "Digite sua senha", keyboard: .default, isSecure: true)
        configTextFields(textField: confirmPasswordTextField, placeholder: "Confirme sua senha", keyboard: .default, isSecure: true)
        setupInitialBorders()
    }
    
    // NOVO: Função para dar uma borda inicial cinza
    func setupInitialBorders() {
        for textField in textFields {
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.cornerRadius = 5.0
        }
    }
    
    private func configTextFields(textField: UITextField, placeholder: String, keyboard: UIKeyboardType, isSecure: Bool) {
        textField.placeholder = placeholder
        textField.keyboardType = keyboard
        textField.isSecureTextEntry = isSecure
        textField.autocorrectionType = .no
        
//        Assinando o protocolo
        textField.delegate = self
    }
    
    func validatePassword() {
        // 1. Obtém os textos
            let password = passwordTextField.text ?? ""
            let confirmPassword = confirmPasswordTextField.text ?? ""
            
            //  Checagem de comparação
            if password != confirmPassword {
                
                // Aplica a borda vermelha nos campos de senha
                passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
                passwordTextField.layer.borderWidth = 2.0
                
                confirmPasswordTextField.layer.borderColor = UIColor.systemRed.cgColor
                confirmPasswordTextField.layer.borderWidth = 2.0
                
                // Exibe uma mensagem de erro
                print("Erro: As senhas não coincidem ou estão vazias.")
                
            } else {
                passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
                passwordTextField.layer.borderWidth = 1.0
                confirmPasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
                confirmPasswordTextField.layer.borderWidth = 1.0
            }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        // 2. Mudar a cor da borda do textField ATUAL (o que foi selecionado)
                textField.layer.borderColor = UIColor.systemBlue.cgColor
                textField.layer.borderWidth = 2.0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // 1. Limpa espaços em branco e verifica se o campo está vazio
                let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                
                if text.isEmpty {
                    textField.layer.borderColor = UIColor.systemRed.cgColor
                    textField.layer.borderWidth = 2.0
                } else {
                    textField.layer.borderColor = UIColor.lightGray.cgColor
                    textField.layer.borderWidth = 1.0
                }
        validatePassword()
    }
}
