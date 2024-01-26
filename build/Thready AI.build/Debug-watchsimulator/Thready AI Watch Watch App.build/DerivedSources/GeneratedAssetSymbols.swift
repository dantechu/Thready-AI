import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
extension ColorResource {

}

// MARK: - Image Symbols -

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
extension ImageResource {

    /// The "botIcon" asset catalog image resource.
    static let botIcon = ImageResource(name: "botIcon", bundle: resourceBundle)

    /// The "smiling-0" asset catalog image resource.
    static let smiling0 = ImageResource(name: "smiling-0", bundle: resourceBundle)

    /// The "smiling-1" asset catalog image resource.
    static let smiling1 = ImageResource(name: "smiling-1", bundle: resourceBundle)

    /// The "smiling-10" asset catalog image resource.
    static let smiling10 = ImageResource(name: "smiling-10", bundle: resourceBundle)

    /// The "smiling-11" asset catalog image resource.
    static let smiling11 = ImageResource(name: "smiling-11", bundle: resourceBundle)

    /// The "smiling-12" asset catalog image resource.
    static let smiling12 = ImageResource(name: "smiling-12", bundle: resourceBundle)

    /// The "smiling-13" asset catalog image resource.
    static let smiling13 = ImageResource(name: "smiling-13", bundle: resourceBundle)

    /// The "smiling-14" asset catalog image resource.
    static let smiling14 = ImageResource(name: "smiling-14", bundle: resourceBundle)

    /// The "smiling-15" asset catalog image resource.
    static let smiling15 = ImageResource(name: "smiling-15", bundle: resourceBundle)

    /// The "smiling-16" asset catalog image resource.
    static let smiling16 = ImageResource(name: "smiling-16", bundle: resourceBundle)

    /// The "smiling-17" asset catalog image resource.
    static let smiling17 = ImageResource(name: "smiling-17", bundle: resourceBundle)

    /// The "smiling-18" asset catalog image resource.
    static let smiling18 = ImageResource(name: "smiling-18", bundle: resourceBundle)

    /// The "smiling-19" asset catalog image resource.
    static let smiling19 = ImageResource(name: "smiling-19", bundle: resourceBundle)

    /// The "smiling-2" asset catalog image resource.
    static let smiling2 = ImageResource(name: "smiling-2", bundle: resourceBundle)

    /// The "smiling-20" asset catalog image resource.
    static let smiling20 = ImageResource(name: "smiling-20", bundle: resourceBundle)

    /// The "smiling-21" asset catalog image resource.
    static let smiling21 = ImageResource(name: "smiling-21", bundle: resourceBundle)

    /// The "smiling-22" asset catalog image resource.
    static let smiling22 = ImageResource(name: "smiling-22", bundle: resourceBundle)

    /// The "smiling-23" asset catalog image resource.
    static let smiling23 = ImageResource(name: "smiling-23", bundle: resourceBundle)

    /// The "smiling-24" asset catalog image resource.
    static let smiling24 = ImageResource(name: "smiling-24", bundle: resourceBundle)

    /// The "smiling-25" asset catalog image resource.
    static let smiling25 = ImageResource(name: "smiling-25", bundle: resourceBundle)

    /// The "smiling-26" asset catalog image resource.
    static let smiling26 = ImageResource(name: "smiling-26", bundle: resourceBundle)

    /// The "smiling-27" asset catalog image resource.
    static let smiling27 = ImageResource(name: "smiling-27", bundle: resourceBundle)

    /// The "smiling-28" asset catalog image resource.
    static let smiling28 = ImageResource(name: "smiling-28", bundle: resourceBundle)

    /// The "smiling-29" asset catalog image resource.
    static let smiling29 = ImageResource(name: "smiling-29", bundle: resourceBundle)

    /// The "smiling-3" asset catalog image resource.
    static let smiling3 = ImageResource(name: "smiling-3", bundle: resourceBundle)

    /// The "smiling-30" asset catalog image resource.
    static let smiling30 = ImageResource(name: "smiling-30", bundle: resourceBundle)

    /// The "smiling-31" asset catalog image resource.
    static let smiling31 = ImageResource(name: "smiling-31", bundle: resourceBundle)

    /// The "smiling-32" asset catalog image resource.
    static let smiling32 = ImageResource(name: "smiling-32", bundle: resourceBundle)

