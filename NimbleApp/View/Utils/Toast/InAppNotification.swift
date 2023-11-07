//
//  InAppNotification.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 2/11/23.
//

import UIKit
import SwiftUI

class InAppNotification: UIView {
    private var contentView: UIView!
    
    init(contentView: UIView) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 105)) // Ajusta la altura según tus necesidades
        
        self.contentView = contentView
        addSubview(contentView)
        contentView.center = CGPoint(x: (UIScreen.main.bounds.width / 2), y: -5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(onSuccess: @escaping () -> Void) {
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.3, animations: {

            let safeAreaTop = (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
            self.frame.origin.y = safeAreaTop // Ajusta la posición vertical debajo del Safe Area
        }, completion: { _ in
            onSuccess()
        })
    }
    
    func hide(onSuccess: @escaping () -> Void) {
        UIView.animate(withDuration: 1, animations: {
        
            self.contentView.frame.origin.y = -150
        }, completion: { _ in
            self.removeFromSuperview()
            onSuccess()
        })
    }
    
    func showFullScreen(onSuccess: @escaping () -> Void) {
        
        self.contentView.backgroundColor = .clear
        
        UIApplication.shared.keyWindow?.addSubview(self)
        self.addSubview(self.contentView)
        self.contentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.alpha = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 1
        }, completion: { _ in
            onSuccess()
        })
    }
    
    func hideFullScreen(onSuccess: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }, completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.removeFromSuperview()
                onSuccess()
            }
        })
    }
}

class InAppNotificationManager {
    static let shared = InAppNotificationManager()
    
    private init() {}
    
    func showNotification(_ text: String, subtitle: String? = nil, onSuccess: (() -> Void)? = nil) {
        
        let successNotification = UIHostingController(rootView: CustomNotificationView(text: text, subtitle: subtitle))
        
        let notification = InAppNotification(contentView: successNotification.view)
        notification.show() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                notification.hide() {
                    guard let onSuccess = onSuccess else { return }
                    onSuccess()
                }
            }
        }
        
    }
    
    let loadingView = InAppNotification(contentView: UIHostingController(rootView: LoadingView()).view)
    
    func showLoading(_ onSuccess: (() -> Void)? = nil) {
        loadingView.showFullScreen {
            guard let onSuccess = onSuccess else { return }
            onSuccess()
        }
    }
    
    func hideLoading(_ onSuccess: (() -> Void)? = nil) {
        loadingView.hideFullScreen {
            guard let onSuccess = onSuccess else { return }
            onSuccess()
        }
    }
}

