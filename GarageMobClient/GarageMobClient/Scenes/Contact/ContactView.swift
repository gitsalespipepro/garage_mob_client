//
//  ContactView.swift
//  GarageMobClient
//
//  Created by Rezo Joglidze on 10.11.25.
//

import SwiftUI

struct ContactView: View {

    @StateObject private var viewModel: ContactViewModel

    init(viewModel: ContactViewModel = ContactViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Color.blue
            Text("ContactView")
                .font(.headline)
        }
    }
}

