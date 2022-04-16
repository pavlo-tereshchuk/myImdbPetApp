//
//  Validation.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 10.04.22.
//

import Foundation

struct Validation{
    
    static func validationFieldsNotEmpty(name:String?, lastName:String?, email:String?, password:String?) throws {
        guard let name = name, let lastName = lastName, let email = email, let password = password else {
            throw AuthException.InvalidValue
        }
        guard (name == "" || lastName == "" || email == "" || password == "") else {
                    throw AuthException.EmptyFields
        }
    }
    
    static func validationName(name:String?) throws -> String{
        guard let name = name else { throw AuthException.InvalidValue}
        guard name != "" else { throw AuthException.EmptyFields}
        return name
    }
    
    static func validationLastName(lastName:String?) throws -> String{
        guard let lastName = lastName else { throw AuthException.InvalidValue}
        guard lastName != "" else { throw AuthException.EmptyFields}
        guard Utilities.validateEmail(email: lastName) else {throw AuthException.WrongEmail}
        return lastName
    }
    
    static func validationEmail(email:String?) throws -> String{
        guard let email = email else { throw AuthException.InvalidValue}
        guard email != "" else { throw AuthException.EmptyFields}
        guard Utilities.validateEmail(email: email) else {throw AuthException.WrongEmail}
        return email
    }
    
    static func validationPassword(password:String?) throws -> String{
        guard let password = password else { throw AuthException.InvalidValue}
        guard password != "" else { throw AuthException.EmptyFields}
        guard password.count >= 6 else { throw AuthException.ShortPassword}
        guard password.count <= 24 else { throw AuthException.LongPassword}
        guard Utilities.validatePassword(password: password) else { throw AuthException.WrongPassword}
        return password
    }
}
