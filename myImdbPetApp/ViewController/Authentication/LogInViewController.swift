//
//  LogInViewController.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 08.04.22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LogInViewController: BaseAuthViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    func validityCheck() -> Bool {
        var message = ""
        if(emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            message = "Please fill all the fields"
        }
        
        if !Utilities.validateEmail(email: emailField.text!){
            message = "Wrong email"
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
    
    @IBAction func loginTapped(_ sender: Any) {
        if validityCheck() {
            let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().signIn(withEmail: email, password: password){ [weak self] result, error in
                guard let strongSelf = self else { return }
                if error != nil {
                    strongSelf.showError(message: error!.localizedDescription)
                } else {
                    let db = Firestore.firestore()
                    let userInfo = db.collection("users").document(String(result!.user.uid))
                    print(result!.user.uid)
                    userInfo.getDocument{ (document, error) in
                        if let document = document, document.exists {
                            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                            print("Document data: \(dataDescription)")
                            
                        } else {
                            print("Document does not exist")
                        }
                        
                    }
                    strongSelf.showSuccessVC()
                }
                
            }
        }
    }
    
}
