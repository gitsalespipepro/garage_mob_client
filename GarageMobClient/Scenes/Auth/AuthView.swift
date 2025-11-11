//
//  AuthView.swift
//  GarageMobClient
//
//  Created by Rezo Joglidze on 10.11.25.
//

import SwiftUI

struct AuthView: View {
    @StateObject private var viewModel: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @FocusState private var focusedField: Field?
    
    private enum Field: Hashable {
        case email
        case password
    }
    
    init() {
        _viewModel = StateObject(wrappedValue: AuthViewModel())
    }
    
    var body: some View {
        ZStack {
            backgroundView
                .ignoresSafeArea()
            
            contentView
                .padding(.horizontal, 20)
        }
    }
    
    private var contentView: some View {
        VStack(
            alignment: .center,
            spacing: .zero
        ) {
            Spacer()
            Text("SIGN UP TO CONTINUE")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
            
            Spacer().frame(height: 42)
            
            signInInputsView
            Spacer().frame(height: 55)
            
            signInPromptView
            
            Spacer().frame(height: 42)
            signUpButton
            
            Spacer()
            
            termsAndPolicyText
                .font(.system(size: 13))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
        }
    }
    
    // MARK: Background View
    private var backgroundView: some View {
        LinearGradient(
            colors: [
                Color(red: 79 / 255, green: 112 / 255, blue: 255 / 255),
                Color(red: 134 / 255, green: 95 / 255, blue: 255 / 255).opacity(0.7)
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    // MARK: Sign In Inputs View
    private var signInInputsView: some View {
        VStack(spacing: .zero) {
            inputTextField(
                placeholder: "Email*",
                text: $email,
                keyboardType: .emailAddress,
                field: .email
            )
            
            Spacer().frame(height: 30)
            
            inputSecureField(
                placeholder: "Password",
                text: $password,
                field: .password
            )
        }
    }
    
    private func inputTextField(
        placeholder: String,
        text: Binding<String>,
        keyboardType: UIKeyboardType,
        field: Field
    ) -> some View {
        TextField(placeholder, text: text)
            .textInputAutocapitalization(.never)
            .keyboardType(keyboardType)
            .autocorrectionDisabled(true)
            .padding(.horizontal, 18)
            .padding(.vertical, 18)
            .background(Color.white.opacity(0.95))
            .cornerRadius(20)
            .foregroundColor(.black)
            .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 6)
            .focused($focusedField, equals: field)
    }
    
    private func inputSecureField(
        placeholder: String,
        text: Binding<String>,
        field: Field
    ) -> some View {
        SecureField(placeholder, text: text)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .padding(.horizontal, 18)
            .padding(.vertical, 18)
            .background(Color.white.opacity(0.95))
            .cornerRadius(20)
            .foregroundColor(.black)
            .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 6)
            .focused($focusedField, equals: field)
    }
    
    
    
    private var signInPromptView: some View {
        HStack(spacing: 4) {
            Text("or")
                .foregroundColor(.white)
            
            Button {
                // TODO: Route to sign-in
            } label: {
                Text("Sign In")
                    .underline()
            }
            .foregroundColor(Color(hex: "#7ED4F6"))
            
            Text("if you already have an account")
                .foregroundColor(.white)
        }
        .font(.system(size: 14))
    }
    
    // MARK: Sign Up Button
    private var signUpButton: some View {
        Button {
            // TODO: perform sign up
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(hex: "#4BA3FA"))
                    .frame(height: 56)
                
                Text("Sign Up")
                    .font(.system(size: 20))
            }
        }
        .foregroundColor(.white)
    }
    
    
    // MARK: Footer View
    private var termsAndPolicyText: some View {
        (
            Text("By clicking Sign Up you accept our ")
            + Text("Terms of use")
                .underline()
            + Text("\nand our ")
            + Text("Privacy policy")
                .underline()
        )
    }
}

#if DEBUG
#Preview {
    AuthView()
}
#endif
