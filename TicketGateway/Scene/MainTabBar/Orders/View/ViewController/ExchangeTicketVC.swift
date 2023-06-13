//
//  ExchangeTicketVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 01/06/23.
//

import UIKit

class ExchangeTicketVC: UIViewController {

    @IBOutlet weak var tblExchangeTbleView: UITableView!
    
    @IBOutlet weak var btnExchange: CustomButtonGradiant!
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    let tblData = ["YoungGold", "VIP", "VIP", "Early Birds Advance"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        self.setFont()
        self.setNavigationView()

    }
    
    func setNavigationView() {
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.lblTitle.text = "Exchange For"
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.vwNavigationView.lblDiscripation.isHidden = false
        self.vwNavigationView.lblDiscripation.text = "#3246431341"
        self.vwNavigationView.lblDiscripation.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.vwNavigationView.lblDiscripation.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
    
    func setTableView() {
        tblExchangeTbleView.delegate = self
        tblExchangeTbleView.dataSource = self
        tblExchangeTbleView.register(UINib(nibName: "ExchangeTableViewCell", bundle: nil), forCellReuseIdentifier: "ExchangeTableViewCell")
    }
    
    func setFont() {
        btnExchange.addTarget(self, action: #selector(navigate(_:)), for: .touchUpInside)
        btnExchange.titleLabel?.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        btnExchange.titleLabel?.textColor = UIColor.setColor(colorType: .btnDarkBlue)
        btnExchange.addRightIcon(image: UIImage(named: "Change_ip"))
        
    }
     
    @objc func navigate(_ sender: UIButton) {
      //  self.showAlert(title: "Exchange ticket", message: "You need to pay CAD$9.90 to exchange your ticket. Do you want to continue?")
        
        let alert = UIAlertController(title: "Exchange ticket", message: "You need to pay CAD$9.90 to exchange your ticket. Do you want to continue?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
          print("Handle Ok logic here")
          }))

        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
          print("Handle Cancel Logic here")
            let vc = self.createView(storyboard: .order, storyboardID: .OrderSummaryVC)
            self.navigationController?.pushViewController(vc, animated: true)
          }))

        present(alert, animated: true, completion: nil)

    }
   
}





//MARK: -
extension ExchangeTicketVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tblData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExchangeTableViewCell", for: indexPath) as! ExchangeTableViewCell
        let data = tblData[indexPath.row]
        cell.lblYoungGold.text = data
        return cell
    }
    
    
}
//MARK: -
extension ExchangeTicketVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: false)
    }
  
}
