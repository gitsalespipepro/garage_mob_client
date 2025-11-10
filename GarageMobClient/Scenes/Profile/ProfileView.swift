//
//  ProfileView.swift
//  GarageMobClient
//
//  Created by Rezo Joglidze on 10.11.25.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel = ProfileViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            Text("ProfileView")
                .font(.headline)
        }
    }
}

