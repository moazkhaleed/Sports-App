//
//  SportsService.swift
//  Sports-App
//
//  Created by Moaz Khaled on 21/05/2023.
//

import Alamofire
import Foundation

class NetworkService: NetworkServiceProtocol {
    
     func fetchData<T:Decodable>(url:String,complition : @escaping (T?,Error?) -> () ){
            
        print("fetchDataURL",url)
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            switch response.result{
                case .success(let data):
                  do{
                      let jsonData = try JSONDecoder().decode(T.self, from: data!)
                      complition(jsonData,nil)
                   //   debugPrint(jsonData)
                 } catch {
                    print(error.localizedDescription)
                 }
               case .failure(let error):
                 print(error.localizedDescription)
                  complition(nil,error)
                }
        }
        
    }
    
}

