//
//  AuthViewModel.swift
//  GarageMobClient
//
//  Created by Anton Mitrafanau on 22.10.25.
//  Copyright © 2025 ___ORGANIZATIONNAME___ All rights reserved.
//

import Combine
import AuthenticationServices

final class AuthViewModel: ObservableObject {
    
    // MARK: Continue with Apple
    func handleContinueWithApple(with authorization: ASAuthorization) {
        if let userCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            print(userCredential.user)
            
            if userCredential.authorizedScopes.contains(.fullName) {
                print(userCredential.fullName?.givenName ?? "No given name")
            }
            
            if userCredential.authorizedScopes.contains(.email) {
                print(userCredential.email ?? "No email")
            }
        }
    }
    
    func handleContinueWithApple(with error: Error) {
        print("Could not authenticate: \(error.localizedDescription)")
    }
}
