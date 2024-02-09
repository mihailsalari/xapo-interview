//
//  ToastManager.swift
//  Github
//
//  Created by Mihail Salari on 12/2/23.
//

import SwiftUI

enum ToastType {
    case error, success, warning
}

struct Toast: Identifiable, Equatable {
    let id = UUID()
    let message: String
    let type: ToastType
}

final class ToastManager: ObservableObject {
    @Published var currentToast: Toast?
    
    func show(message: String, type: ToastType) {
        currentToast = Toast(message: message, type: type)
    }
}

struct ToastViewModifier: ViewModifier {
    @Binding var toast: Toast?
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if let toast = toast {
                VStack {
                    Spacer()
                    Text(toast.message)
                        .foregroundColor(.white)
                        .padding()
                        .background(backgroundColor(for: toast.type))
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .transition(.opacity)
                        .onTapGesture {
                            self.toast = nil
                        }
                    Spacer().frame(height: 50)
                }
                .animation(.default, value: toast)
            }
        }
    }
    
    private func backgroundColor(for type: ToastType) -> Color {
        switch type {
        case .error:
            return .red
        case .success:
            return .green
        case .warning:
            return .yellow
        }
    }
}

extension View {
    func toast(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastViewModifier(toast: toast))
    }
}
