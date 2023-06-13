//
//  Secens.swift
//  TicketGateway
//
//  Created by Apple  on 13/04/23.
//
import Foundation
import UIKit

enum Storyboard: String {
    case main = "Main"
    case home = "Home"
    case sidemenu = "SideMenu"
    case costumes =  "Costume"
    case manageevent = "ManageEvents"
    case wallet = "Wallet"
    case order = "Order"
    case profile = "Profile"
    case manageventorder = "ManageEventOrder"
    case favourites = "Favorites"
}

enum StoryboardIdentifier: String {
    case LoginVC
    case SignUpVC
    case WelComeVC
    case WelcomeLoginSignupVC
    case ForgotPasswordVC
    case OtpNumberVC
    case OtpEmailVC
    case CreateAccountVC
    case VerifyPopupVC
    case LoginNmberWithEmailVC
    
    //Home
    case HomeVC
    case EventSearchHomeVC
    case EventSearchLocationVC
    case EventBookingTicketVC
    case EventBookingTicketOnApplyCouponVC
    case EventBookingTicketAddOnsVC
    case EventBookingOrderSummaryVC
    case EventBookingPaymentMethodVC
    case PaymentSuccessFullVC
    //SideMenuBar
    case AddAmountWalletVC
    case AmountAddedSuccessfullyVC
    case Organizers_Artists_ListVC
    case MyFollowersVC
    case VenueVC
    case EventDetailVC
    case MyWalletVC
    case MyRefundVC
    case CostumeViewController
    case DeviceSettingVC
    case Reward_LoyaltyPointsVC
    case NotificationVC
    case FAQVC
    //order
    case MyOrderViewController
    case SegmentCostumeVC
    case MyTicketVC
    case SeeFullTicketVC
    case TransferTicketVC
    case ContinueToTransferVC
    case ExchangeTicketVC
    case OrderSummaryVC
    case ChangeNameVC
    case ContactOrganiserVC
    case RequestRefundVC
    
    //ManageEvent
    //DashBoard
    case ManageEventVC
    case ManageEventDashboardVC
    case ManageEventTicketSoldVC
    case PromoCodeVC
    case ManageSellTicketSuccessfully
    case ManageSellTicketComplimentary
    case AddCardVC
    //sell
    case ManageSellAddBuyerVC
    case ManageSellBuyersInfoListVC
    //More
    case ManageEventMoreVC
    case ManageEventProfileVC
    case ManageEventEditProfileVC
    //order
    case ManageEventOrderDeatilVC
    case RefundOptionsVC
    case ReviewRefundVC
    //Favourites
    case FavouriteVC
  
}

extension UIViewController {
    func createView(storyboard: Storyboard, storyboardID: StoryboardIdentifier) -> UIViewController {
        let storyboard = UIStoryboard.init(name: storyboard.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: storyboardID.rawValue) as UIViewController
        return viewController
    }
}