    /// The "smiling-33" asset catalog image resource.
    static let smiling33 = ImageResource(name: "smiling-33", bundle: resourceBundle)

    /// The "smiling-34" asset catalog image resource.
    static let smiling34 = ImageResource(name: "smiling-34", bundle: resourceBundle)

    /// The "smiling-35" asset catalog image resource.
    static let smiling35 = ImageResource(name: "smiling-35", bundle: resourceBundle)

    /// The "smiling-36" asset catalog image resource.
    static let smiling36 = ImageResource(name: "smiling-36", bundle: resourceBundle)

    /// The "smiling-37" asset catalog image resource.
    static let smiling37 = ImageResource(name: "smiling-37", bundle: resourceBundle)

    /// The "smiling-38" asset catalog image resource.
    static let smiling38 = ImageResource(name: "smiling-38", bundle: resourceBundle)

    /// The "smiling-39" asset catalog image resource.
    static let smiling39 = ImageResource(name: "smiling-39", bundle: resourceBundle)

    /// The "smiling-4" asset catalog image resource.
    static let smiling4 = ImageResource(name: "smiling-4", bundle: resourceBundle)

    /// The "smiling-40" asset catalog image resource.
    static let smiling40 = ImageResource(name: "smiling-40", bundle: resourceBundle)

    /// The "smiling-41" asset catalog image resource.
    static let smiling41 = ImageResource(name: "smiling-41", bundle: resourceBundle)

    /// The "smiling-42" asset catalog image resource.
    static let smiling42 = ImageResource(name: "smiling-42", bundle: resourceBundle)

    /// The "smiling-43" asset catalog image resource.
    static let smiling43 = ImageResource(name: "smiling-43", bundle: resourceBundle)

    /// The "smiling-44" asset catalog image resource.
    static let smiling44 = ImageResource(name: "smiling-44", bundle: resourceBundle)

    /// The "smiling-45" asset catalog image resource.
    static let smiling45 = ImageResource(name: "smiling-45", bundle: resourceBundle)

    /// The "smiling-46" asset catalog image resource.
    static let smiling46 = ImageResource(name: "smiling-46", bundle: resourceBundle)

    /// The "smiling-47" asset catalog image resource.
    static let smiling47 = ImageResource(name: "smiling-47", bundle: resourceBundle)

    /// The "smiling-48" asset catalog image resource.
    static let smiling48 = ImageResource(name: "smiling-48", bundle: resourceBundle)

    /// The "smiling-49" asset catalog image resource.
    static let smiling49 = ImageResource(name: "smiling-49", bundle: resourceBundle)

    /// The "smiling-5" asset catalog image resource.
    static let smiling5 = ImageResource(name: "smiling-5", bundle: resourceBundle)

    /// The "smiling-50" asset catalog image resource.
    static let smiling50 = ImageResource(name: "smiling-50", bundle: resourceBundle)

    /// The "smiling-6" asset catalog image resource.
    static let smiling6 = ImageResource(name: "smiling-6", bundle: resourceBundle)

    /// The "smiling-7" asset catalog image resource.
    static let smiling7 = ImageResource(name: "smiling-7", bundle: resourceBundle)

    /// The "smiling-8" asset catalog image resource.
    static let smiling8 = ImageResource(name: "smiling-8", bundle: resourceBundle)

    /// The "smiling-9" asset catalog image resource.
    static let smiling9 = ImageResource(name: "smiling-9", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "botIcon" asset catalog image.
    static var botIcon: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .botIcon)
#else
        .init()
#endif
    }

    /// The "smiling-0" asset catalog image.
    static var smiling0: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling0)
#else
        .init()
#endif
    }

    /// The "smiling-1" asset catalog image.
    static var smiling1: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling1)
#else
        .init()
#endif
    }

    /// The "smiling-10" asset catalog image.
    static var smiling10: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling10)
#else
        .init()
#endif
    }

    /// The "smiling-11" asset catalog image.
    static var smiling11: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling11)
#else
        .init()
#endif
    }

    /// The "smiling-12" asset catalog image.
    static var smiling12: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling12)
#else
        .init()
#endif
    }

    /// The "smiling-13" asset catalog image.
    static var smiling13: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling13)
#else
        .init()
#endif
    }

    /// The "smiling-14" asset catalog image.
    static var smiling14: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling14)
#else
        .init()
#endif
    }

    /// The "smiling-15" asset catalog image.
    static var smiling15: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling15)
