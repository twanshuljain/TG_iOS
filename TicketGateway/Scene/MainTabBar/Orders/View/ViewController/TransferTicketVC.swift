//
//  TransferTicketVC.swift
//  TicketGateway
//
//  Created by Dr.Mac on 31/05/23.
//

import UIKit

class ExpandableTicketCell {
    var isExpanded : Bool
    init(isExpanded: Bool) {
        self.isExpanded = isExpanded
        
    }
}

class TransferTicketVC: UIViewController {
    
    
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    @IBOutlet weak var tblTransferTicketTableView: UITableView!
    var arrData = [ExpandableTicketCell(isExpanded: false), ExpandableTicketCell(isExpanded: false), ExpandableTicketCell(isExpanded: false), ExpandableTicketCell(isExpanded: false)]
    let tblData = ["334566","565656", "56656456", "5645645" ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        self.setNavigationView()
        
    }
    
    func setNavigationView() {
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.lblTitle.text = "Transfer Tickets"
        self.vwNavigationView.lblTitle.font = UIFont.setFont(fontType: .medium, fontSize: .fourteen)
        self.vwNavigationView.lblTitle.textColor = UIColor.setColor(colorType: .TiitleColourDarkBlue)
        self.vwNavigationView.lblDiscripation.isHidden = false
        self.vwNavigationView.lblDiscripation.text = "#3246431341"
        self.vwNavigationView.lblDiscripation.font = UIFont.setFont(fontType: .regular, fontSize: .twelve)
        self.vwNavigationView.lblDiscripation.textColor = UIColor.setColor(colorType: .lblTextPara)
    }
    
    func setTableView() {
        self.tblTransferTicketTableView.separatorColor = .clear
        self.tblTransferTicketTableView.delegate = self
        self.tblTransferTicketTableView.dataSource = self
        self.tblTransferTicketTableView.register(UINib(nibName: "TransferTicketTableViewCell", bundle: nil), forCellReuseIdentifier: "TransferTicketTableViewCell")
        self.tblTransferTicketTableView.register(UINib(nibName: "TransferTicketHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "TransferTicketHeaderView")
    }
    
    @objc func buttonPressed(_ sender: UIButton){
        var obj = arrData[sender.tag]
        print(arrData[sender.tag])
        if obj.isExpanded == false
        {
            obj.isExpanded = true
        } else {
            obj.isExpanded = false
        }
        print("value",arrData)
        self.tblTransferTicketTableView.reloadData()
    }
    
    @objc func navigateButton(_ sender: UIButton) {
        let vc = createView(storyboard: .order, storyboardID: .ContinueToTransferVC)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


//MARK: -
extension TransferTicketVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int{
        return arrData.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrData[section].isExpanded == true{
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransferTicketTableViewCell", for: indexPath) as! TransferTicketTableViewCell
        let data = tblData[indexPath.row]
        cell.lblTicketIdValue.text = data
        cell.btnContinueToTransfer.addTarget(self, action: #selector(navigateButton(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerview = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TransferTicketHeaderView") as! TransferTicketHeaderView
        headerview.btnUp.tag = section
        headerview.btnUp.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        let obj = arrData[section]
        if obj.isExpanded == true {
            headerview.btnUp.setImage(UIImage(named: "circlechevronUp_ip"), for: .normal)
            headerview.headerBottomLine.isHidden = true
        }else {
            headerview.btnUp.setImage(UIImage(named: "circleChevron-down_ip"), for: .normal)
            headerview.headerBottomLine.isHidden = false
        }
        
        return headerview
    }
    
}

//MARK: -
extension TransferTicketVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: false)
    }
    
}
