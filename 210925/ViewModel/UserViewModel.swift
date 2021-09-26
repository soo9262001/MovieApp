//
//  UserViewModel.swift
//  210925
//
//  Created by kms on 2021/09/25.
//

import Foundation
import ProgressHUD

class UserViewModel {
    fileprivate let service = UserDataService()
    var movies = [MovieModel]()
    var movieInfo : MovieModel?
    
    var message : String?
    
    func getMovies(completion: @escaping((UserViewState) -> Void)) {
        ProgressHUD.show()
        service.requestMovie { (movieList, error) in
            
            if let error = error {
                self.message = error.localizedDescription
                ProgressHUD.dismiss()
                completion(.failure)
                return
            }
            self.movies = movieList
            ProgressHUD.dismiss()
            completion(.success)
        }
    }
    
    func getMovieInfo(id: Int, completion: @escaping((UserViewState) -> Void)) {
        service.requestMovieInfo(id: id) {
            movie, error in
            if let error = error {
                self.message = error.localizedDescription
                completion(.failure)
                return
            }
            self.movieInfo = movie
            completion(.success)
        }
    }
}