#else
        .init()
#endif
    }

    /// The "smiling-16" asset catalog image.
    static var smiling16: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling16)
#else
        .init()
#endif
    }

    /// The "smiling-17" asset catalog image.
    static var smiling17: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling17)
#else
        .init()
#endif
    }

    /// The "smiling-18" asset catalog image.
    static var smiling18: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling18)
#else
        .init()
#endif
    }

    /// The "smiling-19" asset catalog image.
    static var smiling19: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling19)
#else
        .init()
#endif
    }

    /// The "smiling-2" asset catalog image.
    static var smiling2: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling2)
#else
        .init()
#endif
    }

    /// The "smiling-20" asset catalog image.
    static var smiling20: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling20)
#else
        .init()
#endif
    }

    /// The "smiling-21" asset catalog image.
    static var smiling21: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling21)
#else
        .init()
#endif
    }

    /// The "smiling-22" asset catalog image.
    static var smiling22: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling22)
#else
        .init()
#endif
    }

    /// The "smiling-23" asset catalog image.
    static var smiling23: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling23)
#else
        .init()
#endif
    }

    /// The "smiling-24" asset catalog image.
    static var smiling24: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling24)
#else
        .init()
#endif
    }

    /// The "smiling-25" asset catalog image.
    static var smiling25: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling25)
#else
        .init()
#endif
    }

    /// The "smiling-26" asset catalog image.
    static var smiling26: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling26)
#else
        .init()
#endif
    }

    /// The "smiling-27" asset catalog image.
    static var smiling27: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling27)
#else
        .init()
#endif
    }

    /// The "smiling-28" asset catalog image.
    static var smiling28: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling28)
#else
        .init()
#endif
    }

    /// The "smiling-29" asset catalog image.
    static var smiling29: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling29)
#else
        .init()
#endif
    }

    /// The "smiling-3" asset catalog image.
    static var smiling3: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling3)
#else
        .init()
#endif
    }

    /// The "smiling-30" asset catalog image.
    static var smiling30: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling30)
#else
        .init()
#endif
    }

    /// The "smiling-31" asset catalog image.
    static var smiling31: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling31)
#else
        .init()
#endif
    }

    /// The "smiling-32" asset catalog image.
    static var smiling32: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling32)
#else
        .init()
#endif
    }

    /// The "smiling-33" asset catalog image.
    static var smiling33: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling33)
#else
        .init()
#endif
    }

    /// The "smiling-34" asset catalog image.
    static var smiling34: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling34)
#else
        .init()
#endif
    }

    /// The "smiling-35" asset catalog image.
    static var smiling35: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling35)
#else
        .init()
#endif
    }

    /// The "smiling-36" asset catalog image.
    static var smiling36: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling36)
#else
        .init()
#endif
    }

    /// The "smiling-37" asset catalog image.
    static var smiling37: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling37)
#else
        .init()
#endif
    }

    /// The "smiling-38" asset catalog image.
    static var smiling38: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling38)
#else
        .init()
#endif
    }

    /// The "smiling-39" asset catalog image.
    static var smiling39: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling39)
#else
        .init()
#endif
    }

    /// The "smiling-4" asset catalog image.
    static var smiling4: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling4)
#else
        .init()
#endif
    }

    /// The "smiling-40" asset catalog image.
    static var smiling40: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling40)
#else
        .init()
#endif
    }

    /// The "smiling-41" asset catalog image.
    static var smiling41: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling41)
#else
        .init()
#endif
    }

    /// The "smiling-42" asset catalog image.
    static var smiling42: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling42)
#else
        .init()
#endif
    }

    /// The "smiling-43" asset catalog image.
    static var smiling43: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling43)
#else
        .init()
#endif
    }

    /// The "smiling-44" asset catalog image.
    static var smiling44: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling44)
#else
        .init()
#endif
    }

    /// The "smiling-45" asset catalog image.
    static var smiling45: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling45)
#else
        .init()
#endif
    }

    /// The "smiling-46" asset catalog image.
    static var smiling46: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling46)
#else
        .init()
#endif
    }

    /// The "smiling-47" asset catalog image.
    static var smiling47: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling47)
#else
        .init()
#endif
    }

    /// The "smiling-48" asset catalog image.
    static var smiling48: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling48)
