//
//  RequestManager.swift
//  Depose
//
//  Created by ASHISH RANA on 26/02/18.
//  Copyright © 2018 addisinfotech. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
//https://codewithchris.com/alamofire/
class RequestManager{
    
    // 1
    
    static let shared = RequestManager()
    // 2
    private init() {
        
    }
    
    func printResponse(resonseData:Data){
        if AppConstant.ISTEST{
            let dataString = String(data: resonseData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            print("response\n\n \(dataString!)")
        }
    }
    func printJson(params:[String :Any]){
        
        if AppConstant.ISTEST{
            if let theJSONData = try?  JSONSerialization.data( withJSONObject: params, options: .prettyPrinted),
               let theJSONText = String(data: theJSONData,
                                        encoding: String.Encoding.ascii) {
                print("JSON string = \n\(theJSONText)")
            }
        }
    }
    
    /*func callingApi<Input: Encodable, Output: Decodable>(signUp : Input, type: Output.Type){
        /* let headers: HTTPHeaders = [
         "Authkey": Secrets.AuthKey
         ]*/
        AF.request(url, method: .post,
                   parameters: signUp,
                   encoder: JSONParameterEncoder.default,
                   headers: headers).responseDecodable(of: Output.self, decoder: JSONDecoder()) { response in
            switch response.result {
            case .success(let result): print(result)
            case .failure(let error): print(error)
            }
        }
    }*/
    
    

    func doPost<Output: Decodable>(strURL:String, parameter: Parameters, headers: HTTPHeaders, completion: @escaping (_ response:Output.Type?, _ error:Error?)->()){
        
        let url:URL = URL(string:strURL)!
        print("URL ======== \(url)")
        print("Parameter ======== \(parameter)")
        print("Header ======== \(headers)")
        
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: Output.self, decoder: JSONDecoder()) {
            response in
            switch (response.result) {
            case .success(let result):
                  //  self.printJson(params: response.value as! [String : Any])
                    completion( result as? Output.Type , nil)
                break
            case .failure(let error):
                if let desc = response.error?.localizedDescription {
                    print(desc)
                    completion(nil,error)
                }
            }
        }
    }
    
    func doPost(strURL:String, parameter: Parameters, headers: HTTPHeaders, completion: @escaping (_ dict:[String: AnyObject]?, _ error:Error?)->()){
        
        let url:URL = URL(string:strURL)!
        print("URL ======== \(url)")
        print("Parameter ======== \(parameter)")
        print("Header ======== \(headers)")
        
       
        
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            switch (response.result) {
            case .success:
                
                
                    self.printJson(params: response.value as! [String : Any])
                    completion( (response.value as! [String : AnyObject]) ,nil)
                
                break
            case .failure:
                if let desc = response.error?.localizedDescription {
                    print(desc)
                    completion([String: AnyObject](),response.error)
                }
            }
        }
    }
    
    
    
    func doGet(strURL:String, headers: HTTPHeaders, completion: @escaping (_ dict:[String: AnyObject]?, _ error:Error?)->()){
        
        let url:URL = URL(string:strURL)!
         print("======== \(url)")
        print(headers)
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON {
            response in
            
            switch (response.result) {
            case .success:
                self.printJson(params: response.value as! [String : Any])
                completion( (response.value as! [String : AnyObject]) ,nil)
                break
            case .failure:
                if let desc = response.error?.localizedDescription {
                    print(desc)
                    completion([String: AnyObject](),response.error)
                }
                
            }
        }
    }
    
    func doLogin(strURL:String, headers: HTTPHeaders, completion: @escaping (_ dict:[String: AnyObject]?, _ error:Error?)->()){
        
        let url:URL = URL(string:strURL)!
         print("======== \(url)")
        print(headers)
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON {
            response in
            
            switch (response.result) {
            case .success:
                self.printJson(params: response.value as! [String : Any])
                
                if response.response?.statusCode == 401 {
                    completion( (response.value as! [String : AnyObject]) ,nil)
                }
                else{
                   completion( (response.value as! [String : AnyObject]) ,nil)
                }
               
                break
            case .failure:
                if let desc = response.error?.localizedDescription {
                    print(desc)
                    completion([String: AnyObject](),response.error)
                }
                
            }
        }
    }
}



extension String {
    
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
}
