//
//  HomeViewModelTests.swift
//  NimbleAppTests
//
//  Created by Thony Gonzalez on 7/11/23.
//

import XCTest
@testable import NimbleApp
import Combine
import Alamofire

class MockHomeService: HomeServiceProtocol {
    func getSurveys(page: Int, perPage: Int) -> AnyPublisher<SurveyListResponse, Never> {
        Just(SurveyListResponse(data: [SurveyListData(id: "1", type: "1", attributes: SurveyListDataAttributes(title: "", description: "", coverImageURL: ""))], meta: Meta(page: 0, pages: 0, pageSize: 0, records: 0)))
            .eraseToAnyPublisher()
    }
    func refreshToken() -> AnyPublisher<LoginResponse, Never> {
        Just(LoginResponse(data: LoginData(id: "", type: "", attributes: LoginDataAttributes(accessToken: "", tokenType: "", expiresIn: 0, refreshToken: "", createdAt: 0))))
            .eraseToAnyPublisher()
    }
    func getUserProfile() -> AnyPublisher<UserProfileResponse, Never> {
        Just(UserProfileResponse(data: UserProfileData(id: "", type: "", attributes: UserProfileAttributes(email: "", name: "", avatarURL: ""))))
            .eraseToAnyPublisher()
    }
}

class MockHomeServiceFailure: HomeServiceProtocol {
    
    let errors = [ResponseError(detail: "", code: "")]
    
    func getSurveys(page: Int, perPage: Int) -> AnyPublisher<SurveyListResponse, Never> {
        Just(SurveyListResponse(errors: errors))
            .eraseToAnyPublisher()
    }
    func refreshToken() -> AnyPublisher<LoginResponse, Never> {
        Just(LoginResponse(errors: errors))
            .eraseToAnyPublisher()
    }
    func getUserProfile() -> AnyPublisher<UserProfileResponse, Never> {
        Just(UserProfileResponse(errors: errors))
            .eraseToAnyPublisher()
    }
}

final class HomeViewModelTests: XCTestCase {


    var successViewModel: HomeViewModel?
    var failureViewModel: HomeViewModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        successViewModel = HomeViewModel(homeService: MockHomeService())
        failureViewModel = HomeViewModel(homeService: MockHomeServiceFailure())
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        successViewModel = nil
        failureViewModel = nil
    }
    
    func test_SuccessFetchSurveys() {
        //Given
        guard let vm = successViewModel else {
            XCTFail()
            return
        }
        
        //When
        vm.fetchSurveys(page: 1)
        
        //Then
        XCTAssertNotNil(vm.surveysResponseMeta)
        XCTAssertFalse(vm.surveysData.isEmpty)
    }
}