#else
        .init()
#endif
    }

    /// The "smiling-49" asset catalog image.
    static var smiling49: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling49)
#else
        .init()
#endif
    }

    /// The "smiling-5" asset catalog image.
    static var smiling5: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling5)
#else
        .init()
#endif
    }

    /// The "smiling-50" asset catalog image.
    static var smiling50: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling50)
#else
        .init()
#endif
    }

    /// The "smiling-6" asset catalog image.
    static var smiling6: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling6)
#else
        .init()
#endif
    }

    /// The "smiling-7" asset catalog image.
    static var smiling7: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling7)
#else
        .init()
#endif
    }

    /// The "smiling-8" asset catalog image.
    static var smiling8: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling8)
#else
        .init()
#endif
    }

    /// The "smiling-9" asset catalog image.
    static var smiling9: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .smiling9)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "botIcon" asset catalog image.
    static var botIcon: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .botIcon)
#else
        .init()
#endif
    }

    /// The "smiling-0" asset catalog image.
    static var smiling0: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling0)
#else
        .init()
#endif
    }

    /// The "smiling-1" asset catalog image.
    static var smiling1: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling1)
#else
        .init()
#endif
    }

    /// The "smiling-10" asset catalog image.
    static var smiling10: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling10)
#else
        .init()
#endif
    }

    /// The "smiling-11" asset catalog image.
    static var smiling11: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling11)
#else
        .init()
#endif
    }

    /// The "smiling-12" asset catalog image.
    static var smiling12: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling12)
#else
        .init()
#endif
    }

    /// The "smiling-13" asset catalog image.
    static var smiling13: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling13)
#else
        .init()
#endif
    }

    /// The "smiling-14" asset catalog image.
    static var smiling14: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling14)
#else
        .init()
#endif
    }

    /// The "smiling-15" asset catalog image.
    static var smiling15: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling15)
#else
        .init()
#endif
    }

    /// The "smiling-16" asset catalog image.
    static var smiling16: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling16)
#else
        .init()
#endif
    }

    /// The "smiling-17" asset catalog image.
    static var smiling17: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling17)
#else
        .init()
#endif
    }

    /// The "smiling-18" asset catalog image.
    static var smiling18: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling18)
#else
        .init()
#endif
    }

    /// The "smiling-19" asset catalog image.
    static var smiling19: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling19)
#else
        .init()
#endif
    }

    /// The "smiling-2" asset catalog image.
    static var smiling2: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling2)
#else
        .init()
#endif
    }

    /// The "smiling-20" asset catalog image.
    static var smiling20: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling20)
#else
        .init()
#endif
    }

    /// The "smiling-21" asset catalog image.
    static var smiling21: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling21)
#else
        .init()
#endif
    }

    /// The "smiling-22" asset catalog image.
    static var smiling22: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling22)
#else
        .init()
#endif
    }

    /// The "smiling-23" asset catalog image.
    static var smiling23: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling23)
#else
        .init()
#endif
    }

    /// The "smiling-24" asset catalog image.
    static var smiling24: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling24)
#else
        .init()
#endif
    }

    /// The "smiling-25" asset catalog image.
    static var smiling25: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling25)
#else
        .init()
#endif
    }

    /// The "smiling-26" asset catalog image.
    static var smiling26: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling26)
#else
        .init()
#endif
    }

    /// The "smiling-27" asset catalog image.
    static var smiling27: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling27)
#else
        .init()
#endif
    }

    /// The "smiling-28" asset catalog image.
    static var smiling28: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling28)
#else
        .init()
#endif
    }

    /// The "smiling-29" asset catalog image.
    static var smiling29: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling29)
#else
        .init()
#endif
    }

    /// The "smiling-3" asset catalog image.
    static var smiling3: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling3)
#else
        .init()
#endif
    }

    /// The "smiling-30" asset catalog image.
    static var smiling30: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling30)
#else
        .init()
#endif
    }

    /// The "smiling-31" asset catalog image.
    static var smiling31: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling31)
#else
        .init()
#endif
    }

    /// The "smiling-32" asset catalog image.
    static var smiling32: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling32)
#else
        .init()
#endif
    }

    /// The "smiling-33" asset catalog image.
    static var smiling33: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling33)
#else
        .init()
#endif
    }

    /// The "smiling-34" asset catalog image.
    static var smiling34: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling34)
