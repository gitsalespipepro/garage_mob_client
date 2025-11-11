//
//  MainView.swift
//  GarageMobClient
//
//  Created by Rezo Joglidze on 10.11.25.
//

import SwiftUI
import GarageModels

struct MainView: View {
    
    private let viewModel: MainViewModel
    
    init() {
        self.viewModel = MainViewModel()
    }
    
    // MARK: Body
    var body: some View {
        ZStack {
            backgroundView
            developersView
                .padding()
        }
        .task {
            viewModel.loadData()
        }
    }
    
    private var backgroundView: some View {
        Color.gray
            .opacity(0.3)
            .ignoresSafeArea()
    }
    
    private var developersView: some View {
        ScrollView(content: {
            VStack(spacing: 10) {
                ForEach(
                    viewModel.developers,
                    id: \.id,
                    content: {
                        person in
                        
                        HStack {
                            Image(systemName: "swift")
                                .resizable()
                                .frame(width: 50, height: 50)
                            
                            Spacer().frame(width: 25)
                            
                            Text(person.company)
                            
                            Spacer()
                        }
                    }
                )
            }
        })
    }
}

// MARK: - Preview
#if DEBUG
#Preview {
    MainView()
}
#endif
