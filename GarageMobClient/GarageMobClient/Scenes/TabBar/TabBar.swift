//
//  TabBar.swift
//  GarageMobClient
//
//  Created by Anton Mitrafanau on 13.10.25.
//

import UIKit
import Combine
import SnapKit

final class TabBar: UIView {
    
    enum Constants {
        static let height: CGFloat = 80
    }
    
    // MARK: Subviews
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.addArrangedSubview(self.mainTabView)
        stack.addArrangedSubview(self.appointmentListTabView)
        stack.addArrangedSubview(self.contactTabView)
        stack.addArrangedSubview(self.profileTabView)
        return stack
    }()
    
    private lazy var mainTabView: TabView = {
        let tabView = TabView(tab: .main, selected: true)
        tabView.selectionPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.selectedTabSubject.send(.main)
            }
            .store(in: &self.subscriptions)
        return tabView
    }()
    
    private lazy var appointmentListTabView: TabView = {
        let tabView = TabView(tab: .appointmentList, selected: false)
        tabView.selectionPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.selectedTabSubject.send(.appointmentList)
            }
            .store(in: &self.subscriptions)
        return tabView
    }()
    
    private lazy var contactTabView: TabView = {
        let tabView = TabView(tab: .contact, selected: false)
        tabView.selectionPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.selectedTabSubject.send(.contact)
            }
            .store(in: &self.subscriptions)
        return tabView
    }()
    
    private lazy var profileTabView: TabView = {
        let tabView = TabView(tab: .profile, selected: false)
        tabView.selectionPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.selectedTabSubject.send(.profile)
            }
            .store(in: &self.subscriptions)
        return tabView
    }()
    
    // MARK: Other properties
    var selectedTabPublisher: AnyPublisher<Tab, Never> {
        self.selectedTabSubject.eraseToAnyPublisher()
    }
    
    var selectedTab: Tab {
        self.selectedTabSubject.value
    }
    
    private let selectedTabSubject = CurrentValueSubject<Tab, Never>(.main)
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: Init
    init() {
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TabBar {
    
    func setup() {
        self.setupUI()
        self.setupSubscriptions()
    }
    
    func setupUI() {
        self.backgroundColor = .gray
        
        self.addSubview(self.stack)
        self.stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupSubscriptions() {
        self.selectedTabSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] tab in
                self?.refreshState(selectedTab: tab)
            }
            .store(in: &self.subscriptions)
    }
    
    func refreshState(selectedTab: Tab) {
        [
            self.mainTabView,
            self.appointmentListTabView,
            self.contactTabView,
            self.profileTabView
        ]
            .filter { $0.selected }
            .forEach { $0.selected = false }
        
        switch selectedTab {
        case .main:
            self.mainTabView.selected = true
        case .appointmentList:
            self.appointmentListTabView.selected = true
        case .contact:
            self.contactTabView.selected = true
        case .profile:
            self.profileTabView.selected = true
        }
    }
}
