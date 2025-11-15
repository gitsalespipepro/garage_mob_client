//
//  AppointmentsView.swift
//  GarageMobClient
//
//  Created by Rezo Joglidze on 10.11.25.
//

import SwiftUI

struct AppointmentsView: View {

     private var viewModel: AppointmentsViewModel

    init(viewModel: AppointmentsViewModel = AppointmentsViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Color.purple.ignoresSafeArea()
            
            Text("AppointmentListView")
                .font(.headline)
        }
    }
}
