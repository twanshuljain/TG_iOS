//
//  uiColour+Extensions.swift
//  TicketGateway
//
//  Created by Apple  on 28/04/23.
//

import UIKit

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    func isEqualTo(_ color: UIColor) -> Bool {
        var red1: CGFloat = 0, green1: CGFloat = 0, blue1: CGFloat = 0, alpha1: CGFloat = 0
        getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        var red2: CGFloat = 0, green2: CGFloat = 0, blue2: CGFloat = 0, alpha2: CGFloat = 0
        color.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        return red1 == red2 && green1 == green2 && blue1 == blue2 && alpha1 == alpha2
    }
    func colorFromCode(_ code: Int) -> UIColor {
        let red = CGFloat(((code & 0xFF0000) >> 16)) / 255
        let green = CGFloat(((code & 0xFF00) >> 8)) / 255
        let blue = CGFloat((code & 0xFF)) / 255
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    static var randomColor: UIColor {
        return UIColor(red: .random(in: 0...2), green: .random(in: 0...2), blue: .random(in: 0...2), alpha: 1.0)
    }
    // MARK: - Color Setups
    enum ColorPalette: String {
        case BorderLineColour = "BorderLineColour"
        case EndGradient = "EndGradient"
        case StartGradient = "StartGradient"
        case EnterTxtFiled = "EnterTxtFiled"
        case darkBlueBG = "DarkBlueBG"
        case Headinglbl = "Headinglbl"
        case quillLight = "QuillLight"
        case lightBlack = "lightBlack"
        case PlaceHolder = "PlaceHolder"
        case TGBlue = "TGBlue"
        case TGGrey = "TGGrey"
        case TGBlack = "TGBlack"
        case TGGreen = "TGGreen"
        case TGYellow = "TGYellow"
        case TGRed = "TGRed"
        case TiitleColourDarkBlue = "TiitleColourDarkBlue"
        case btnDarkBlue = "btnDarkBlue"
        case lblTextPara = "lblTextPara"
        case white = "white"
        case ExtraLightBlack = "ExtraLightBlack"
        case BorderColor = "BorderColor"
        case StartTextGradientColor = "StartTextGradientColor"
        case EndTextGradientColor = "EndTextGradientColor"
        
    }
    static func setColor(colorType: ColorPalette) -> UIColor {
        return UIColor(named: colorType.rawValue) ?? .blue
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
