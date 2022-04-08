//
//  BaseAuthViewController.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 08.04.22.
//

import Foundation
import UIKit

class BaseAuthViewController: UIViewController{
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    
    func showError(message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }

    func showSuccessVC(){
        let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboards.SuccessfulAuthVC)
        navigationController?.pushViewController(vc!, animated: true)
    }
}
