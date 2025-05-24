//
//  Style+Font.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 23/05/2025.
//

import SwiftUI

public extension Style {
    enum Font {
        /// theme-heading-02
        case heading02

        /// theme-button-01
        case button01

        /// theme-button-02
        case button02
    }
}

public extension Style.Font {
    var font: UIFont {
        UIFont.systemFont(ofSize: fontSize.scaledSize, weight: fontWeight.value)
    }

    var size: CGFloat {
        fontSize.rawValue
    }

    internal var lineHeight: Size {
        switch self {
        case .heading02:
            .eight
        case .button01:
            .six
        case .button02:
            .six
        }
    }

    var lineSpacing: CGFloat {
        lineHeight.scaledSize - font.lineHeight
    }

    private var fontSize: Size {
        switch self {
        case .heading02:
            .seven
        case .button01:
            .three
        case .button02:
            .three
        }
    }

    private var fontWeight: FontWeight {
        switch self {
        case .heading02:
            .pro1
        case .button01:
            .pro0
        case .button02:
            .pro1
        }
    }
}

// MARK: - Font Weights

private enum FontWeight {
    /// .extrabold
    case pro0
    /// .semibold
    case pro1

    // we use it only when we use system font in the app
    var value: UIFont.Weight {
        switch self {
        case .pro0:
            .bold
        case .pro1:
            .semibold
        }
    }
}

// MARK: - Font Sizes & Line Height

enum Size: CGFloat {
    /// 14 px
    case three = 14
    /// 20 px
    case six = 20
    /// 24 px
    case seven = 24
    /// 28 px
    case eight = 28

    public var scaledSize: CGFloat {
        UIFontMetrics.default.scaledValue(for: rawValue)
    }
}
