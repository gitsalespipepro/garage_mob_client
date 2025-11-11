// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen


import UIKit
import SwiftUI

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Icons

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Icons {
  public static let accentColor = ColorAsset(name: "AccentColor")
  public static let chatMessages = ImageAsset(name: "Chat, Messages")
  public static let emailsLetterMail = ImageAsset(name: "Emails, Letter, Mail")
  public static let logIn = ImageAsset(name: "Log in")
  public static let phoneChatMessagesBubble = ImageAsset(name: "Phone, Chat, Messages, Bubble")
  public static let tabContactDeselected = ImageAsset(name: "tab_contact_deselected")
  public static let tabContactSelected = ImageAsset(name: "tab_contact_selected")
  public static let tabListDeselected = ImageAsset(name: "tab_list_deselected")
  public static let tabListSelected = ImageAsset(name: "tab_list_selected")
  public static let tabMainDeselected = ImageAsset(name: "tab_main_deselected")
  public static let tabMainSelected = ImageAsset(name: "tab_main_selected")
  public static let tabProfileDeselected = ImageAsset(name: "tab_profile_deselected")
  public static let tabProfileSelected = ImageAsset(name: "tab_profile_selected")
  public static let iconPhone = ImageAsset(name: "icon-phone")
  public static let penEdit = ImageAsset(name: "pen_edit")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public struct ImageAsset {
    public let name: String

    public init(name: String) {
        self.name = name
    }

    // SwiftUI
    #if SWIFT_PACKAGE
    public var image: Image { .init(name, bundle: .module) }
    #else
    public var image: Image { .init(name) }
    #endif
    public var originalImage: Image { image.renderingMode(.original) }
    public var templateImage: Image { image.renderingMode(.template) }

    // UIKit
    #if SWIFT_PACKAGE
    public var uiImage: UIImage? { .init(named: name, in: .module, compatibleWith: nil) }
    #else
    public var uiImage: UIImage? { .init(named: name) }
    #endif
}
