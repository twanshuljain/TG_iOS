//
//  EventDetailBookingTicketVC.swift
//  TicketGateway
//
//  Created by Apple  on 11/05/23.
//

import UIKit

class EventBookingTicketVC: UIViewController {
    @IBOutlet weak var lblRefund: UILabel!
    
    @IBOutlet weak var btnCheckTermCondition: UIButton!
    @IBOutlet weak var lblAcceptedTermCon: UILabel!
    @IBOutlet weak var navigationView: NavigationBarView!
    @IBOutlet weak var tblEventTicketTypes: TicketTypeListTableView!
   @IBOutlet weak var btnContinue: CustomButtonGradiant!
    @IBOutlet weak var lblFewTIcketleft: UILabel!
    @IBOutlet weak var lblClickingonCOntinue: UILabel!
    var isCheckedTerm_COndition = false
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        // Do any additional setup after loading the view.
    }

}
extension EventBookingTicketVC {
    private func setup() {
        self.isCheckedTerm_COndition = false
        self.setUi()
        self.tblEventTicketTypes.configure()
        self.navigationView.delegateBarAction = self
          self.navigationView.lblTitle.text = "Sunburn reload NYE - toronto"
        self.navigationView.lblDiscripation.isHidden = false
        self.navigationView.lblDiscripation.text = "Saturday, March 18 • 6:00 AM"
          self.navigationView.btnBack.isHidden = false
        self.navigationView.vwBorder.isHidden = false
          self.navigationView.delegateBarAction = self
        self.tblEventTicketTypes.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.btnCheckTermCondition.setImage(UIImage(named: "unactiveTerm"), for: .normal)
        self.tblHeight.constant = self.tblEventTicketTypes.contentSize.height
        [self.btnContinue,self.btnCheckTermCondition].forEach {
            $0?.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
     }
    func setUi(){
        self.lblAcceptedTermCon.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblFewTIcketleft.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
        self.lblFewTIcketleft.textColor = UIColor.setColor(colorType: .TGBlack)
        self.lblRefund.font = UIFont.setFont(fontType: .regular, fontSize: .sixteen)
        self.lblRefund.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.lblClickingonCOntinue.font = UIFont.setFont(fontType: .regular, fontSize: .fifteen)
     
        self.btnContinue.addRightIcon(image: UIImage(named: "rightOnButton"))
        btnContinue.setTitles(text: "Continue", font: UIFont.boldSystemFont(ofSize: 17), tintColour: .black)
        
     }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.tblHeight.constant = tblEventTicketTypes.contentSize.height
        
   }
}
extension EventBookingTicketVC {
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
        case  btnCheckTermCondition :
            self.btnCheckTermConditionAction()
        default:
            break
        }
    }
    
    func btnCheckTermConditionAction(){
        if isCheckedTerm_COndition == false
        {
            isCheckedTerm_COndition = true
            self.btnCheckTermCondition.setImage(UIImage(named: "activeTerm"), for: .normal)
        }
        else {
            isCheckedTerm_COndition = false
            self.btnCheckTermCondition.setImage(UIImage(named: "unactiveTerm"), for: .normal)
        }
        
    }
    
   func btnContinueAction() {
       let view = self.createView(storyboard: .home, storyboardID: .EventBookingTicketOnApplyCouponVC) as? EventBookingTicketOnApplyCouponVC
   self.navigationController?.pushViewController(view!, animated: true)
    }
}

// MARK: - TextField Delegate


extension EventBookingTicketVC : NavigationBarViewDelegate {
    func navigationBackAction() {
    self.navigationController?.popViewController(animated: true)
  }
}

