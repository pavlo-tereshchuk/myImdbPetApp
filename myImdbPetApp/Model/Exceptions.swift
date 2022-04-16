//
//  Exceptions.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 10.04.22.
//

import Foundation

enum AuthException: LocalizedError {
    
    case EmptyFields
    case WrongEmail
    case WrongPassword
    case LongPassword
    case ShortPassword
    case InvalidValue
    
    var errorDescription: String?{
        get{
            switch self{
            case .EmptyFields:
                return "Please fill in all the fields"
            case .WrongEmail:
                return "Your email address is wrong"
            case .LongPassword:
                return "Your password is too long"
            case .ShortPassword:
                return "Your password is too short"
            case .WrongPassword:
                return "Your password must contain a special character (!@#$&*), uppercase and a number"
            case .InvalidValue:
                return "Your input is invalid"
            }
        }
    }
}

enum RequestException:LocalizedError{
    
    case dataNotFound(error:String)
    case networkError(error:String)
    case jsonParsingError(error:String)
    
}
