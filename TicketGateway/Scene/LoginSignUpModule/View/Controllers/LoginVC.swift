//
//  LoginVC.swift
//  TicketGateway
//
//  Created by Apple  on 11/04/23.
//

import UIKit
import SVProgressHUD

class LoginVC: UIViewController{
    
  //MARK: - Outlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var vwFaceBook: UIView!
    @IBOutlet weak var vwGoogle: UIView!
    @IBOutlet weak var vwApple: UIView!
    @IBOutlet weak var vwEmail: UIView!
    @IBOutlet weak var vwPassword: UIView!
    @IBOutlet weak var vwNumber: UIView!
    @IBOutlet weak var vwNumberHeading: UIView!
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var btnLogin: CustomButtonGradiant!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnNumber: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnApple: UIButton!
    @IBOutlet weak var btnFaceBook: UIButton!
    @IBOutlet weak var btnGmail: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnSelectCountry: UIButton!
    @IBOutlet weak var imgNumber: UIImageView!
    @IBOutlet weak var imgEmail: UIImageView!
    @IBOutlet weak var imgCountry: UIImageView!
    @IBOutlet weak var lblDialCountryCode: UILabel!
     @IBOutlet weak var btnEye: UIButton!
    
    // MARK: - Variable
    let viewModel = SignInViewModel()
    let viewModelSocialSignIN = socialSignInVC()
    var isFromNumberOrEmail = true // number = false , email = true
    var isFromWelcomeScreen = false
    var strCountryDialCode: String = "+91"
    var strCountryCode: String = "IN"
    var strCountryName: String = "India"
    var countries = [[String: String]]()
    var RScountriesModel = [CountryInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setIntialUiDesign()
      //self.jsonSerial()
     // self.collectCountries()
        //Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
}

// MARK: - Functions
extension LoginVC {
    private func setup() {
        self.jsonSerial()
        self.collectCountries()
        [self.btnEmail, self.btnNumber, self.btnLogin, self.btnSignUp, self.btnForgotPassword,self.btnSkip,self.btnSelectCountry,self.btnEye,self.btnGmail,self.btnFaceBook,self.btnApple].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        self.imgCountry.image = nil
        self.txtEmail.delegate = self
        self.txtNumber.delegate = self
        self.txtPassword.delegate = self
        self.vwNumber.layer.cornerRadius = 5
        self.vwNumber.layer.borderWidth = 0.5
        self.vwNumber.layer.borderColor = UIColor.lightGray.cgColor
        self.isFromNumberOrEmailUI()
        self.btnLogin.setTitles(text: "Login", font: .systemFont(ofSize: 14), tintColour: .black)
        self.btnEye.setImage(UIImage(named: "eyeClose"), for: .normal)
        self.txtPassword.isSecureTextEntry = true
        self.btnLogin.addRightIcon(image: UIImage(named: "rightOnButton"))
    }
    func isFromNumberOrEmailUI(){
        if isFromNumberOrEmail == true {
            self.vwEmail.isHidden = false
            self.vwPassword.isHidden = false
            self.vwNumber.isHidden = true
            self.vwNumberHeading.isHidden = true
            self.imgEmail.image = UIImage(named: "active")
            self.imgNumber.image = UIImage(named: "unActive")
            self.txtEmail.text = ""
            self.txtPassword.text = ""
            self.viewModel.isForEmail = true
        } else {
            self.vwEmail.isHidden = true
            self.vwPassword.isHidden = true
            self.vwNumber.isHidden = false
            self.vwNumberHeading.isHidden = false
            self.imgEmail.image = UIImage(named: "unActive")
            self.imgNumber.image = UIImage(named: "active")
            self.txtNumber.text = ""
            self.viewModel.isForEmail = false
           
        }
    }
}
// MARK: - Actions
extension LoginVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnLogin:
            self.btnLoginAction()
        case btnEmail:
            self.btnEmailAction()
        case btnSignUp:
            self.btnSignUpAction()
        case btnForgotPassword:
            self.btnForgotPasswordAction()
        case btnNumber:
            self.btnNumberAction()
        case btnSkip :
            self.btnSkipAction()
        case btnSelectCountry : self.btnSelectCountryAction()
        case btnEye :
            btnEyeAction()
        case btnGmail: btnGoogleAction()
        case btnFaceBook: btnFaceBookAction()
        case btnApple : btnAppleAction()
        default:
            break
        }
    }
    func btnEyeAction(){
        if self.txtPassword.isSecureTextEntry == false{
            self.btnEye.setImage(UIImage(named: "eyeClose"), for: .normal)
            self.txtPassword.isSecureTextEntry = true
        }
        else {
            self.btnEye.setImage(UIImage(named: "eyeOpen"), for: .normal)
            self.txtPassword.isSecureTextEntry = false
        }
    }
    
    func btnSkipAction(){
        objSceneDelegate.showTabBar()
    }
    
    func btnLoginAction(){
        print("Login Tapped")
        let isValidate = viewModel.validateUserInput
        if isValidate.isValid {
            if Reachability.isConnectedToNetwork(){
                SVProgressHUD.show()
                viewModel.signInAPI { isTrue , messageShowToast in
                    if isTrue == true {
                        DispatchQueue.main.async { [self] in
                            SVProgressHUD.dismiss()
                            if self.isFromNumberOrEmail == true {
                                objSceneDelegate.showTabBar()
                            } else {
                                let view = self.createView(storyboard: .main, storyboardID: .OtpNumberVC) as! OtpNumberVC
                                let obj =   DataHoldOnSignUpProcessModel.init(strEmail: self.txtEmail.text ?? "", strNumber:   self.txtNumber.text ?? "" ,strStatus: "",strDialCountryCode: self.lblDialCountryCode.text!,strCountryCode: self.strCountryCode)
                                 objAppShareData.DicToHoldDataOnSignUpModule = obj
                                view.viewModel.number = "\(lblDialCountryCode.text ?? "") " + "-" + (self.txtNumber.text ?? "")
                                self.navigationController?.pushViewController(view, animated: true)
                            }
                        }
                    }
                    else {
                        DispatchQueue.main.async {
                            SVProgressHUD.dismiss()
                            self.showToast(message: messageShowToast)
                        }
                    }
                }
              } else {
                  self.showToast(message: ValidationConstantStrings.networkLost)
            }
            
        } else {
            DispatchQueue.main.async {
               self.showToast(message: isValidate.errormessage)
            }
        }
      }

    func btnSignUpAction() {
        if  self.isFromWelcomeScreen == true {
            let view = self.createView(storyboard: .main, storyboardID: .SignUpVC)
            let viewC = view as? SignUpVC
            viewC?.isFromWelcomeScreen = false
            self.navigationController?.pushViewController(view, animated: true)
        } else {
            self.isFromWelcomeScreen = false
            self.navigationController?.popViewController(animated: true)
        }
    }
    func btnEmailAction() {
        self.isFromNumberOrEmail = true
        self.isFromNumberOrEmailUI()
    }
    func btnNumberAction() {
        self.isFromNumberOrEmail = false
        self.isFromNumberOrEmailUI()
    }
    func btnForgotPasswordAction() {
        let view = self.createView(storyboard: .main, storyboardID: .ForgotPasswordVC)
        self.navigationController?.pushViewController(view, animated: true)
    }
    func btnSelectCountryAction(){
        self.view.endEditing(true)
         let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RSCountryPickerController")as! RSCountryPickerController
        sb.RScountryDelegate = self
        sb.strCheckCountry = self.strCountryName
        sb.modalPresentationStyle = .fullScreen
        self.navigationController?.present(sb, animated: true, completion: nil)
    }
    func btnAppleAction() {
        self.viewModelSocialSignIN.funcAppleLoginIntegration(uiviewController: self)
    }
    func btnGoogleAction() {
        viewModelSocialSignIN.funGoogleSignIn(uiviewController: self)
    }
    func btnFaceBookAction() {
        viewModelSocialSignIN.funcFaceBookSignIn(uiviewController: self)
    }
}


