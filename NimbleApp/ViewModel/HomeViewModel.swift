//
//  HomeViewModel.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 3/11/23.
//

import Foundation
import SwiftUI
import Combine

enum HomeFirstStep: Hashable, CaseIterable {
    case veryFulfilled
    case somewhatFulfilled
    case somewhatUnfulfilled
    case veryUnfulfilled
    
    var text: String {
        switch self {
        case .veryFulfilled:
            return "Very fulfilled"
        case .somewhatFulfilled:
            return "Somewhat fulfilled"
        case .somewhatUnfulfilled:
            return "Somewhat unfulfilled"
        case .veryUnfulfilled:
            return "Very unfulfilled"
        }
    }
}

final class HomeViewModel: ObservableObject {
    
    //MARK: Variables
    
    @Published var showMenu: Bool = false
    
    var presentDate = Date()
    
    @Published var tabSelected: SurveyListData = .init(id: "", type: "", attributes: SurveyListDataAttributes(title: "", description: "", coverImageURL: ""))
    
    @Published var showSkeletonAnimation: Bool = false
    
    @Published var isLoadingData: Bool = true
    
    @Published var showMainInfo: Bool = true
    
    @Published var surveySelected: SurveyListData?
    
    @Published var surveyStep: Int?
    @Published var showConfirmSurvey: Bool = false
    
    @Published var fisrtStepOptionSelected: String? = HomeFirstStep.veryFulfilled.text
    @Published var showFirstStep: Bool = false
    
    @Published var surveysData: [SurveyListData] = []
    @Published var surveysResponseMeta: Meta?
    
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Constants
    let dateFormatter = DateFormatter()
    
//    let homeTabs: [HomeTab] = [.workingFromHome, .careerTraining, .inclusionBelongig]
    
    let fisrtStepOptions: [HomeFirstStep] = [.veryFulfilled, .somewhatFulfilled, .somewhatUnfulfilled, .veryUnfulfilled]
    
    let homeService: HomeService = HomeService()
    
    //MARK: init
    init() {
        print("init() {")
        fetchSurveys(page: 1) { tokenWasRefreshed in
            if tokenWasRefreshed {
                self.fetchSurveys(page: 1)
            }
        }
        
        
        dateFormatter.dateFormat = "EEEE, MMMM d"
        
//        tabSelected = surveysData.first ?? .init(id: "1", type: "12", attributes: SurveyListDataAttributes(title: "aa", description: "bb", coverImageURL: ""))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print("dqm")
            self.isLoadingData = false
        }
    }
    
    //MARK: Functions
    func fetchSurveys(page: Int, onSuccess: ((_ tokenWasRefreshed: Bool) -> Void)? = nil) {
        
        if page == 1 {
            self.surveysData = []
        }
        
         self.homeService.getSurveys(page: page, perPage: 5)
             .sink(receiveCompletion: Constants.onReceive) { result in
                 print("result: \(result)")
                 
                 self.surveysResponseMeta = result.meta
                 
                 guard let data = result.data, let firstSelection = data.first else {
                     if result.errors?.first?.code == "invalid_token", let onSuccess = onSuccess {
                         self.refreshToken() {
                             onSuccess(true)
                         }
                     } else {
                         InAppNotificationManager.shared.showError(result.errors?.first?.code ?? "API connection error", subtitle: result.errors?.first?.detail)
                     }
                     return
                 }
                
                 if page == 1 {
                     self.surveysData = data
                     self.tabSelected = firstSelection
                 } else {
                     self.surveysData.append(contentsOf: data)
                 }
             }
             .store(in: &subscriptions)
    }
    
    func refreshToken(onSuccess: @escaping () -> Void) {
        self.homeService.refreshToken()
            .sink(receiveCompletion: Constants.onReceive) { result in
                guard let data = result.data else {
                    InAppNotificationManager.shared.showError(result.errors?.first?.code ?? "API connection error", subtitle: result.errors?.first?.detail)
                    
                    return
                }
                
                UserManager.shared.authorize(access_token: data.attributes.accessToken, expires_in: data.attributes.expiresIn.description, refresh_token: data.attributes.refreshToken)
                onSuccess()
            }
            .store(in: &subscriptions)
    }
}
