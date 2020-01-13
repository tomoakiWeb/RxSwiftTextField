//
//  defaultValidationService.swift
//  RxSwiftTextField
//
//  Created by 三浦　知明 on 2020/01/13.
//  Copyright © 2020 三浦　知明. All rights reserved.
//

import Foundation

class defaultValidationService: GithubValidationService {
    
   static let sharedValidationService = defaultValidationService()
    
    let minUsernameCount = 3
    let minPasswordCount = 4
    let maxPasswordCount = 8
    
    func validationUsername(_ username: String) -> ValidationResult {
        let numberOfCharacter = username.count
        if numberOfCharacter == 0 {
            return .empty
        }
        
        if numberOfCharacter < minUsernameCount {
            return .failed(message: "\(minUsernameCount)文字以上入力してください")
        }
        return .ok(message: "username OK")
    }
    
    func validationPassword(_ password: String) -> ValidationResult {
        let numberOfCharacter = password.count
        if numberOfCharacter == 0 {
            return .empty
        }
        if numberOfCharacter < minPasswordCount || numberOfCharacter > maxPasswordCount {
            return .failed(message: "\(minPasswordCount)文字以上,\(maxPasswordCount)以下で入力してください")
        }
        return .ok(message: "password OK")
    }
    
        
    
}

