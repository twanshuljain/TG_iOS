//
//  LoginViewModel.swift
//  TicketGateway
//
//  Created by Apple  on 14/04/23.
//

import Foundation
import UIKit

struct SignInRequestModel: Codable {
  let emailPhone: String?
  let password: String?
    
  enum CodingKeys: String, CodingKey {
    case emailPhone = "email_phone"
    case password = "password"
  }
}

struct SignInForNumberRequestModel: Codable {
  let cell_phone : String?
}

final class SignInViewModel {
  var email: String = ""
  var password: String = ""
  var number : String = ""
  var isForEmail : Bool = false
  var objUserModel: SignInAuthModel?
}
extension SignInViewModel{
  var validateUserInput:(errormessage: String, isValid: Bool){
      if isForEmail == true{
          if Validation.shared.textValidation(text: email, validationType: .email).0 {
              let errMsg = Validation.shared.textValidation(text: email, validationType: .email).1
              return (errMsg, false)
          }
          if Validation.shared.textValidation(text: password, validationType: .password).0 {
              let errMsg = Validation.shared.textValidation(text: password, validationType: .password).1
              return (errMsg, false)
          }
      } else {
          
          if Validation.shared.textValidation(text: number, validationType: .number).0 {
              let errMsg = Validation.shared.textValidation(text: number, validationType: .number).1
              return (errMsg, false)
          }
      }
      return ("", true)
  }
    func signInAPI(complition: @escaping (Bool,String) -> Void ) {
    let paramForEmail = SignInRequestModel(emailPhone: email, password: password)
    let paramForNumber = SignInForNumberRequestModel(cell_phone: number)
    
        if isForEmail == true {
            APIHandler.shared.executeRequestWith(apiName: .signInUser, parameters: paramForEmail, methodType: .POST) { (result: Result<ResponseModal<SignInAuthModel>, Error>) in
                switch result {
                case .success(let response):
                    if response.status_code == 200 {
                        DispatchQueue.main.async {
                            if self.isForEmail == true {
                                self.objUserModel = response.data
                              
                                UserDefaultManager.share.storeModelToUserDefault(userData: self.objUserModel, key: .userAuthData)
                                objAppShareData.userAuth = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userAuthData)
                            } else {
                                //Send to Otp screen,,,.
                            }
                        }
                        complition(true, response.message ?? "")
                    }else{
                        complition(false,response.message ?? "error message")
                    }
                case .failure(let error):
                    complition(false,"\(error)")
                }
            }
        }else {
            APIHandler.shared.executeRequestWith(apiName: .signInNumber, parameters: paramForNumber, methodType: .POST) { (result: Result<ResponseModal<SignInAuthModel>, Error>) in
                switch result {
                case .success(let response):
                    if response.status_code == 200 {
                        DispatchQueue.main.async {
                            self.objUserModel = response.data
                            print(self.objUserModel as Any)
                            self.objUserModel =  response.data
                          //  UserDefaultManager.share.storeModelToUserDefault(userData: self.objUserModel, key: .userAuthData)
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
}

