//
//  VerifyPopupVC.swift
//  TicketGateway
//
//  Created by Apple  on 18/04/23.
//

import UIKit

class VerifyPopupVC: UIViewController {

    @IBOutlet weak var lblVerifyMsg: UILabel!
    @IBOutlet weak var btnGreat: UIButton!
    @IBOutlet weak var imgBackground: UIImageView!
    
    @IBOutlet weak var imgSuccess: UIImageView!
    
    @IBOutlet weak var lblTitleVerified: UILabel!
    
    var closerForBack : ((_ isTrue: Bool) -> Void)?
    var strMessage = ""
    var img = ""
    var strMsgForlbl = ""
    var strMsgBtn = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblVerifyMsg.text = strMessage
        self.imgBackground.applyBlurEffect()
        self.imgSuccess.image = UIImage(named: img)
        self.lblTitleVerified.text = strMsgForlbl
        self.btnGreat.titleLabel?.text = strMsgBtn
      // Do any additional setup after loading the view.
    }
    

   
     @IBAction func btnGreat(_ sender: Any) {
         DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
             print("the value here work:----")
             self.closerForBack!(true)
         }
         DispatchQueue.main.async {
             print("the value here ")
             self.dismiss(animated: true, completion: nil)
         }
     }
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
