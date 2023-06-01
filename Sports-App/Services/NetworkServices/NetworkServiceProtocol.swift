//
//  APIServices.swift
//  Sports-App
//
//  Created by Moaz Khaled on 21/05/2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T:Decodable>(url:String,complition : @escaping (T?,Error?) -> () )
}
