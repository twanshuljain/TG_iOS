//
//  OrderSummaryVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 01/06/23.
//

import UIKit

class OrderSummaryVC: UIViewController {

    @IBOutlet weak var vwNavigationView: NavigationBarView!
    
    @IBOutlet weak var lblOrderSummary: UILabel!
    @IBOutlet weak var lblTicketDetails: UILabel!
    @IBOutlet weak var lblVIPTickets: UILabel!
    
    @IBOutlet weak var lblOldTicketPrice: UILabel!
    @IBOutlet weak var lblOldTicketPriceValue: UILabel!
    @IBOutlet weak var vwOldTickeDottedLine: UIView!
    
    @IBOutlet weak var lblNewTicktePrice: UILabel!
    @IBOutlet weak var lblNewTicketPriceValue: UILabel!
    
    @IBOutlet weak var lblTaxesFees: UILabel!
    
   @IBOutlet weak var lblServiceCharge: UILabel!
   @IBOutlet weak var lblServiceChargeValue: UILabel!
    
    @IBOutlet weak var vwTotalDashedLine: UIView!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblTotalAmountValue: UILabel!
    
    @IBOutlet weak var lblRefundPolicy: UILabel!
    @IBOutlet weak var lblRefundDiscription: UILabel!
    
    @IBOutlet weak var btnContinue: CustomButtonGradiant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setFont()
        self.setNavigationView()
        self.setUI()

    }
    
    func setNavigationView() {
        self.vwNavigationView.imgBack.isHidden = true
        self.vwNavigationView.btnRight.isHidden = false
        self.vwNavigationView.btnRight.setImage(UIImage(named: "x_ip"), for: .normal)
        self.vwNavigationView.btnRight.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }
    
  
    func setFont() {
        self.lblOrderSummary.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.lblOrderSummary.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.lblTicketDetails.font = UIFont.setFont(fontType: .medium, fontSize: .sixteen)
        self.lblTicketDetails.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        let lbls = [lblVIPTickets, lblOldTicketPrice, lblOldTicketPriceValue, lblNewTicktePrice, lblNewTicketPriceValue, lblServiceCharge, lblServiceChargeValue]
        for lbl in lbls {
            lbl?.font = UIFont.setFont(fontType: .regular, fontSize: .fourteen)
            lbl?.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        }
        
        self.lblTaxesFees.font = UIFont.setFont(fontType: .medium, fontSize: .twelve)
        self.lblTaxesFees.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.lblTotalAmount.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
        self.lblTotalAmount.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
      
        self.lblTotalAmountValue.font = UIFont.setFont(fontType: .semiBold, fontSize: .fourteen)
        self.lblTotalAmountValue.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        
        self.lblRefundPolicy.font = UIFont.setFont(fontType: .semiBold, fontSize: .twelve)
        self.lblRefundPolicy.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.lblRefundDiscription.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.lblRefundDiscription.textColor = UIColor.setColor(colorType: .lblTextPara)
        
        self.vwOldTickeDottedLine.createDottedLine(width: 1, color: UIColor.setColor(colorType: .BorderLineColour).cgColor, dashPattern: [3,5])
        
        self.vwTotalDashedLine.createDottedLine(width: 1, color: UIColor.setColor(colorType: .BorderLineColour).cgColor, dashPattern: [3,5])
        
        self.btnContinue.setTitles(text: "Continue CA$9.90", font: UIFont.setFont(fontType: .medium, fontSize: .fourteen), tintColour: UIColor.setColor(colorType: .btnDarkBlue))
        self.btnContinue.addRightIcon(image: UIImage(named: "LeftArrow_ip"))
       
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
  

}
//MARK: -
extension OrderSummaryVC {
    func setUI() {
        self.btnContinue.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        
    }
    
    @objc func buttonPressed(sender: UIButton) {
        switch sender {
        case btnContinue:
            self.btnContinueAction()
        
        default:
            break
        }
        
    }
    
    func btnContinueAction() {
        let vc = self.createView(storyboard: .home, storyboardID: .EventBookingPaymentMethodVC)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
}
