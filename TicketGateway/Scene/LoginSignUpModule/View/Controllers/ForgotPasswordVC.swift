//
//  ForgotPasswordVC.swift
//  TicketGateway
//
//  Created by Apple on 13/04/23.
//

import UIKit
import SVProgressHUD

class ForgotPasswordVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblHeadingDescription: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    // MARK: - Variable
    let viewModel = ForgotPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        
        // Do any additional setup after loading the view.
    }
}

// MARK: - Functions
extension ForgotPasswordVC {
    private func setup() {
        [self.btnContinue].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        
        txtEmail.delegate = self
       self.btnContinue.setTitles(text: "Continue", font: .systemFont(ofSize: 14), tintColour: .black)
       
        navigationView.lblTitle.text = "Forgot password"
        navigationView.btnBack.isHidden = false
        navigationView.delegateBarAction = self
    }
}
// MARK: - Actions
extension ForgotPasswordVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
        default:
            break
        }
    }
    
    func btnContinueAction() {
        let isValidate = viewModel.validateUserInput
        if isValidate.isValid {
            if Reachability.isConnectedToNetwork(){
                SVProgressHUD.show()
                viewModel.forgotPasswordAPI { isTrue, messageShowToast in
                    if isTrue == true {
                        SVProgressHUD.dismiss()
                        DispatchQueue.main.async {
                            self.showToast(message: "Email link has been sent")
                        }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.navigationController?.popViewController(animated: true)
                        }
                    } else {
                        DispatchQueue.main.async {
                            SVProgressHUD.dismiss()
                            self.showToast(message: messageShowToast)
                        }
                    }
                }
            } else {
                self.showToast(message: ValidationConstantStrings.networkLost)
            }
        }
        else {
            self.showToast(message: isValidate.errormessage)
        }
    }
}

// MARK: - Delegate
extension ForgotPasswordVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if  textField == self.txtEmail {
            self.txtEmail.resignFirstResponder()
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let textRange = Range(range, in: text) else { return false }
        if textField == txtEmail {
            viewModel.email = text.replacingCharacters(in: textRange, with: string)
        }
        return true
    }
    
}
// MARK: -  NavigationBarViewDelegate
extension ForgotPasswordVC : NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}


