//
//  SideMenuView.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 3/11/23.
//

import SwiftUI

struct SideMenuView<RenderView: View>: View {
    @Binding var isShowing: Bool
    var direction: Edge
    @ViewBuilder  var content: RenderView
    
    var body: some View {
        ZStack(alignment: .leading) {
            if isShowing {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                content
                    .transition(.move(edge: direction))
                    .background(
                        Color.white
                    )
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}

struct SideMenuViewContents: View {
    
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        ZStack {
            
            VStack (spacing: 0) {
                ZStack {
                    Text("User namsdsdfsde")
                        .font(.neuzeitSemiBold(34))
                        .foregroundStyle(.white)
                        .frame(maxWidth: 190, alignment: .leading)
                        .lineLimit(1)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        presentSideMenu = false
                    } label: {
                        Image("profilePic")
                            .frame(width: 36, height: 36)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 20)
                }
                .padding(.bottom, 26)
                
                Rectangle()
                    .fill(.white.opacity(0.5))
                    .frame(height: 0.5)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 35)
                
                Button {
                } label: {
                    Text("Logout")
                        .font(.neuzeitBook(20))
                        .kerning(0.5)
                        .foregroundColor(.white.opacity(0.5))
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            Text("v0.1.0 (1562903885)")
                .font(.neuzeitBook(11))
                .foregroundStyle(.white.opacity(0.5))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .padding(.leading, 20)
                .padding(.bottom, 40)
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0) + 30)
    }
}

struct SideMenuViewContentsView: View {
    @State var isShowing: Bool = false
    
    let backgroundColor = Color(#colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)) // #1E1E1E
    
    var body: some View {
        SideMenuViewContents(presentSideMenu: $isShowing)
            .frame(width: Constants.Sizes.width * 0.65)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .background(backgroundColor)
    }
}

#Preview {
    SideMenuViewContentsView()
}
