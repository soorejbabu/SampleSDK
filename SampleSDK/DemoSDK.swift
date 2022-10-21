//
//  DemoSDK.swift
//  SampleSDK
//
//  Created by Soorej Babu on 20/10/2022.
//

import Foundation
import Alamofire

public struct FirstDemoSDK
{
    public static func loginCheck(username:String, password:String) -> String
    {
        return "Your username is \(username) and password is \(password)."
    }
    
    public static func sumOfTwoNums(numberOne:Float, numberTwo:Float) -> Float
    {
        let num1 = numberOne
        let num2 = numberTwo
        return (num1 + num2)
    }
    
    public static func webserviceCall(url:String, completion:@escaping([String:Any])->Void)
    {
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response(completionHandler:
        {
            response -> Void in
            switch response.result
            {
                case .success(let data):
                    do
                    {
                        let responseJSON = try JSONSerialization.jsonObject(with: data!, options: []) as! [String : Any]
                        print("Response JSON:\n\(responseJSON)")
                        completion(responseJSON)
                    }
                    catch
                    {
                        let responseCode = response.response?.statusCode
                        let str = String(decoding: data!, as: UTF8.self)
                        print("Error Response Data:\n\(str)")
                        let errorDictResponse = ["ErrorResponseStatusCode":"\(String(describing: responseCode))"]
                        completion(errorDictResponse)
                    }
                    break
                case .failure(let error):
                    let errorDictResponse = ["ErrorResponse":"\(error)"]
                    completion(errorDictResponse)
                    break
            }
        })
    }
}
