//
//  LoginNmberWithEmailViewModel.swift
//  TicketGateway
//
//  Created by Apple  on 25/04/23.
//

import UIKit
import Foundation

struct NumberWithEmailRequestModel: Codable {
  let email: String?
  }

final class LoginNmberWithEmailViewModel {
    
    var countryCode: String = ""
    var Image: String = ""
    var number : String = ""
    var strSelectedEmail : String = ""
    var arrMail : [EmailListUser] = [EmailListUser]()
    var objUserModel: SignInAuthModel?
}

extension LoginNmberWithEmailViewModel{
    
    func signInAPI(complition: @escaping (Bool,String) -> Void ) {
        let paramForEmail = NumberWithEmailRequestModel(email: strSelectedEmail)
          APIHandler.shared.executeRequestWith(apiName: .signInUserByNumber_Email, parameters: paramForEmail, methodType: .POST) { (result: Result<ResponseModal<SignInAuthModel>, Error>) in
                switch result {
                case .success(let response):
                    if response.status_code == 200 {
                        DispatchQueue.main.async {
                           
                                self.objUserModel = response.data
                            
                            
                                UserDefaultManager.share.storeModelToUserDefault(userData: self.objUserModel, key: .userAuthData)
                           
                        }
                        complition(true, response.message ?? "")
                    }else{
                        complition(false,response.message ?? "error message")
                    }
                case .failure(let error):
                    complition(false,"\(error)")
                }
            }
        }
    }
