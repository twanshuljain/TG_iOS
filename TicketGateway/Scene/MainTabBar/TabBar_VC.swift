//
//  TabBar_VC.swift
//  TicketGateway
//
//  Created by Apple  on 17/04/23.
//

import UIKit

class TabBar_VC: UITabBarController {
    let yourImage = UIImage(named: "image")

    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.tabBarController?.addSubviewToLastTabItem("Irofile")
    }
    
    override func viewDidLayoutSubviews() { // add to any vc
        super.viewDidLayoutSubviews()
      //  self.TabBar_VC?.addSubviewToLastTabItem(yourImage!)
     //   self.tabBarController?.addSubviewToLastTabItem("Image")
     //   self.addSubviewToLastTabItem("Image")
    
    }

}





class TabBarManage_VC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
}
import UIKit

extension UITabBarController {
    
    
        func addSubviewToLastTabItem(_ imageName: String) {
               if let lastTabBarButton = self.tabBar.subviews.last, let tabItemImageView = lastTabBarButton.subviews.first {
                   if let accountTabBarItem = self.tabBar.items?.last {
                       accountTabBarItem.selectedImage = nil
                       accountTabBarItem.image = nil
                   }
                 
                   let imgView = UIImageView()
                   imgView.frame = tabItemImageView.frame
                   imgView.layer.cornerRadius = tabItemImageView.frame.height/2
                   imgView.layer.masksToBounds = true
                   imgView.contentMode = .scaleAspectFill
                   imgView.clipsToBounds = true
                   imgView.image = UIImage(named: imageName)
                   imgView.image?.resize(targetSize: CGSize(width: 33, height: 33)).withRenderingMode(.alwaysOriginal)
                   self.tabBar.subviews.last?.addSubview(imgView)
               }
           }
}
extension UIImage {

    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size:targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }

}
