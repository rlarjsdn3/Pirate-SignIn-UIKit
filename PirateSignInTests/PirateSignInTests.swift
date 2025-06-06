//
//  PirateSignInTests.swift
//  PirateSignInTests
//
//  Created by 김건우 on 5/27/25.
//

import Testing
@testable import PirateSignIn

struct PirateSignInTests {

    struct NameValidationTests {

        @Test(
            arguments: [
                "김진",
                "김소월",
                "김문어",
                "흰둥이",
                "시애틀",
                "김예슬이",
                "John",
            ]
        )
        func test_isValidName_returnsTrue_forValidName(_ name: String) throws {
            #expect(name.checkIsValidName == true)
        }

        @Test(
            arguments: [
                "",
                "김 건우",
                "춤추는코요테",
                "John Appleseed"
            ]
        )
        func test_isValidEmailAddress_returnFalse_forInvalidEmail(_ emailAddress: String) throws {
            #expect(emailAddress.checkIsValidName == false)
        }
    }

    struct EmailAddressValidationTests {
        
        @Test(
            arguments: [
                "example@example.com",
                "user.name+tag+sorting@example.com",
                "customer/department=shipping@example.com",
                "firstname-lastname@example.com",
                "niceandsimple@example.com",
                "very.common@example.com",
                "disposable.style.email.with+symbol@example.com",
                "john.doe123@sub.example.co.uk"
            ]
        )
        func test_isValidEmailAddress_returnsTrue_forValidEmail(_ emailAddress: String) throws {
            #expect(emailAddress.checkIsVaildEmailAddress == true)
        }
        
        @Test(
            arguments: [
                "",
                "plainaddress",
                "noatsign.com",
                "@no-local-part.com",
                "username@",
                "username@.com",
                "username@com",
                "user@domain..com",
                ".user@domain.com",
                "user.@domain.com",
                "user name@domain.com",
                "user@-domain.com",
                "user@domain.com-",
                "user@domain..com",
                "user@.domain.com",
                "user@@domain.com",
                "user@domain,com",
                "user@domain@domain.com",
                "usér@domain.com",
                "user@domain.c",
                "user@.com",
                "user@com.",
                "user@sub_domain.com",
            ]
        )
        func test_isValidEmailAddress_returnFalse_forInvalidEmail(_ emailAddress: String) throws {
            #expect(emailAddress.checkIsVaildEmailAddress == false)
        }
    }
    
    struct PasswordValiationTests {
        
        @Test(
            arguments: [
                "Abc!23",
                "A1b2C3#",
                "Xyz@789",
                "QweRtY@9",
                "Valid!Pwd1",
                "Aa1@Aa1@",
                "Abc1234567890!"
            ]
        )
        func test_isValidPassword_reurnTrue_forValidPassword(_ password: String) {
            #expect(password.checkIsValidPassword == true)
        }
        
        @Test(
            arguments: [
                "",
                "abc",
                "abc123",
                "ABC123",
                "Abcdef",
                "Abc!@",
                "ab!23",
                "ABC!23",
                "A!@#Z$",
                "@aaAAAAA"
            ]
        )
        func test_isValidPassword_reurnFalse_forInValidPassword(_ password: String) {
            #expect(password.checkIsValidPassword == false)
        }
    }
    
    
}
