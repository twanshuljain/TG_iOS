//
//  SignUpVC.swift
//  TicketGateway
//
//  Created by Apple  on 11/04/23.
//

import UIKit
import SVProgressHUD

class SignUpVC: UIViewController{
    
    // MARK: - Outlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var vwEmail: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: CustomButtonGradiant!
    @IBOutlet weak var btnApple: UIButton!
    @IBOutlet weak var btnFaceBook: UIButton!
    @IBOutlet weak var btnGmail: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var lblSignUp: UILabel!
    @IBOutlet weak var lblSignUnWith: UILabel!
    @IBOutlet weak var lblVerifyYourEmail: UILabel!
    @IBOutlet weak var lblAlreadHaveAccount: UILabel!
   
    // MARK: - Variable
    let viewModel = SignUpViewModel()
    let viewModelSocialSignIN = socialSignInVC()
    
    var isFromWelcomeScreen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        // Do any additional setup after loading the view.
    }
}

// MARK: - Functions
extension SignUpVC {
    private func setup() {
        [ self.btnLogin, self.btnSignUp, self.btnApple,self.btnGmail,self.btnFaceBook,self.btnSkip,self.btnApple,self.btnGmail,self.btnFaceBook].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.txtEmail.delegate = self
        self.btnSignUp.setTitles(text: "Continue", font: .systemFont(ofSize: 14), tintColour: .black)
        self.btnSignUp.addRightIcon(image: UIImage(named: "rightOnButton"))
        self.setUI()
      }
       private func setUI(){
            self.lblSignUp.font = UIFont.setFont(fontType: .bold, fontSize: .twentyFour)
            self.lblSignUnWith.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
            self.lblVerifyYourEmail.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
            self.lblAlreadHaveAccount.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
            self.btnSkip.titleLabel?.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
            self.btnSignUp.titleLabel?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            self.btnLogin.titleLabel?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
           self.txtEmail.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
         //  self.txtEmail.placeholder. = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
           self.btnLogin.setTitleColor(UIColor.setColor(colorType: .btnDarkBlue), for: .normal)
          
           self.btnSignUp.tintColor = UIColor.setColor(colorType: .btnDarkBlue)
           self.lblSignUp.tintColor = UIColor.setColor(colorType: .btnDarkBlue)
           self.lblSignUnWith.tintColor = UIColor.setColor(colorType: .lblTextPara)
           self.lblVerifyYourEmail.tintColor = UIColor.setColor(colorType: .lblTextPara)
           self.lblAlreadHaveAccount.tintColor = UIColor.setColor(colorType: .lblTextPara)
           
            
        }
}


// MARK: - Actions
extension SignUpVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnLogin:
            self.btnLoginAction()
        case btnSignUp:
            self.btnSignUpAction()
        case btnApple:
            self.btnAppleAction()
        case btnGmail:
            self.btnGoogleAction()
        case btnFaceBook:
            self.btnFaceBookAction()
        case btnSkip :
            self.btnSkipAction()
        default:
            break
        }
    }
    func btnSkipAction(){
        objSceneDelegate.showTabBar()
    }
    func btnLoginAction() {
        if isFromWelcomeScreen == true {
            let view = self.createView(storyboard: .main, storyboardID: .LoginVC)
            let viewC = view as? LoginVC
            viewC?.isFromWelcomeScreen = false
            self.navigationController?.pushViewController(view, animated: true)
        } else {
            self.isFromWelcomeScreen = false
            self.navigationController?.popViewController(animated: true)
        }
    }
    func btnSignUpAction() {
            let isValidate = viewModel.validateUserInput
        if isValidate.isValid {
            if Reachability.isConnectedToNetwork(){
                SVProgressHUD.show()
                viewModel.signUpEmailAPI(complition: { isTrue , messageShowToast in
                    if isTrue == true {
                        SVProgressHUD.dismiss()
                        DispatchQueue.main.async {
                            let view = self.createView(storyboard: .main, storyboardID: .OtpEmailVC) as! OtpEmailVC
                            let obj =   DataHoldOnSignUpProcessModel.init(strEmail: self.txtEmail.text ?? "", strNumber: "" ,strStatus: "",strDialCountryCode: "",strCountryCode: "")
                            objAppShareData.DicToHoldDataOnSignUpModule = obj
                            view.viewModel.email =  objAppShareData.DicToHoldDataOnSignUpModule?.strEmail ?? ""
                            self.navigationController?.pushViewController(view, animated: true)
                        }
                    } else {
                        DispatchQueue.main.async {
                            SVProgressHUD.dismiss()
                            self.showToast(message: messageShowToast)
                        }
                    }
                })
            } else {
              
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    self.showToast(message: ValidationConstantStrings.networkLost)
                }
                
            }
        } else {
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self.showToast(message: isValidate.errormessage)
            }
        }
        }
       
    
    
    func btnForgotPasswordAction() {
        
    }
    func btnAppleAction() {
        self.viewModelSocialSignIN.funcAppleLoginIntegration(uiviewController: self)
    }
    func btnGoogleAction() {
        self.viewModelSocialSignIN.funGoogleSignIn(uiviewController: self)
    }
    func btnFaceBookAction() {
        self.viewModelSocialSignIN.funcFaceBookSignIn(uiviewController: self)
        
    }
    
}
extension SignUpVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtEmail {
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
