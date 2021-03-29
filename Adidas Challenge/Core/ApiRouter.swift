//
//  ApiRouter.swift
//  Adidas Challenge
//
//  Created by Ramitha Wirasinha on 3/28/21.
//  Reference: https://medium.com/@marioamgad9/swift-4-2-building-a-network-layer-using-alamofire-and-rxswift-e044b5636d55
//  Copyright © 2021 Ramitha Wirasinha. All rights reserved.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    //The endpoint name we'll call later
    case getProducts
    
    //MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try path.asURL()
        
        var urlRequest = URLRequest(url: url)
        
        //Http method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    //MARK: - HttpMethod
    //This returns the HttpMethod type. It's used to determine the type if several endpoints are peresent
    private var method: HTTPMethod {
        switch self {
        case .getProducts:
            return .get
        }
    }
    
    //MARK: - Path
    //The path is the part following the base url
    private var path: String {
        switch self {
        case .getProducts:
            return "http://192.168.0.136:3001/product"
        }
    }
    
    //MARK: - Parameters
    //This is the queries part, it's optional because an endpoint can be without parameters
    private var parameters: Parameters? {
        switch self {
        case .getProducts:
            //A dictionary of the key (From the constants file) and its value is returned
            return [:]
        }
    }
    
    struct Constants {
        
        //The parameters (Queries) that we're gonna use
        struct Parameters {
            static let userId = "userId"
        }
        
        //The header fields
        enum HttpHeaderField: String {
            case authentication = "Authorization"
            case contentType = "Content-Type"
            case acceptType = "Accept"
            case acceptEncoding = "Accept-Encoding"
        }
        
        //The content type (JSON)
        enum ContentType: String {
            case json = "application/json"
        }
    }
}

