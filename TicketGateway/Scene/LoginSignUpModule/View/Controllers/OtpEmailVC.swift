//
//  OtpVCSViewController.swift
//  TicketGateway
//
//  Created by Apple on 13/04/23.
//

import UIKit
import SVProgressHUD
class OtpEmailVC: UIViewController {
  // MARK: - Outlets
    
  @IBOutlet weak var btnContinue: CustomButtonGradiant!
  @IBOutlet weak var navigationView: NavigationBarView!
  @IBOutlet weak var txtOtp1: UITextField!
  @IBOutlet weak var txtOtp2: UITextField!
  @IBOutlet weak var txtOtp3: UITextField!
  @IBOutlet weak var txtOtp4: UITextField!
  @IBOutlet weak var lblSentVerification: UILabel!
  @IBOutlet weak var lblEmailId: UILabel!
    @IBOutlet weak var lblReceiveOtp: UILabel!
    @IBOutlet weak var vwResend: UIView!
    @IBOutlet weak var btnResendOtp: UIButton!
    
  // MARK: - Variable
 let viewModel =  EmailVerifyViewModel()
 let viewModelResendOtp = SignUpViewModel()
 var countdownTimer: Timer!
 var totalTime = 60
    
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setup()
    // Do any additional setup after loading the view.
  }
}

// MARK: - Functions
extension OtpEmailVC {
  private func setup() {
      [self.btnContinue, self.btnResendOtp].forEach {
      $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }
    [self.txtOtp1,self.txtOtp2,self.txtOtp3,self.txtOtp4].forEach{$0?.delegate = self}
    [self.txtOtp1,self.txtOtp2,self.txtOtp3,self.txtOtp4].forEach{$0?.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)}
    navigationView.delegateBarAction = self
    self.btnContinue.addRightIcon(image: UIImage(named: "rightOnButton"))
    btnContinue.setTitles(text: "Continue", font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
    navigationView.lblTitle.text = "OTP Verification"
    navigationView.btnBack.isHidden = false
    navigationView.delegateBarAction = self
    if viewModel.email != "" {
      self.lblEmailId.text = viewModel.email
    }
      self.startTimer()
      self.vwResend.isHidden = true
  }
}
// MARK: - Actions
extension OtpEmailVC {
  @objc func buttonPressed(_ sender: UIButton) {
    switch sender {
    case btnContinue:
      self.btnContinueAction()
    case btnResendOtp :
        self.btnResenOtpAction()
    default:
      break
    }
  }
    
    
    
    
   func btnResenOtpAction() {
       
             if Reachability.isConnectedToNetwork(){
                SVProgressHUD.show()
                viewModelResendOtp.signUpEmailAPI { isTrue , messageShowToast in
                    if isTrue == true {
                        DispatchQueue.main.async {
                            SVProgressHUD.dismiss()
                            [self.txtOtp1,self.txtOtp2,self.txtOtp3,self.txtOtp4].forEach{$0?.text = ""}
                            self.totalTime = 60
                            self.startTimer()
                            self.vwResend.isHidden = true
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
                    self.showToast(message: "Netrwork")
            }
            
        }
    func btnContinueAction() {
        if self.txtOtp1.text ?? "" == "" || self.txtOtp2.text ?? "" == "" || self.txtOtp3.text ?? "" == "" || self.txtOtp4.text ?? "" == "" {
            self.showToast(message: "Please enter otp")
        } else {
            
            let isValidate = viewModel.validateUserInput
            let otp = "\(txtOtp1.text ?? "")" + "\(txtOtp2.text ?? "")" + "\(txtOtp3.text ?? "")" + "\(txtOtp4.text ?? "")"
            viewModel.email = lblEmailId.text ?? ""
            viewModel.otp = otp
            if isValidate.isValid {
                if Reachability.isConnectedToNetwork(){
                    SVProgressHUD.show()
                    
                    viewModel.signUpVerifyEmailAPI(complition: { isTrue, messageShowToast  in
                        if isTrue == true {
                            SVProgressHUD.dismiss()
                            DispatchQueue.main.async {
                                let view = self.createView(storyboard: .main, storyboardID: .VerifyPopupVC) as! VerifyPopupVC
                                view.strMessage = "Your email has been verified successfully!"
                                view.closerForBack = { istrue in
                                    if istrue ==  true
                                    {
                                        let view = self.createView(storyboard: .main, storyboardID: .CreateAccountVC)
                                        self.navigationController?.pushViewController(view, animated: false)
                                    }
                                }
                                view.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext;
                                self.present(view, animated: true)
                            }
                        } else {
                            DispatchQueue.main.async {
                                SVProgressHUD.dismiss()
                                self.showToast(message: messageShowToast)
                            }
                        }
                    })
                }else {
                    self.showToast(message: ValidationConstantStrings.networkLost)
                }
            }
            else {
                
                self.showToast(message: isValidate.errormessage)
                
                
            }  }
        
    }
}


extension OtpEmailVC : UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
  @objc func textFieldDidChange(textField: UITextField){
    let text = textField.text
    if text?.count == 1 {
      switch textField{
      case txtOtp1:
        txtOtp2.becomeFirstResponder()
      case txtOtp2:
        txtOtp3.becomeFirstResponder()
      case txtOtp3:
        txtOtp4.becomeFirstResponder()
      case txtOtp4:
        txtOtp4.resignFirstResponder()
      default:
        break
      }
    }else if text?.count == 0{
      switch textField{
      case txtOtp1:
        txtOtp1.becomeFirstResponder()
      case txtOtp2:
        txtOtp1.becomeFirstResponder()
      case txtOtp3:
        txtOtp2.becomeFirstResponder()
      case txtOtp4:
          
        txtOtp3.becomeFirstResponder()
      default:
        break
      }
    }else if text?.count ?? 0 >= 2 {
      switch textField{
      case txtOtp1:
        var string = txtOtp1.text
        string?.removeFirst()
        txtOtp1.text = string
        txtOtp2.becomeFirstResponder()
      case txtOtp2:
        var string = txtOtp2.text
        string?.removeFirst()
        txtOtp2.text = string
        txtOtp3.becomeFirstResponder()
      case txtOtp3:
        var string = txtOtp3.text
        string?.removeFirst()
        txtOtp3.text = string
        txtOtp4.becomeFirstResponder()
      case txtOtp4:
        var string = txtOtp4.text
        string?.removeFirst()
        txtOtp4.text = string
        txtOtp4.resignFirstResponder()
      default:
        break
      }
    }
    else{
    }
  }
}
// MARK: - NavigationBarViewDelegate
extension OtpEmailVC : NavigationBarViewDelegate {
  func navigationBackAction() {
      countdownTimer.invalidate()
    self.navigationController?.popViewController(animated: true)
  }
}

extension OtpEmailVC {
    func startTimer() {
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }

    @objc func updateTime() {
        print(timeFormatted(totalTime))
              
            lblReceiveOtp.text = "Your OTP will expire in \(timeFormatted(totalTime))"

            if totalTime != 0 {
                totalTime -= 1
            } else {
                endTimer()
            }
        }

        func endTimer() {
            self.viewModelResendOtp.email = objAppShareData.DicToHoldDataOnSignUpModule?.strEmail ?? ""
             self.vwResend.isHidden = false
            countdownTimer.invalidate()
            
        }

        func timeFormatted(_ totalSeconds: Int) -> String {
            let seconds: Int = totalSeconds % 60
            let minutes: Int = (totalSeconds / 60) % 60
            //     let hours: Int = totalSeconds / 3600
            return String(format: "%02d:%02d", minutes, seconds)
        }


    }















