//
//  BindingExtensions.swift
//  RxSwiftTextField
//
//  Created by 三浦　知明 on 2020/01/12.
//  Copyright © 2020 三浦　知明. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//protocols
enum ValidationResult {
    case ok(message: String)
    case empty
    case validating
    case failed(message: String)
}

protocol GithubValidationService {
    func validationUsername(_ username: String) -> ValidationResult
    func validationPassword(_ password: String) -> ValidationResult
}

extension ValidationResult: CustomStringConvertible {
    var description: String {
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return ""
        case .validating:
            return "validating ..."
        case let .failed(message):
            return message
        }
    }
}


struct ValidationColors {
    static let okColor = UIColor(red: 138.0 / 255.0, green: 221.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
    static let errorColor = UIColor.red
}

extension ValidationResult {
    var textColor: UIColor {
        switch self {
        case .ok:
            return ValidationColors.okColor
        case .empty:
            return UIColor.black
        case .validating:
            return UIColor.black
        case .failed:
            return ValidationColors.errorColor
        }
    }
}

extension ValidationResult {
    var textFont: UIFont {
        switch self {
        case .ok:
            return ValidationFont.bigFont
        default:
            return ValidationFont.normalFont
        }
    }
}

struct ValidationFont {
    static let bigFont = UIFont.systemFont(ofSize: 20.0)
    static let normalFont = UIFont.systemFont(ofSize: 12.0)
}

extension Reactive where Base: UILabel {
    var validationResult: Binder<ValidationResult> {
        return Binder(base) { label, result in
            label.textColor = result.textColor
            label.text = result.description
            label.font = result.textFont
        }
    }
}

extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}



