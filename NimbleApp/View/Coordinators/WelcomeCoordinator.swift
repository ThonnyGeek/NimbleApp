//
//  WelcomeCoordinator.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 2/11/23.
//

import SwiftUI

open class WelcomeFlowState: ObservableObject {
    @Published var coverPath = NavigationPath()
}

enum WelcomeLink: Hashable, Identifiable {
case home
    
    var id: String {
        String(describing: self)
    }
}

struct WelcomeFlowCoordinator<Content: View>: View {
    
    @ObservedObject var state: WelcomeFlowState
//    @ObservedObject var homeViewModel = HomeViewModel()
//    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    
    let content: () -> Content
    
    var body: some View {
        NavigationStack(path: $state.coverPath) {
            content()
                .navigationDestination(for: WelcomeLink.self, destination: linkDestination)
        }
    }
    
    @ViewBuilder private func linkDestination(link: WelcomeLink) -> some View {
        switch link {
        case .home:
            HomeView(/*viewModel: homeViewModel, */state: $state.coverPath)
                .ignoresSafeArea()
                .navigationBarBackButtonHidden()
        }
    }
}

