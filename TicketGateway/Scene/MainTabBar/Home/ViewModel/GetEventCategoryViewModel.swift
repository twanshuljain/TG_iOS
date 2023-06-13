//
//  GetEventCategoryViewModel.swift
//  TicketGateway
//
//  Created by Apple  on 05/06/23.
//

import UIKit



final class GetEventCategoryViewModel {
    
    var arrCategoryData : [GetEventCategoryModel] = [GetEventCategoryModel]()
    
}

extension GetEventCategoryViewModel {
    
    func GetEventCategoryApi(complition: @escaping (Bool,String) -> Void ) {
        
        APIHandler.shared.executeRequestWith(apiName: .GetEventCategoryList, parameters: EmptyModel?.none, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<[GetEventCategoryModel]>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    print("response....",response)
                    DispatchQueue.main.async {
                        self.arrCategoryData = response.data!
                        print(self.arrCategoryData)
                        complition(true, response.message ?? "")
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
    
    func newGetEventCategoryApi(completion: @escaping(Bool, String) -> Void) {
        APIHandler.shared.executeRequestWith(apiName: .GetEventCategoryList, parameters: EmptyModel?.none, methodType: .GET,authRequired: true) { (result: Result<ResponseModal<[GetEventCategoryModel]>, Error>) in
            switch result {
            case .success(let response):
                if response.status_code == 200 {
                    print("response....",response)
                    DispatchQueue.main.async {
                        self.arrCategoryData = response.data!
                        print(self.arrCategoryData)
                        completion(true, response.message ?? "")
                    }
                    completion(true, response.message ?? "")
                }else{
                    completion(false,response.message ?? "error message")
                }
            case .failure(let error):
                completion(false,"\(error)")
            }
        }
        
    }
    
}
