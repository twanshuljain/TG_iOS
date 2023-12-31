//
//  ContactOrganiserVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 01/06/23.
//

import UIKit

class ContactOrganiserVC: UIViewController {
    
    
    var selectedReason: String?
    var reasonList = ["Choose one", "Question about the event", "Question about my ticket"]
    
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    
    @IBOutlet weak var lblSunburnReload: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var lblEmailAddress: UILabel!
    @IBOutlet weak var txtEmailAddress: UITextField!
    
    @IBOutlet weak var lblReason: UILabel!
    @IBOutlet weak var btnDropDown: UIButton!
    @IBOutlet weak var txtReason: UITextField!
    
   @IBOutlet weak var lblMessage: UILabel!
   @IBOutlet weak var txtMessage: UITextField!
    
    
    @IBOutlet weak var btnSendMessage: CustomButtonGradiant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationView()
        self.setFont()
        self.createPickerView()
        self.dismissPickerView()

    }
    
    func setNavigationView() {
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.imgBack.image = UIImage(named: "x_ip")
        self.vwNavigationView.lblTitle.text = "Contact Organiser"
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
       
    }
    
    func setFont() {
        self.lblSunburnReload.font = UIFont.setFont(fontType: .medium, fontSize: .eighteen)
        self.lblSunburnReload.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        let lbls = [lblName, lblEmailAddress, lblReason, lblMessage]
        for lbl in lbls {
            lbl?.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
            lbl?.textColor = UIColor.setColor(colorType: .lblTextPara)
        }
       
        let txtflds = [txtName, txtEmailAddress, txtReason, txtMessage]
        for txtfld in txtflds {
            txtfld?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            txtfld?.textColor = UIColor.setColor(colorType: .Headinglbl)
        }
        
        self.btnSendMessage.addRightIcon(image: UIImage(named: "LeftArrow_ip"))
        self.btnSendMessage.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnSendMessage.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
    
        self.lblName.attributedText = getAttributedTextAction(attributedText: "*", firstString: "Name ", lastString: "", attributedFont: UIFont.setFont(fontType: .medium, fontSize: .twelve) , attributedColor: UIColor.red, isToUnderLineAttributeText: false)
        
        self.lblEmailAddress.attributedText = getAttributedTextAction(attributedText: "*", firstString: "Email Address ", lastString: "", attributedFont: UIFont.setFont(fontType: .medium, fontSize: .twelve) , attributedColor: UIColor.red, isToUnderLineAttributeText: false)
        
        self.lblReason.attributedText = getAttributedTextAction(attributedText: "*", firstString: "Reason ", lastString: "", attributedFont: UIFont.setFont(fontType: .medium, fontSize: .twelve) , attributedColor: UIColor.red, isToUnderLineAttributeText: false)
        [btnSendMessage].forEach{
            $0?.addTarget(self, action: #selector(btnSendAction(sender:)), for: .touchUpInside)
        }
      
    }
    
    func createPickerView() {
           let pickerView = UIPickerView()
        pickerView.backgroundColor = UIColor.setColor(colorType: .white)
           pickerView.delegate = self
        txtReason.inputView = pickerView
    }
    func dismissPickerView() {
     
        
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
//      let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.action))
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
        txtReason.inputAccessoryView = toolBar
    }
    @objc func action() {
          view.endEditing(true)
    }
   
}
//MARK: - UIPickerViewDelegate, UIPickerViewDataSource,  UITextFieldDelegate
extension ContactOrganiserVC: UIPickerViewDelegate, UIPickerViewDataSource,  UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return reasonList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return reasonList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedReason = reasonList[row]
        txtReason.text = selectedReason

    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = reasonList[row]
        pickerLabel?.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)

        return pickerLabel!
    }
    
    
    
   
    
}

extension ContactOrganiserVC {
    
    @objc func btnSendAction(sender:UIButton) {
        let view = self.createView(storyboard: .manageevent, storyboardID: .ManageSellTicketSuccessfully) as? ManageSellTicketSuccessfully
        view?.strTittle = "Change Orangniser"
        self.navigationController?.pushViewController(view!, animated: true)
    }
}










//MARK: -
extension ContactOrganiserVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: false)
    }
  
}
