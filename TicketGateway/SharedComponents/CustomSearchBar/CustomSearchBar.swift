//
//  CustomSearchBar.swift
//  TicketGateway
//
//  Created by Dr.Mac on 26/04/23.
//

import UIKit

protocol CustomSearchMethodsDelegate {
   func leftButtonPressed(_ sender:UIButton)
   func RightButtonPressed(_ sender:UIButton)
}

class CustomSearchBar: UIView {
    var searchTextPlaceholder = "Search..."
    @IBOutlet weak var vwLocation: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var imgMap: UIImageView!
    @IBOutlet weak var lblAddress: UILabel!
    var delegate:CustomSearchMethodsDelegate?
    
    let nibName = "CustomSearchBar"
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
            txtSearch.attributedPlaceholder = NSAttributedString(string:searchTextPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.setColor(colorType: .PlaceHolder)])
        }
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
            
        }
        private func commonInit() {
          
            guard let view = loadViewFromNib() else { return }
            view.frame = self.bounds
           self.addSubview(view)
        }
        
        private func loadViewFromNib() -> UIView? {
            let nib = UINib(nibName: nibName, bundle: nil)
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
        }
    
    
    @IBAction func btnLeft(_ sender: UIButton) {
        self.delegate?.leftButtonPressed(sender )
    }

    @IBAction func btnRight(_ sender: UIButton) {
        self.delegate?.RightButtonPressed(sender )
    }
    
    
}
