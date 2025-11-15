//
//  ContactView.swift
//  GarageMobClient
//
//  Created by Rezo Joglidze on 10.11.25.
//

import SwiftUI

struct ContactView: View {

    private var viewModel: ContactViewModel

    init(viewModel: ContactViewModel = ContactViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            Text("ContactView")
                .font(.headline)
        }
    }
}