// MARK: -
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if isFromNumberOrEmail == true {
            if textField == self.txtEmail {
                self.txtPassword.becomeFirstResponder()
            } else if textField == self.txtPassword {
                self.txtPassword.resignFirstResponder()
            }
        }
        else {
            if  textField == self.txtNumber {
                self.txtNumber.resignFirstResponder()
            }
        }
        return false
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let textRange = Range(range, in: text) else { return false }
        if textField == txtEmail {
            viewModel.email = text.replacingCharacters(in: textRange, with: string)
        } else if textField == txtPassword {
            viewModel.password = text.replacingCharacters(in: textRange, with: string)
        } else if textField == txtNumber{
            viewModel.number = "\(self.lblDialCountryCode.text ?? "" )\(text.replacingCharacters(in: textRange, with: string))"
        }
        return true
    }
    
}

// MARK: - Country Code
extension LoginVC :  RSCountrySelectedDelegate  {
    func setIntialUiDesign()
    {
        self.txtNumber.addDoneButtonOnKeyboard()
        //Defoult Country
         //UI Changes---
        self.imgCountry.image = nil
        if self.imgCountry.image == nil
        {
            let str = NSLocale.current.regionCode
            let imagePath = "CountryPicker.bundle/\(str ?? "IN").png"
            self.imgCountry.image = UIImage(named: imagePath)
            self.lblDialCountryCode.text = "+91"
            let arr = RScountriesModel.filter({$0.country_code == str})
            
            if arr.count>0{
                let country = arr[0]
                strCountryDialCode = country.dial_code
                self.lblDialCountryCode.text = country.dial_code
                self.strCountryCode = country.country_code
                self.strCountryName = country.country_name
                self.lblDialCountryCode.text = country.dial_code
                self.strCountryCode = country.country_code
                let imagePath = "CountryPicker.bundle/\( country.country_code).png"
                self.imgCountry.image = UIImage(named: imagePath)
            }
        }
        else{
            //noting to do
        }
    }
    func jsonSerial() {
        let data = try? Data(contentsOf: URL(fileURLWithPath: (Bundle.main.path(forResource: "countries", ofType: "json"))!))
        do {
            let parsedObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            countries = parsedObject as! [[String : String]]
            
        }catch{
            
        }
    }
    
