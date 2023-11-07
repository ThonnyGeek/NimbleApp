//
//  HomeService.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 6/11/23.
//

import Foundation
import Combine
import Alamofire

protocol HomeServiceProtocol {
    func getSurveys(page: Int, perPage: Int) -> AnyPublisher<SurveyListResponse, Never>
    func refreshToken() -> AnyPublisher<LoginResponse, Never>
}

class HomeService: HomeServiceProtocol {
    func getSurveys(page: Int, perPage: Int) -> AnyPublisher<SurveyListResponse, Never> {
        
        let parameters: Parameters = [
            "page[number]": page,
            "page[size]": perPage,
        ]
        
        return AF.request(HomeRouter.getSurveys(parameters: parameters))
            .publishDecodable(type: SurveyListResponse.self)
            .compactMap { result in
                guard let result = result.value else {
                    print("ERROR FATAL en getSurveys: \(String(describing: result.error)) - result: \(result)")
                    return nil
                }
                return result
            }
            .eraseToAnyPublisher()
    }
    
    func refreshToken() -> AnyPublisher<LoginResponse, Never> {
        return AF.request(HomeRouter.refreshToken)
            .publishDecodable(type: LoginResponse.self)
            .compactMap { result in
                guard let result = result.value else {
                    //                    fatalError("ERROR FATAL: \(result.error)")
                    return nil
                }
                return result
            }
            .eraseToAnyPublisher()
    }
    
    func getUserProfile() -> AnyPublisher<UserProfileResponse, Never> {
        return AF.request(HomeRouter.getUserProfile)
            .publishDecodable(type: UserProfileResponse.self)
            .compactMap { result in
                guard let result = result.value else {
                    //                    fatalError("ERROR FATAL: \(result.error)")
                    return nil
                }
                return result
            }
            .eraseToAnyPublisher()
    }
}
