//
//  AuthView.swift
//  GarageMobClient
//
//  Created by Rezo Joglidze on 10.11.25.
//

import SwiftUI

struct AuthView: View {
    
    @StateObject private var viewModel: AuthViewModel
    
    init(viewModel: AuthViewModel = AuthViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            Text("AuthView")
                .font(.headline)
        }
    }
}
