//
//  SignUpVerifyViewModel.swift
//  TicketGateway
//
//  Created by Apple  on 19/04/23.
//

import Foundation
import UIKit
struct EmailVerifyRequestModel: Codable {
  let email: String
  let otp: String
}
final class EmailVerifyViewModel {
  var email: String = ""
  var otp: String = ""
  var objModel: ResponseModal<EmptyModel>?
}
extension EmailVerifyViewModel {
  var validateUserInput: (errormessage: String, isValid: Bool) {
    if Validation.shared.textValidation(text: email, validationType: .email).0 {
      let errMsg = Validation.shared.textValidation(text: email, validationType: .email).1
      return (errMsg, false)
    }
    return ("", true)
//    if Validation.shared.textValidation(text: otp, validationType: .otp).0 {
//      let errMsg = Validation.shared.textValidation(text: otp, validationType: .otp).1
//      return (errMsg, false)
//    }
//    return ("", true)
  }
  func signUpVerifyEmailAPI(complition: @escaping (Bool, String) -> Void) {
    let param = EmailVerifyRequestModel(email: email, otp: otp)
    APIHandler.shared.executeRequestWith(apiName: .verifyEmailOtp, parameters: param, methodType: .POST) { (result: Result<ResponseModal<EmptyModel>, Error>) in
        
      switch result {
      case .success(let response):
          print(response.message)
        if response.status_code == 200 {
            complition(true, response.message ?? "")
        }else{
            
            if response.message == ""{
                complition(true, response.message ?? "")
            } else {
                complition(false, response.message ?? "Error message")
            }
        }
      case .failure(let error):
          if "\(error)" == "Email already verified" {
              complition(true, "")
          }else {
              complition(false, "\(error)")
          }
      }
    }
  }
}



