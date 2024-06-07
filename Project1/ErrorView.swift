//
//  ErrorView.swift
//  Project1
//
//  Created by Pieter Jooste on 2024/06/05.
//

import SwiftUI


//struct ErrorView: View {
//    
//    @State private var isErrorPresented = false
//    
//    var body: some View {
//        VStack {
//            Button {
//                
//            } label: {
//                Text("Present error")
//            }
//            .alert("Error", isPresented: $isErrorPresented) {
//                
//            } message: {
//                Text(MyError.custom.localizedDescription)
//            }
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ErrorView()
//}

@MainActor
final class ErrorAlert: ObservableObject {
    
    @Published var error: Error?
    @Published var title: String?
    @Published var buttonTitle: String?
    var action: (() -> Void)?
    
    func present(_ error: Error, title: String = "Error", buttonTitle: String = "OK", action: (() -> Void)? = nil) {
        print(error.localizedDescription)
        self.error = error
        self.title = title
        self.buttonTitle = buttonTitle
        self.action = action
    }
}

struct ErrorAlertKey: EnvironmentKey {
    @MainActor
    static let defaultValue = ErrorAlert()
}

extension EnvironmentValues {
    var errorAlert: ErrorAlert {
        get {
            return self[ErrorAlertKey.self]
        }
        set {
            self[ErrorAlertKey.self] = newValue
        }
    }
}

struct ErrorAlertViewModifier: ViewModifier {
    
    @Environment(\.errorAlert) private var errorAlert
    @State private var isPresented = false
    
    func body(content: Content) -> some View {
        content
            .alert(errorAlert.title ?? "Error", isPresented: $isPresented) {
                Button(errorAlert.buttonTitle ?? "OK") {
                    errorAlert.action?()
                    errorAlert.error = nil
                    errorAlert.title = nil
                    errorAlert.buttonTitle = nil
                    errorAlert.action = nil
                }
            } message: {
                Text(errorAlert.error?.localizedDescription ?? "")
            }
            .onReceive(errorAlert.$error, perform: { newValue in
                if newValue != nil {
                    isPresented = true
                }
            })
    }
}


struct UsesErrorAlertModifier: ViewModifier {
    
    @StateObject private var errorAlert = ErrorAlert()
    
    func body(content: Content) -> some View {
        content
            .modifier(ErrorAlertViewModifier())
            .environment(\.errorAlert, errorAlert)
    }
}

extension View {
    func usesErrorAlert() -> some View {
        modifier(UsesErrorAlertModifier())
    }
}
