//
//  AuthnticationTest.swift
//  myImdbPetAppTests
//
//  Created by Pavlo Tereshchuk on 10.04.22.
//

@testable import myImdbPetApp
import XCTest


class AuthnticationTest: XCTestCase {
    
    override class func setUp(){
        super.setUp()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    func test_name_validity() throws {
        XCTAssertNoThrow(  try Validation.validationName(name: "Pavlo"))
    }
    
    
    func test_ivalidvalue_exception_is_thrown() throws {
        let expectedException = AuthException.InvalidValue
        var error:AuthException?
        
        XCTAssertThrowsError(try Validation.validationName(name: nil)){
            thrownError in
            error = thrownError as? AuthException
        }
        
        XCTAssertEqual(expectedException, error)
    }
    
    
    func test_longpassword_exception_is_thrown() throws {
        let expectedException = AuthException.LongPassword
        var error:AuthException?
        
        let password = "12345678912345678912345678"
        XCTAssertTrue(password.count == 26)
        
        XCTAssertThrowsError(try Validation.validationName(name: password)){
            thrownError in
            error = thrownError as? AuthException
        }
        
        XCTAssertEqual(expectedException, error)
    }
    
    func test_email_Validity(){
        XCTAssertThrowsError(try Validation.validationEmail(email: "sdvds@‚dfdsf"))
    }
    
    func test_email_empty(){
        XCTAssertThrowsError(try Validation.validationEmail(email: ""))
    }

    
    
    
    
    
    
}
