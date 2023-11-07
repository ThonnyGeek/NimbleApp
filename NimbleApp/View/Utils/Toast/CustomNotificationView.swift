//
//  CustomNotificationView.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 2/11/23.
//

import SwiftUI

struct CustomNotificationView: View {

    var text: String
    var subtitle: String?
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Rectangle()
                .fill(Color(red: 0.15, green: 0.15, blue: 0.15).opacity(0.6))
              .frame(width: Constants.Sizes.width, height: 110)
            
            HStack (alignment: .top, spacing: 12) {
                Image(systemName: "bell.fill")
                    .resizable()
                    .foregroundStyle(.white)
                    .rotationEffect(.degrees(45))
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                VStack (alignment: .leading, spacing: 0) {
                    Text(text/*"Check your email."*/)
                        .lineLimit(2)
                        .font(.neuzeitSemiBold(15))
                        .foregroundColor(.white)
                    
                    if let subtitle = subtitle {
                        Text(subtitle/*"We’ve email you instructions to reset your password."*/)
                            .lineLimit(1)
                            .font(.neuzeitBook(13))
                            .foregroundColor(.white)
                    }
                }
                .frame(width: Constants.Sizes.width * 0.7, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 10)
            .padding(.horizontal, 16)
        }
//        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

//#Preview {
//    ZStack {
//        
//        Color.black
//        
//        CustomNotificationView()
//    }
//}

/*
 struct CustomNotificationView: View {
     let text: String
     var subtitle: String?
     let theme: CNTheme
 //    let backButtonAction: () -> Void
     
     var textColor: Color = .gray
     var icon: Image = Image(systemName: "checkmark.circle")

     init(text: String, subtitle: String? = nil, theme: CNTheme/*, backButtonAction: @escaping () -> Void*/) {
         self.text = text
         self.theme = theme
 //        self.backButtonAction = backButtonAction
 //        self.textColor = textColor
         switch self.theme {
         case .info:
             self.textColor = .gray
             self.icon = Image(systemName: "info.bubble.fill")
         case .success:
             self.textColor = .green
             self.icon = Image(systemName: "checkmark.circle")
         case .warning:
             self.textColor = Color(#colorLiteral(red: 0.6636876578, green: 0.5603061255, blue: 0.02136315208, alpha: 1))
             self.icon = Image(systemName: "exclamationmark.circle")
         case .error:
             self.textColor = .red
             self.icon = Image(systemName: "wrongwaysign")
             
         }
     }
     
     var body: some View {
         ZStack {
             HStack (spacing: 10) {
                 
                 icon
                     .resizable()
                     .scaledToFill()
                     .frame(width: 15, height: 15)
                 
                 VStack {
                     Text(LocalizedStringKey(text))
 //                        .font(.poppinsMedium(14))
                     
                     if let subtitle = subtitle, !subtitle.isEmpty {
                         Text(subtitle)
                     }
                 }
             }
             .padding(.vertical, 15)
             .padding(.horizontal, 20)
             .foregroundColor(textColor)
             .background {
                 ZStack {
                     
                     Color.white
                     textColor.opacity(0.4)
                 }
             }
             .cornerRadius(8)
         }
         .frame(width: UIScreen.main.bounds.width)
     }
 }

 enum CNTheme {
     case info
     case success
     case warning
     case error
 }
 */
