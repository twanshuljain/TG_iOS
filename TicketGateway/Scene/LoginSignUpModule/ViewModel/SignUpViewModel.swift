//
//  SignUpViewModel.swift
//  TicketGateway
//
//  Created by Apple  on 14/04/23.
//

import UIKit
struct SignUpRequestModel: Codable {
  var email: String
}
final class SignUpViewModel {
  var email: String = ""

}
extension SignUpViewModel {
  var validateUserInput: (errormessage: String, isValid: Bool) {
    if Validation.shared.textValidation(text: email, validationType: .email).0 {
      let errMsg = Validation.shared.textValidation(text: email, validationType: .email).1
      return (errMsg, false)
    }
    return ("", true)
  }
    
  func signUpEmailAPI(complition: @escaping (Bool, String) -> Void) {
    let param = SignUpRequestModel(email: email)
    APIHandler.shared.executeRequestWith(apiName: .signUpEmail, parameters: param, methodType: .POST) { (result: Result<ResponseModal<EmptyModel>, Error>) in
      switch result {
      case .success(let response):
        if response.status_code == 200 {
            complition(true, response.message ?? "")
        }else{
            complition(false, response.message ?? "Error Message")
        }
      case .failure(let error):
        complition(false, "\(error)")
      }
    }
  }
}









