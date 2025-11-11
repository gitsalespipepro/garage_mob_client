// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen


import UIKit
import SwiftUI

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Icons

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Icons {
  public static let iconPenEdit = ImageAsset(name: "icon_pen_edit")
  public static let iconPhone = ImageAsset(name: "icon_phone")
  public static let logInBackground = ImageAsset(name: "log_in_background")
  public static let iconContactDeselected = ImageAsset(name: "icon_contact_deselected")
  public static let iconContactSelected = ImageAsset(name: "icon_contact_selected")
  public static let iconListDeselected = ImageAsset(name: "icon_list_deselected")
  public static let iconListSelected = ImageAsset(name: "icon_list_selected")
  public static let iconMainDeselected = ImageAsset(name: "icon_main_deselected")
  public static let iconMainSelected = ImageAsset(name: "icon_main_selected")
  public static let iconProfileDeselected = ImageAsset(name: "icon_profile_deselected")
  public static let iconProfileSelected = ImageAsset(name: "icon_profile_selected")
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
