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
    
    @IBAction func signUpTapped(_ sender: Any) {
        do  {
            let firstName = try Validation.validationName(name: firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))
            let lastName = try Validation.validationLastName(lastName: lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))
            let email = try Validation.validationEmail(email: emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines))
            let password = try Validation.validationPassword(password: passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines))
            Auth.auth().createUser(withEmail: email, password: password){
                [weak self](result, error) in
                guard let strongSelf = self else {return}
                if error != nil {
                    strongSelf.showError(message: error?.localizedDescription ?? "Error creating user")
                } else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstName":firstName, "lastName":lastName, "uid":result!.user.uid], completion: {
                        error in
                        if error != nil {
                            strongSelf.showError(message: error?.localizedDescription ?? "Error adding user")
                        }
                    })
                    strongSelf.showSuccessVC()
                }
            }
        }
        catch {
            present(error: error as! LocalizedError)
        }
    }
}
