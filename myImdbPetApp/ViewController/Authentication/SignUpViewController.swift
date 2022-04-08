//
//  SIgnUpViewController.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 06.04.22.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: BaseAuthViewController {
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    

    func setUp(){
        errorLabel.alpha = 0
    }
    
    func validityCheck() -> Bool {
        var message = ""
        if(firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            message = "Please fill all the fields"
        }
        
        if !Utilities.validateEmail(email: emailField.text!){
            message = "Wrong email"
        }
        
        if !Utilities.validatePassword(password: passwordField.text!){
            message = "Your password must contain a special character (!@#$&*), uppercase and a number"
        }
        
        if let length = passwordField.text?.count, length < 6 {
            message = "Your password must contain at least 6 symbols"
        }
        
        
        
        if (message == "") {
            errorLabel.alpha = 0
            return true
        }
        showError(message: message)
        return false
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        if validityCheck(){
            let firstName = firstNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: email, password: password){
                [weak self](result, error) in
                guard let strongSelf = self else {return}
                if error != nil {
                    strongSelf.showError(message: "Error creating user")
                } else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstName":firstName, "lastName":lastName, "uid":result!.user.uid], completion: {
                        error in
                        if error != nil {
                            strongSelf.showError(message: "User was not added to db")
                        }
                    })
                    strongSelf.showSuccessVC()
                }
            }
        }
    }
}
