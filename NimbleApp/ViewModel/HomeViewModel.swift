//
//  HomeViewModel.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 3/11/23.
//

import Foundation

enum HomeTab: Hashable {
    case workingFromHome
    case careerTraining
    case inclusionBelongig
    
    var id: Int {
        switch self {
        case .workingFromHome:
            1
        case .careerTraining:
            2
        case .inclusionBelongig:
            3
        }
    }
    
    var title: String {
        switch self {
        case .workingFromHome:
            "Working from home Check-In"
        case .careerTraining:
            "Career training and development"
        case .inclusionBelongig:
            "Inclusion and belonging"
        }
    }
    
    var body: String {
        switch self {
        case .workingFromHome:
            "We would like to know how you feel about our work from home (WFH) experience."
        case .careerTraining:
            "We would like to know what are your goals and skills you wanted to learn."
        case .inclusionBelongig:
            "Building a workplace culture that prioritizes belonging and inclusio..."
        }
    }
    
    var backgroundImgName: String {
        switch self {
        case .workingFromHome:
            "firstHomeBackground"
        case .careerTraining:
            "secondHomeBackground"
        case .inclusionBelongig:
            "thirdHomeBackground"
        }
    }
}

//struct HomeFirstStep: Hashable {
//    let id: Int
//    let option: String
//}

enum HomeFirstStep: Hashable {
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
    
    @Published var tabSelected: HomeTab = .workingFromHome
    
    @Published var showSkeletonAnimation: Bool = false
    
    @Published var isLoadingData: Bool = true
    
    @Published var surveySelected: HomeTab?
    
    @Published var surveyStep: Int?
    @Published var fisrtStepOptionSelected: HomeFirstStep?// = .veryFulfilled
    
    //MARK: Constants
    let dateFormatter = DateFormatter()
    
    let homeTabs: [HomeTab] = [.workingFromHome, .careerTraining, .inclusionBelongig]
    
    let fisrtStepOptions: [HomeFirstStep] = [.veryFulfilled, .somewhatFulfilled, .somewhatUnfulfilled, .veryUnfulfilled]
    
    //MARK: init
    init() {
        dateFormatter.dateFormat = "EEEE, MMMM d"
        
//        isLoadingData = false
//        surveySelected = tabSelected
    }
    
    //MARK: Functions
}
