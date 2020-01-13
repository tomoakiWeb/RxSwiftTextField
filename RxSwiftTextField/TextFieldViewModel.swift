//
//  TextFieldViewModel.swift
//  RxSwiftTextField
//
//  Created by 三浦　知明 on 2020/01/12.
//  Copyright © 2020 三浦　知明. All rights reserved.
//

import RxSwift
import RxCocoa

class TextFieldViewModel {
    let validatedUsername: Driver<ValidationResult>
    let validatedPassword: Driver<ValidationResult>
    
    let signupEnabled: Driver<Bool>
    
    init (username: Driver<String>,
          password: Driver<String>,
          validationService: GithubValidationService)
    {
        let validationService = validationService
        
        validatedUsername = username
            .map{ username in
                return validationService.validationUsername(username)
        }
        validatedPassword = password
            .map { password in
                return validationService.validationPassword(password)
        }
        
        signupEnabled = Driver.combineLatest(
        validatedUsername,
        validatedPassword
        ){ username ,password in
            username.isValid &&
            password.isValid
        }
        .distinctUntilChanged()
    }
    
}
