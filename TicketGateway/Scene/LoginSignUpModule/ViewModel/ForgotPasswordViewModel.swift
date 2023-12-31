//
//  ForgotPasswordViewModel.swift
//  TicketGateway
//
//  Created by Apple  on 14/04/23.
//

import UIKit

struct ForgotPasswordRequestModel: Codable {
    let email: String
}

final class ForgotPasswordViewModel {
        var email: String = ""
        var objModel: ForgotPasswordModel?
}

extension ForgotPasswordViewModel {
    var validateUserInput: (errormessage: String, isValid: Bool) {
        if Validation.shared.textValidation(text: email, validationType: .email).0 {
            let errMsg = Validation.shared.textValidation(text: email, validationType: .email).1
            return (errMsg, false)
        }
        return ("", true)
    }
    
    func forgotPasswordAPI(complition: @escaping (Bool, String) -> Void) {
        let param = ForgotPasswordRequestModel(email: email)
        APIHandler.shared.executeRequestWith(apiName: .forgotPassword, parameters: param, methodType: .POST) { (result: Result<ResponseModal<ForgotPasswordModel>, Error>) in
          switch result {
          case .success(let response):
            if response.status_code == 200 {
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
