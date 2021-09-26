//
//  UserDataService.swift
//  210925
//
//  Created by kms on 2021/09/25.
//

import Foundation
import Moya

class UserDataService {

    fileprivate let provider = MoyaProvider<UserService>()
    
    func requestMovie(completion: @escaping(([MovieModel], Error?) -> Void)) {
        provider.request(.popular) { result in
            switch result {
            case .success(let res):
//                print("+++++++++++++",res)
                do {
                    let decoder = JSONDecoder()
                    let movie = try decoder.decode(MovieDataStore.self, from: res.data)
                    
                    completion(movie.results,nil)
                   
                } catch let error {
                    completion([], error)
                  
                }
            case .failure(let error):
                completion([],error)
            }
        }
    }
    
    func requestMovieInfo(id: Int, completion: @escaping((MovieModel, Error?) -> Void)) {
        provider.request(.movieInfo(id: id)) { result in
            switch result {
            case .success(let res):
//                print("----------", res)
                do {
                    let decoder = JSONDecoder()
                    let movie = try decoder.decode(MovieModel.self, from: res.data)
                    completion(movie, nil)
                    
                } catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

