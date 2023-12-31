//
//  ChangeNameVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 01/06/23.
//

import UIKit

class ChangeNameVC: UIViewController {

    
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    
    @IBOutlet weak var lblSelectTicket: UILabel!
    @IBOutlet weak var btnSelectTicket: UIButton!
    @IBOutlet weak var txtSelectTickte: UITextField!
    
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var txtFirstName: UITextField!
    
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var lblTicketNameChange: UILabel!
    
    
    @IBOutlet weak var btnSaveChanges: CustomButtonGradiant!
    @IBOutlet weak var btnCancel: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationView()
        self.setFont()

    }
    
    func setNavigationView() {
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.lblTitle.text = "Change name"
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
       
    }
    
    
    func setFont() {
        
        self.lblSelectTicket.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblSelectTicket.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.txtSelectTickte.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.txtSelectTickte.textColor = UIColor.setColor(colorType: .Headinglbl)
        
        
        self.lblFirstName.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblFirstName.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.txtFirstName.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.txtFirstName.textColor = UIColor.setColor(colorType: .Headinglbl)
        
        self.lblLastName.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblLastName.textColor = UIColor.setColor(colorType: .lblTextPara)
        self.txtLastName.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.txtLastName.textColor = UIColor.setColor(colorType: .Headinglbl)
        
        self.lblTicketNameChange.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblTicketNameChange.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.btnSaveChanges.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnSaveChanges.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        self.btnSaveChanges.addRightIcon(image: UIImage(named: "Save_ip"))
        
        self.btnCancel.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.btnCancel.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        
        self.lblFirstName.attributedText = getAttributedTextAction(attributedText: "*", firstString: "First Name ", lastString: "", attributedFont: UIFont.setFont(fontType: .medium, fontSize: .twelve) , attributedColor: UIColor.red, isToUnderLineAttributeText: false)
        
        self.lblLastName.attributedText = getAttributedTextAction(attributedText: "*", firstString: "First Name ", lastString: "", attributedFont: UIFont.setFont(fontType: .medium, fontSize: .twelve) , attributedColor: UIColor.red, isToUnderLineAttributeText: false)
        
    }
    @IBAction func btnSaveChange(_ sender: Any) {
        let view = self.createView(storyboard: .manageevent, storyboardID: .ManageSellTicketSuccessfully) as? ManageSellTicketSuccessfully
        view?.strTittle = "Ticket Name Changed"
        self.navigationController?.pushViewController(view!, animated: true)
    }
    
    
}
//MARK: - NavigationBarViewDelegate
extension ChangeNameVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: false)
    }
    
    
  
}
