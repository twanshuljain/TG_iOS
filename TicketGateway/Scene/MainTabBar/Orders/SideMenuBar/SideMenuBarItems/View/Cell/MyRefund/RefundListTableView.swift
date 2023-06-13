//
//  RefundListTableView.swift
//  TicketGateway
//
//  Created by Apple  on 29/05/23.
//

import UIKit

class RefundListTableView: UITableView {
    
    var tableDidSelectAtIndex: ((Int) -> Void)?
    var selectedDevice = ""
    var isFromDeselected = false
    var isFrom = ""
    
    var arrData = [ExpandableNames(isExpanded: false, names: ["ram","sham","mahima"]),
                   ExpandableNames(isExpanded: false, names: ["ram","sham","mahima"]),
                   ExpandableNames(isExpanded: false, names: ["ram","sham","mahima"]),
                   ExpandableNames(isExpanded: false, names: ["ram","sham","mahima"]),
    
    ]
    
    func configure() {
        self.register(UINib(nibName: "TransactionsListCell", bundle: nil), forCellReuseIdentifier: "TransactionsListCell")
        self.register(UINib(nibName: "MyRefundTransactionCell", bundle: nil), forCellReuseIdentifier: "MyRefundTransactionCell")
        self.delegate = self
        self.dataSource = self
    }
}

// MARK: - TableView Delegate

extension RefundListTableView : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int{
        
            return 3 // number of section array count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            if arrData[section].isExpanded == true{
                return 1
            } else {
                return 0
            }
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRefundTransactionCell") as! MyRefundTransactionCell
         return cell
    }
    
    //header for the category of allservices.
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCell(withIdentifier: "TransactionsListCell") as! TransactionsListCell
      let obj  = arrData[section]
        print(section)
        if obj.isExpanded == true {
            headerView.vwBorder.isHidden = true
            headerView.btnOpen.setImage(UIImage(named: "chevron-down 1"), for: .normal)
        } else  {
            headerView.vwBorder.isHidden = false
            headerView.btnOpen.setImage(UIImage(named: "chevron-down"), for: .normal)
        }
        if isFrom == "MyWallet" {
            headerView.lblStatus.isHidden = true
            headerView.lblAmount.isHidden = false
            headerView.vwCreditDebit.isHidden = false
          
        } else {
            headerView.lblStatus.isHidden = false
            headerView.lblAmount.isHidden = true
            headerView.vwCreditDebit.isHidden = true
        }
        headerView.btnOpen.tag = section
        headerView.btnOpen.addTarget(self, action: #selector(nextBtn(sender:)), for: .touchUpInside)
       
       return headerView
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
      }
    
   
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     
    }
    
    @objc func nextBtn(sender: UIButton){
        var  obj = arrData[sender.tag]
        print(arrData[sender.tag])
        if obj.isExpanded == false
        {
            obj.isExpanded = true
        } else {
            obj.isExpanded = false
        }
        print("value",arrData)
        self.reloadData()
    }
    
}

