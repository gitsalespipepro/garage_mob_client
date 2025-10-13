//
//  TabView.swift
//  GarageMobClient
//
//  Created by Anton Mitrafanau on 13.10.25.
//

import UIKit
import Combine
import SnapKit

final class TabView: UIView {
    
    // MARK: Subviews
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 5
        stack.addArrangedSubview(self.imageView)
        return stack
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: Other properties
    var selectionPublisher: AnyPublisher<Void, Never> {
        self.selectionSubject.eraseToAnyPublisher()
    }
    
    private let tab: Tab
    var selected: Bool {
        didSet {
            self.refreshState()
        }
    }
    private let selectionSubject = PassthroughSubject<Void, Never>()
    
    init(tab: Tab, selected: Bool) {
        self.tab = tab
        self.selected = selected
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TabView {
    
    func setup() {
        self.setupUI()
        self.setupGestures()
        self.refreshState()
    }
    
    func setupUI() {
        self.addSubview(self.stack)
        self.stack.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.center.equalToSuperview()
        }
        self.imageView.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
    
    func setupGestures() {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(self.handleTap)
        )
        self.addGestureRecognizer(tap)
    }
    
    @objc
    func handleTap() {
        guard !self.selected else { return }
        self.selectionSubject.send()
    }
    
    func refreshState() {
        self.imageView.image = self.selected ? self.tab.selectedImage : self.tab.image
    }
}
