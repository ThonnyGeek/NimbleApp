//
//  AuthProcessTests.swift
//  NimbleAppTests
//
//  Created by Thony Gonzalez on 6/11/23.
//

import XCTest
@testable import NimbleApp
import Combine
import Alamofire

class MockAuthService: AuthServiceProtocol {
    func login(params: Parameters) -> AnyPublisher<LoginResponse, Never> {
        Just(LoginResponse(data: LoginData(id: "1", type: "12", attributes: LoginDataAttributes(accessToken: "", tokenType: "", expiresIn: 1, refreshToken: "", createdAt: 1))))
//            .compactMap { $0}
            .eraseToAnyPublisher()
    }
    
    func passwordRecovery(email: String) -> AnyPublisher<PasswordRecoveryResponse, Never> {
        Just(PasswordRecoveryResponse(meta: PasswordRecoveryMeta(message: "Done")))
            .eraseToAnyPublisher()
    }
}

class MockAuthServiceFailure: AuthServiceProtocol {
    
    let error = ResponseError(detail: "Error detail", code: "Code")
    
    func login(params: Parameters) -> AnyPublisher<LoginResponse, Never> {
        Just(LoginResponse(errors: [error]))
//            .compactMap { $0}
            .eraseToAnyPublisher()
    }
    
    func passwordRecovery(email: String) -> AnyPublisher<PasswordRecoveryResponse, Never> {
        Just(PasswordRecoveryResponse(errors: [error]))
            .eraseToAnyPublisher()
    }
}

final class AuthProcess_Tests: XCTestCase {

    var viewModel: MainViewModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = MainViewModel(welcomeFlowState: WelcomeFlowState(), authService: MockAuthService())
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        UserManager.shared.logout()
    }
    
    func testCorrectEmailAndPasswordTextCheck() {
        //Given (Arragnge)
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        let expect = XCTestExpectation(description: "Async operation")
        let emailText = "qwerty123@qw12.qa"
        let passwordText = "12345678"
        
        //When (Act)
        vm.emailText = emailText
        vm.passwordText = passwordText
        vm.checkTextFields()
        DispatchQueue.main.async {
            expect.fulfill()
        }
        
        
        //Then (Assert)
        wait(for: [expect], timeout: 1)
        XCTAssertTrue(vm.emailIsValid)
        XCTAssertTrue(vm.passwordIsValid)
        XCTAssertFalse(vm.loginButtonIsDisabled)
    }

    func test_WrongEmail() {
        //Given (Arragnge)
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        let expect = XCTestExpectation(description: "Async operation")
        let wrongEmail = "qwerty123@qw12.q!@a."
        
        //When (Act)
        vm.emailText = wrongEmail
        vm.checkEmailText()
        DispatchQueue.main.async {
            expect.fulfill()
        }
        
        
        //Then (Assert)
        wait(for: [expect], timeout: 1)
        XCTAssertFalse(vm.emailIsValid)
    }
    
    func test_EmptyEmailAndPassword() {
        //Given (Arragnge)
        
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        let emailText = ""
        let passwordText = ""
        
        //When (Act)
        vm.emailText = emailText
        vm.passwordText = passwordText
        let expect = XCTestExpectation(description: "Async operation")
        vm.checkTextFields()
        DispatchQueue.main.async {
            expect.fulfill()
        }
        
        //Then (Assert)
        wait(for: [expect], timeout: 1)
        XCTAssertFalse(vm.emailIsValid)
        XCTAssertFalse(vm.passwordIsValid)
        XCTAssertEqual(vm.emailText.isEmpty, true)
        XCTAssertEqual(vm.passwordText.isEmpty, true)
        XCTAssertEqual(vm.loginButtonIsDisabled, true)
    }
    
    func test_SuccessfulLogin() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //When
        vm.login()
        
        //Then
        XCTAssertTrue(UserManager.shared.isUserAuthorized)
        XCTAssertNotNil(vm.storedEmail)
        XCTAssertNotNil(vm.storedPassword)
    }
    
    func test_ErrorLogin() {
        //Given]
        var subscriptions = Set<AnyCancellable>()
        let vm = MainViewModel(welcomeFlowState: WelcomeFlowState(), authService: MockAuthServiceFailure())
        let expect = XCTestExpectation(description: "Wait for banner hide")
        
        
        //When
        vm.login()
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            expect.fulfill()
        }
        
        //Then
        XCTAssertFalse(UserManager.shared.isUserAuthorized)
        if let storedEmail = vm.storedEmail, let storedPassword = vm.storedPassword {
            XCTAssertTrue(storedEmail.isEmpty)
            XCTAssertTrue(storedPassword.isEmpty)
        } else {
            XCTFail("Fail on storedEmail and storedPassword")
        }
        XCTAssertTrue(InAppNotificationManager.shared.isShowing)
        wait(for: [expect], timeout: 3)
        XCTAssertFalse(InAppNotificationManager.shared.isShowing)
    }
}