#else
        .init()
#endif
    }

    /// The "smiling-35" asset catalog image.
    static var smiling35: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling35)
#else
        .init()
#endif
    }

    /// The "smiling-36" asset catalog image.
    static var smiling36: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling36)
#else
        .init()
#endif
    }

    /// The "smiling-37" asset catalog image.
    static var smiling37: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling37)
#else
        .init()
#endif
    }

    /// The "smiling-38" asset catalog image.
    static var smiling38: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling38)
#else
        .init()
#endif
    }

    /// The "smiling-39" asset catalog image.
    static var smiling39: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling39)
#else
        .init()
#endif
    }

    /// The "smiling-4" asset catalog image.
    static var smiling4: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling4)
#else
        .init()
#endif
    }

    /// The "smiling-40" asset catalog image.
    static var smiling40: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling40)
#else
        .init()
#endif
    }

    /// The "smiling-41" asset catalog image.
    static var smiling41: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling41)
#else
        .init()
#endif
    }

    /// The "smiling-42" asset catalog image.
    static var smiling42: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling42)
#else
        .init()
#endif
    }

    /// The "smiling-43" asset catalog image.
    static var smiling43: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling43)
#else
        .init()
#endif
    }

    /// The "smiling-44" asset catalog image.
    static var smiling44: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling44)
#else
        .init()
#endif
    }

    /// The "smiling-45" asset catalog image.
    static var smiling45: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling45)
#else
        .init()
#endif
    }

    /// The "smiling-46" asset catalog image.
    static var smiling46: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling46)
#else
        .init()
#endif
    }

    /// The "smiling-47" asset catalog image.
    static var smiling47: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling47)
#else
        .init()
#endif
    }

    /// The "smiling-48" asset catalog image.
    static var smiling48: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling48)
#else
        .init()
#endif
    }

    /// The "smiling-49" asset catalog image.
    static var smiling49: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling49)
#else
        .init()
#endif
    }

    /// The "smiling-5" asset catalog image.
    static var smiling5: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling5)
#else
        .init()
#endif
    }

    /// The "smiling-50" asset catalog image.
    static var smiling50: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling50)
#else
        .init()
#endif
    }

    /// The "smiling-6" asset catalog image.
    static var smiling6: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling6)
#else
        .init()
#endif
    }

    /// The "smiling-7" asset catalog image.
    static var smiling7: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling7)
#else
        .init()
#endif
    }

    /// The "smiling-8" asset catalog image.
    static var smiling8: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling8)
#else
        .init()
#endif
    }

    /// The "smiling-9" asset catalog image.
    static var smiling9: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .smiling9)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ColorResource {

    private init?(thinnableName: String, bundle: Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ImageResource {

    private init?(thinnableName: String, bundle: Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

// MARK: - Backwards Deployment Support -

/// A color resource.
struct ColorResource: Hashable {

    /// An asset catalog color resource name.
    fileprivate let name: String

    /// An asset catalog color resource bundle.
    fileprivate let bundle: Bundle

    /// Initialize a `ColorResource` with `name` and `bundle`.
    init(name: String, bundle: Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

/// An image resource.
struct ImageResource: Hashable {

    /// An asset catalog image resource name.
    fileprivate let name: String

    /// An asset catalog image resource bundle.
    fileprivate let bundle: Bundle

    /// Initialize an `ImageResource` with `name` and `bundle`.
    init(name: String, bundle: Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// Initialize a `NSColor` with a color resource.
    convenience init(resource: ColorResource) {
        self.init(named: NSColor.Name(resource.name), bundle: resource.bundle)!
    }

}

protocol _ACResourceInitProtocol {}
extension AppKit.NSImage: _ACResourceInitProtocol {}

@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension _ACResourceInitProtocol {

    /// Initialize a `NSImage` with an image resource.
    init(resource: ImageResource) {
        self = resource.bundle.image(forResource: NSImage.Name(resource.name))! as! Self
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// Initialize a `UIColor` with a color resource.
    convenience init(resource: ColorResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}

@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// Initialize a `UIImage` with an image resource.
    convenience init(resource: ImageResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    /// Initialize a `Color` with a color resource.
    init(_ resource: ColorResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Image {

    /// Initialize an `Image` with an image resource.
    init(_ resource: ImageResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}
#endif