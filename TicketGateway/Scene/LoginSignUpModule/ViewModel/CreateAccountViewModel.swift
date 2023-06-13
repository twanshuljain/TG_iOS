//
//  CreateAccountViewModel.swift
//  TicketGateway
//
//  Created by Apple  on 17/04/23.
//

import UIKit
import Foundation

struct CreateAccountRequestModel: Codable {
  let fullName: String
  let mobileNumber: String
  let emailAddress: String
  let password: String
  let confimePassword: String
  let role: String
  let isVerify: Bool
  enum CodingKeys: String, CodingKey {
    case fullName = "full_name"
    case emailAddress = "email"
    case mobileNumber = "cell_phone"
    case password = "password"
    case confimePassword = "confirm_password"
    case role = "role"
    case isVerify = "is_verify"
  }
}

final class CreateAccountViewModel {
  var fullName : String = ""
  var mobileNumber : String = ""
  var emailAddress : String = ""
  var password : String = ""
  var confimePassword : String = ""
  var objUserModel : UserAccountModel?
}
extension CreateAccountViewModel {
  var ValidateUserInput: (errorMessage : String , isValid : Bool) {
    if Validation.shared.textValidation(text: fullName, validationType: .name).0 {
      let errMsg = Validation.shared.textValidation(text: fullName, validationType: .name).1
      return (errMsg, false)
    } else if Validation.shared.textValidation(text: mobileNumber, validationType: .number).0 {
      let errMsg = Validation.shared.textValidation(text: mobileNumber, validationType: .number).1
      return (errMsg, false)
    } else if Validation.shared.textValidation(text: emailAddress, validationType: .email).0 {
      let errMsg = Validation.shared.textValidation(text: emailAddress, validationType: .email).1
      return (errMsg, false)
//    } else if Validation.shared.textValidation(text: password, validationType: .password).0 {
//      let errMsg = Validation.shared.textValidation(text: password, validationType: .password).1
//      return (errMsg, false)
//    } else if Validation.shared.textValidation(text: confimePassword, validationType: .confirmPassword).0 {
//      let errMsg = Validation.shared.textValidation(text: confimePassword, validationType: .confirmPassword).1
//      return (errMsg, false)
//    } else if Validation.shared.textComparisonValidation(firstText: password, secondText: confimePassword, validationType: .password).0 {
//      let errMsg = Validation.shared.textComparisonValidation(firstText: password, secondText: confimePassword, validationType: .password).1
//      return (errMsg, false)
    }
    return("", true)
  }
  func createAccountAPI(complition: @escaping (Bool, String) -> Void) {
    let param = CreateAccountRequestModel(fullName: fullName, mobileNumber: mobileNumber, emailAddress: emailAddress, password: password, confimePassword: confimePassword, role: "user", isVerify: true)
    APIHandler.shared.executeRequestWith(apiName: .registerUser, parameters: param, methodType: .POST) { (result: Result<ResponseModal<UserAccountModel>, Error>) in
      switch result {
      case .success(let response):
        if response.status_code == 200 {
            DispatchQueue.main.async {
                self.objUserModel =  response.data
                UserDefaultManager.share.storeModelToUserDefault(userData: self.objUserModel, key: .userAuthData)
            }
            complition(true, response.message ?? "")
        }else{
            complition(false, response.message ?? "Error message")
        }
      case .failure(let error):
        complition(false, "\(error)")
      }
    }
  }
}