    func collectCountries() {
        for country in countries  {
            let code = country["code"] ?? ""
            let name = country["name"] ?? ""
            let dailcode = country["dial_code"] ?? ""
            RScountriesModel.append(CountryInfo(country_code:code,dial_code:dailcode, country_name:name))
        }
    }
    
    func RScountrySelected(countrySelected country: CountryInfo) {
        let imagePath = "CountryPicker.bundle/\(country.country_code).png"
        self.imgCountry.image = UIImage(named: imagePath)
        self.strCountryDialCode = country.dial_code
        self.lblDialCountryCode.text = country.dial_code
        self.strCountryCode = country.country_code
        self.strCountryName = country.country_name
        self.txtNumber.becomeFirstResponder()
    }
}
///////
///
///
///
///
///
///import Foundation
// MARK: - ChatConversationListModel
struct ChatConversationListModel: Codable {
  let conversationList: [ConversationList]
  enum CodingKeys: String, CodingKey {
    case conversationList = "conversation_list"
  }
}
// MARK: - ConversationList
struct ConversationList: Codable {
    
  let accessToken, conversationSid, roomName: String
  let userID: Int
  let userProfileimage: String
  let therapistID: Int
  let therapistProfileimage: String
  let receiverID: Int
  let receiverUserName, receiverUserFullName, conversationCreatedBy, lastMessage: String
  let lastMessageTime: String
  let totalMessageCount: Int
  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case conversationSid = "conversation_sid"
    case roomName = "room_name"
    case userID = "user_id"
    case userProfileimage = "user_profileimage"
    case therapistID = "therapist_id"
    case therapistProfileimage = "therapist_profileimage"
    case receiverID = "receiver_id"
    case receiverUserName = "receiver_user_name"
    case receiverUserFullName = "receiver_user_full_name"
    case conversationCreatedBy = "conversation_created_by"
    case lastMessage = "last_message"
    case lastMessageTime = "last_message_time"
    case totalMessageCount = "total_message_count"
  }
}





