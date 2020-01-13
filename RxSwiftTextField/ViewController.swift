//
//  ViewController.swift
//  RxSwiftTextField
//
//  Created by 三浦　知明 on 2020/01/12.
//  Copyright © 2020 三浦　知明. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameOutlet: UILabel!
    @IBOutlet weak var passwordTextField:UITextField!
    @IBOutlet weak var passwordOutlet: UILabel!

    @IBOutlet weak var signupButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = TextFieldViewModel(
            username: usernameTextField.rx.text.orEmpty.asDriver(),
            password: passwordTextField.rx.text.orEmpty.asDriver(),
            validationService: defaultValidationService.sharedValidationService
        )
        
        viewModel.signupEnabled
            .drive(onNext: {[weak self] valid in
                self?.signupButton.isEnabled = valid
                self?.signupButton.alpha = valid ? 1.0 : 0.2
            })
        
        viewModel.validatedUsername
            .drive(usernameOutlet.rx.validationResult)
            .disposed(by:disposeBag)
        
        viewModel.validatedPassword
            .drive(passwordOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        
        

        
            
    }
}