//class InAppNotification: UIView {
//    private var contentView: UIView!
//    
//    init(contentView: UIView) {
//        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 105)) // Ajusta la altura según tus necesidades
//        
//        self.contentView = contentView
//        
//        contentView.center = CGPoint(x: (UIScreen.main.bounds.width / 2), y: -5)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func show(onSuccess: @escaping () -> Void) {
//        UIApplication.shared.keyWindow?.addSubview(self)
//        self.addSubview(self.contentView)
//        UIView.animate(withDuration: 0.3, animations: {
//            let safeAreaTop = (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
//            self.frame.origin.y = safeAreaTop // Ajusta la posición vertical debajo del Safe Area
//        }, completion: { _ in
//            onSuccess()
//        })
//    }
//    
//    func showFullScreen(onSuccess: @escaping () -> Void) {
//        
//        self.contentView.backgroundColor = .clear
//        
//        UIApplication.shared.keyWindow?.addSubview(self)
//        self.addSubview(self.contentView)
//        self.contentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        self.alpha = 0
//        
//        UIView.animate(withDuration: 0.5, animations: {
//            self.alpha = 1
//        }, completion: { _ in
//            onSuccess()
//        })
//    }
//    
//    func hide(onSuccess: @escaping () -> Void) {
//        UIView.animate(withDuration: 1, animations: {
//        
//            self.contentView.frame.origin.y = -150
//        }, completion: { _ in
//            self.removeFromSuperview()
//            onSuccess()
//        })
//    }
//    
//    func hideFullScreen(onSuccess: @escaping () -> Void) {
//        UIView.animate(withDuration: 0.5, animations: {
//            self.alpha = 0
//        }, completion: { _ in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                self.removeFromSuperview()
//                onSuccess()
//            }
//        })
//    }
//}
//
//class InAppNotificationManager {
//    static let shared = InAppNotificationManager()
//    
//    private init() {}
//    
//    
//    func showSuccess(_ text: String, subtitle: String? = nil, onSuccess: (() -> Void)? = nil) {
//        
//        let successNotification = UIHostingController(rootView: CustomNotificationView(text: text, subtitle: subtitle))
//        
//        let notification = InAppNotification(contentView: successNotification.view)
//        notification.show() {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                notification.hide() {
//                    guard let onSuccess = onSuccess else { return }
//                    onSuccess()
//                }
//            }
//        }
//        
//    }
//    
//    func showWarning(_ text: String, subtitle: String? = nil, onSuccess: (() -> Void)? = nil) {
//        
//        let successNotification = UIHostingController(rootView: CustomNotificationView(text: text, subtitle: subtitle))
//        
//        let notification = InAppNotification(contentView: successNotification.view)
//        notification.show() {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                notification.hide() {
//                    guard let onSuccess = onSuccess else { return }
//                    onSuccess()
//                }
//            }
//        }
//        
//    }
//    
//    func showError(_ text: String, subtitle: String? = nil, onSuccess: (() -> Void)? = nil) {
//        
//        let successNotification = UIHostingController(rootView: CustomNotificationView(text: text, subtitle: subtitle))
//        
//        let notification = InAppNotification(contentView: successNotification.view)
//        notification.show() {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                notification.hide() {
//                    guard let onSuccess = onSuccess else { return }
//                    onSuccess()
//                }
//            }
//        }
//        
//    }
//    
//    let loadingView = InAppNotification(contentView: UIHostingController(rootView: LoadingView()).view)
//    
//    func showLoading(_ onSuccess: (() -> Void)? = nil) {
//        loadingView.showFullScreen {
//            guard let onSuccess = onSuccess else { return }
//            onSuccess()
//        }
//    }
//    
//    func hideLoading(_ onSuccess: (() -> Void)? = nil) {
//        loadingView.hideFullScreen {
//            guard let onSuccess = onSuccess else { return }
//            onSuccess()
//        }
//    }
//}
//
//struct LoadingView: View {
//    var body: some View {
//        ProgressView()
//            .tint(.white)
//            .scaleEffect(2)
//            .frame(width: 44, height: 44)
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background {
//                Color.darkBackgroundColor.opacity(0.4)
//            }
//            .ignoresSafeArea()
//    }
//}
//
//struct LoadingViewContainer: View {
//    var body: some View {
//        ZStack {
//            Color.red
//                .onTapGesture {
////                    InAppNotificationManager.shared.showLoading()
////                    
////                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
////                        InAppNotificationManager.shared.hideLoading()
////                    }
//                }
//            
////            LoadingView()
//        }
//        .onAppear {
//            
//            InAppNotificationManager.shared.showSuccess("sd")
//        }
//    }
//}
//
//#Preview {
//    LoadingViewContainer()
//}

//class InAppNotification: UIView {
//    private var contentView: UIView!
//    
//    init(contentView: UIView) {
//        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 105)) // Ajusta la altura según tus necesidades
//        
//        self.contentView = contentView
//        
//        contentView.center = CGPoint(x: (UIScreen.main.bounds.width / 2), y: -5)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func show(onSuccess: @escaping () -> Void) {
//        UIApplication.shared.keyWindow?.addSubview(self)
//        self.addSubview(self.contentView)
//        UIView.animate(withDuration: 0.3, animations: {
//            let safeAreaTop = (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
//            self.frame.origin.y = safeAreaTop // Ajusta la posición vertical debajo del Safe Area
//        }, completion: { _ in
//            onSuccess()
//        })
//    }
//    
//    func showFullScreen(onSuccess: @escaping () -> Void) {
//        
//        self.contentView.backgroundColor = .clear
//        
//        UIApplication.shared.keyWindow?.addSubview(self)
//        self.addSubview(self.contentView)
//        self.contentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        self.alpha = 0
//        
//        UIView.animate(withDuration: 0.5, animations: {
//            self.alpha = 1
//        }, completion: { _ in
//            onSuccess()
//        })
//    }
//    
//    func hide(onSuccess: @escaping () -> Void) {
//        UIView.animate(withDuration: 1, animations: {
//        
//            self.contentView.frame.origin.y = -150
//        }, completion: { _ in
//            self.removeFromSuperview()
//            onSuccess()
//        })
//    }
//    
//    func hideFullScreen(onSuccess: @escaping () -> Void) {
//        UIView.animate(withDuration: 0.5, animations: {
//            self.alpha = 0
//        }, completion: { _ in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                self.removeFromSuperview()
//                onSuccess()
//            }
//        })
//    }
//}
//
//class InAppNotificationManager {
//    static let shared = InAppNotificationManager()
//    
//    private init() {}
//    
//    
//    func showSuccess(_ text: String, subtitle: String? = nil, onSuccess: (() -> Void)? = nil) {
//        
//        let successNotification = UIHostingController(rootView: CustomNotificationView(text: text, subtitle: subtitle))
//        
//        let notification = InAppNotification(contentView: successNotification.view)
//        notification.show() {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                notification.hide() {
//                    guard let onSuccess = onSuccess else { return }
//                    onSuccess()
//                }
//            }
//        }
//        
//    }
//    
//    func showWarning(_ text: String, subtitle: String? = nil, onSuccess: (() -> Void)? = nil) {
//        
//        let successNotification = UIHostingController(rootView: CustomNotificationView(text: text, subtitle: subtitle))
//        
//        let notification = InAppNotification(contentView: successNotification.view)
//        notification.show() {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                notification.hide() {
//                    guard let onSuccess = onSuccess else { return }
//                    onSuccess()
//                }
//            }
//        }
//        
//    }
//    
//    func showError(_ text: String, subtitle: String? = nil, onSuccess: (() -> Void)? = nil) {
//        
//        let successNotification = UIHostingController(rootView: CustomNotificationView(text: text, subtitle: subtitle))
//        
//        let notification = InAppNotification(contentView: successNotification.view)
//        notification.show() {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                notification.hide() {
//                    guard let onSuccess = onSuccess else { return }
//                    onSuccess()
//                }
//            }
//        }
//        
//    }
//    
//    let loadingView = InAppNotification(contentView: UIHostingController(rootView: LoadingView()).view)
//    
//    func showLoading(_ onSuccess: (() -> Void)? = nil) {
//        loadingView.showFullScreen {
//            guard let onSuccess = onSuccess else { return }
//            onSuccess()
//        }
//    }
//    
//    func hideLoading(_ onSuccess: (() -> Void)? = nil) {
//        loadingView.hideFullScreen {
//            guard let onSuccess = onSuccess else { return }
//            onSuccess()
//        }
//    }
//}

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .tint(.white)
            .scaleEffect(2)
            .frame(width: 44, height: 44)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color.darkBackgroundColor.opacity(0.4)
            }
            .ignoresSafeArea()
    }
}

struct LoadingViewContainer: View {
    var body: some View {
        ZStack {
            Color.red
                .onTapGesture {
                    InAppNotificationManager.shared.showLoading()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        InAppNotificationManager.shared.hideLoading()
                    }
                }
            
//            LoadingView()
        }
        .onAppear {
            
//            InAppNotificationManager.shared.showSuccess("sd")
            
            InAppNotificationManager.shared.showLoading()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                InAppNotificationManager.shared.hideLoading()
            }
        }
    }
}

#Preview {
    LoadingViewContainer()
}
