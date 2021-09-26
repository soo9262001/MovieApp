//
//  UserService.swift
//  210925
//
//  Created by kms on 2021/09/25.
//

import Foundation
import Moya

enum UserService {
    case popular
    case movieInfo(id: Int)
}

extension UserService : TargetType {
    var baseURL: URL {
        guard let url = URL(string: R.URL.baseURL) else {
            fatalError("URL Error")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .popular:
            return "/popular"
        case .movieInfo(let id):
            return "\(id)"
        }
        
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .popular:
            return .requestParameters(parameters: ["api_key" : R.KEYS.api_key], encoding: URLEncoding.queryString)
        case .movieInfo(let id):
            return .requestParameters(parameters: ["api_key" : R.KEYS.api_key, "movie_id" : "id"], encoding: URLEncoding.queryString)
        }

    }
    
    var headers: [String : String]? {
        return ["Content-type" : "application/json"]
    }
    
    
}
