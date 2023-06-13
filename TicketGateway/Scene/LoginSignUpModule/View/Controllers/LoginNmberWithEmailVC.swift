//
//  LoginNmberWithEmailVC.swift
//  TicketGateway
//
//  Created by Apple  on 25/04/23.
//

import UIKit
import SVProgressHUD

class LoginNmberWithEmailVC: UIViewController, NavigationBarViewDelegate {
   
    
    
    // MARK: - Outlets
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var imgCountryCode: UIImageView!
    @IBOutlet weak var lblCountryDialCode: UILabel!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var lblHeadingDescription: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var tblEmailList: UITableView!
    @IBOutlet weak var lblSelectEmail: UILabel!
    
    // MARK: - Variable
    let viewModel = LoginNmberWithEmailViewModel()
    let nameFormatter = PersonNameComponentsFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
}

// MARK: - Functions
extension LoginNmberWithEmailVC {
    private func setup() {
        [self.btnContinue].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        let imagePath = "CountryPicker.bundle/\(objAppShareData.DicToHoldDataOnSignUpModule?.strCountryCode ?? "").png"
        self.imgCountryCode.image = UIImage(named: imagePath)
        self.txtNumber.text = objAppShareData.DicToHoldDataOnSignUpModule?.strNumber ?? ""
        self.lblCountryDialCode.text = objAppShareData.DicToHoldDataOnSignUpModule?.strDialCountryCode ?? ""
        self.tblEmailList.dataSource = self
        self.tblEmailList.delegate = self
        self.tblEmailList.reloadData()
        self.btnContinue.setTitles(text: "Continue", font: .systemFont(ofSize: 14), tintColour: .black)
        self.btnContinue.addRightIcon(image: UIImage(named: "rightOnButton"))
        navigationView.lblTitle.text = "Login"
        navigationView.btnBack.isHidden = false
        navigationView.delegateBarAction = self
        self.viewModel.strSelectedEmail =  self.viewModel.arrMail[0].email ?? "test1@gmail.com"
    }
}

// MARK: - Actions
extension LoginNmberWithEmailVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
        default:
            break
        }
    }
    
    func btnContinueAction() {
        if Reachability.isConnectedToNetwork(){
            SVProgressHUD.show()
            viewModel.signInAPI { isTrue , messageShowToast in
                if isTrue == true {
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        objSceneDelegate.showTabBar()
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
        }
      
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}


extension LoginNmberWithEmailVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.arrMail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "LoginNmberWithEmailCell", for: indexPath) as? LoginNmberWithEmailCell)!
        let obj = self.viewModel.arrMail[indexPath.row]
        cell.lblName.text = obj.name
        cell.lblEmail.text = obj.email
        cell.lblShortName.text = funcpersonNameComponents(strValue: obj.name ?? "")
         
        if self.viewModel.strSelectedEmail == obj.email {
            cell.imageView?.image =  UIImage(named: "active")
        } else {
            cell.imageView?.image =  UIImage(named: "unActive")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.viewModel.arrMail[indexPath.row]
        self.viewModel.strSelectedEmail = obj.email ?? ""
        self.tblEmailList.reloadData()
        
    }
    
    func funcpersonNameComponents(strValue: String) -> String
    {
        var  fristName = ""
        var  lastNames = ""
        if let nameComps  = nameFormatter.personNameComponents(from: strValue) {
            if let  firstLetter = nameComps.givenName?.first {
                fristName = String(firstLetter)
            }
            
            if let lastName = nameComps.familyName?.first {
                lastNames = String(lastName)
            }
           
           
          
            return "\(fristName)\(lastNames)".uppercased()
        }
        return "\(fristName)\(lastNames)".uppercased()
    }
    
}
