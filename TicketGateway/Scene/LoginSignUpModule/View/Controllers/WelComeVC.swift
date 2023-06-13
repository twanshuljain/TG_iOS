//
//  WelComeVC.swift
//  TicketGateway
//
//  Created by Apple  on 13/04/23.
//

import UIKit

class WelComeVC: UIViewController {
    
    @IBOutlet var CvSlider: UICollectionView!
    var arrSliderImages = [UIImage(named: "welcome1"),UIImage(named: "welcome2"),UIImage(named: "welcome3")]
   // var arrImages = [UIImage(named: "wc1"),UIImage(named: "wc2"),UIImage(named: "wc3")]
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      
    }
}
extension WelComeVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSliderImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WelComeCell", for: indexPath) as! WelComeCell
        cell.imgPageControl.image = self.arrSliderImages[indexPath.row]
     //   cell.imgAdvertisement.image = self.arrImages[indexPath.row]
        cell.btnSkip.tag = indexPath.row
        cell.btnNext.tag = indexPath.row
        cell.btnSkip.addTarget(self, action: #selector(skipBtn), for: .touchUpInside)
        cell.btnNext.addTarget(self, action: #selector(nextBtn), for: .touchUpInside)
        if self.arrSliderImages.count-1 == indexPath.row{
            cell.btnNext.setTitle("Finish", for: .normal)
        } else {
            cell.btnNext.setTitle("Next", for: .normal)
        }
        if self.arrSliderImages.count-1 == indexPath.row || indexPath.row == 0 {
            cell.btnSkip.isHidden = true
        } else {
            cell.btnSkip.isHidden = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth : CGFloat = 0
        var cellHeight : CGFloat = 0
        cellWidth = CGFloat(self.view.frame.size.width)
        cellHeight = CGFloat(self.view.frame.size.height)
        return CGSize(width: cellWidth, height: cellHeight) }
    
   func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.currentIndex = indexPath.row }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentIndex = indexPath.row
        self.setPageController() }
}

extension WelComeVC {
    
    @objc func skipBtn(sender: UIButton){
       //...
        let view = self.createView(storyboard: .main, storyboardID: .WelcomeLoginSignupVC)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @objc func nextBtn(sender: UIButton){
       //...
        self.setPageController()
    }
    
    func setPageController(){
      //...
        
        if self.currentIndex == 0 {
             self.currentIndex = 1
            let rect = self.CvSlider.layoutAttributesForItem(at: IndexPath(row: 1, section: 0))?.frame.self
            self.CvSlider.frame = self.view.bounds
            self.CvSlider.scrollRectToVisible(rect!, animated: false)
             
         }else
         if self.currentIndex == 1 {
             self.currentIndex = 2
             let rect = self.CvSlider.layoutAttributesForItem(at: IndexPath(row: 2, section: 0))?.frame
             self.CvSlider.frame = self.view.bounds
             self.CvSlider.scrollRectToVisible(rect!, animated: false)
         }else if self.currentIndex == 2 {
             let view = self.createView(storyboard: .main, storyboardID: .WelcomeLoginSignupVC)
             self.navigationController?.pushViewController(view, animated: true)
         } else{
           //  self.currentIndex = self.currentIndex + 1
             
         }
    }
}
