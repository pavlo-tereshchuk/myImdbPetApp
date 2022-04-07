//
//  Utilities.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 06.04.22.
//

import Foundation
import UIKit

public class Utilities {
    
    public static func blurryButton(button:UIButton){
        let blur = UIVisualEffectView(effect: UIBlurEffect(style:
                    UIBlurEffect.Style.light))
        blur.frame = button.bounds
        blur.isUserInteractionEnabled = false //This allows touches to forward to the button.
        button.insertSubview(blur, at: 0)
    }
    
    public static func validatePassword(password:String)-> Bool{
        let regex = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$&*]).{6,24}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
    }
    
    public static func validateEmail(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: email)
    }
}
