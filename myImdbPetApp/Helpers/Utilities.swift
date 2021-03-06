//
//  Utilities.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 06.04.22.
//

import Foundation
import UIKit

public class Utilities {
//    MARK: - Validating user credentials while authenticating
    public static func validatePassword(password:String)-> Bool{
        return NSRegularExpression("^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$&*]).{6,24}$").matches(password)
    }
    
    public static func validateEmail(email: String) -> Bool {
        return NSRegularExpression("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").matches(email)
    }
}
