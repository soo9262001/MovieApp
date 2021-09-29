//
//  ViewController.swift
//  210925
//
//  Created by kms on 2021/09/25.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let movieViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMovieData()
        nowMovieData()
        upMovieData()
    }

    fileprivate func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: R.CELL.tableViewCell, bundle: nil), forCellReuseIdentifier: R.CELL.mainCellId)
    }
    
    fileprivate func getMovieData() {
        movieViewModel.getPopularMovies { [self] state in
            switch state {
            case .success:
                self.handleSuccessFetchUsers()
            case .failure:
                print(movieViewModel.message as Any)
                break
            }
        }
    }
    
    fileprivate func nowMovieData() {
        movieViewModel.getNowMovies { [self] state in
            switch state {
            case .success:
                self.handleSuccessFetchUsers()
            case .failure:
                print(movieViewModel.message as Any)
                break
            }
        }
    }
    
    fileprivate func upMovieData() {
        movieViewModel.getUpMovies { [self] state in
            switch state {
            case .success:
                self.handleSuccessFetchUsers()
            case .failure:
                print(movieViewModel.message as Any)
                break
            }
        }
    }
    
    fileprivate func handleSuccessFetchUsers() {
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = self.tableView.indexPathForSelectedRow
        let detailVC = segue.destination as! DetailMovieViewController
        if index?.section == 0 {
            detailVC.id = movieViewModel.popularMovies[index!.row].id
        }else if index?.section == 1 {
            detailVC.id = movieViewModel.nowMovies[index!.row].id
        }else {
            detailVC.id = movieViewModel.upMovies[index!.row].id
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return movieViewModel.popularMovies.count
        }else if section == 1 {
            return movieViewModel.nowMovies.count
        }else {
            return movieViewModel.upMovies.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.CELL.mainCellId, for: indexPath) as! MovieTableViewCell
            
            let movie = movieViewModel.popularMovies[indexPath.row]
            
            cell.titleLabel.text = movie.title
            cell.dateLabel.text = "출시일 : \(movie.date!)"
    //        cell.overviewLabel.text = movie.overview
            cell.imgView.kf.setImage(with: URL(string: R.URL.imgURL + "\(movie.img ?? "")"))
            cell.RatingView.rating = Double(movie.average! / 2)
            
            return cell

        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.CELL.mainCellId, for: indexPath) as! MovieTableViewCell
            
            let movie = movieViewModel.nowMovies[indexPath.row]
            
            cell.titleLabel.text = movie.title
            cell.dateLabel.text = "출시일 : \(movie.date!)"
    //        cell.overviewLabel.text = movie.overview
            cell.imgView.kf.setImage(with: URL(string: R.URL.imgURL + "\(movie.img ?? "")"))
            cell.RatingView.rating = Double(movie.average! / 2)
            
            return cell

        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.CELL.mainCellId, for: indexPath) as! MovieTableViewCell
            
            let movie = movieViewModel.upMovies[indexPath.row]
            
            cell.titleLabel.text = movie.title
            cell.dateLabel.text = "출시일 : \(movie.date!)"
    //        cell.overviewLabel.text = movie.overview
            cell.imgView.kf.setImage(with: URL(string: R.URL.imgURL + "\(movie.img ?? "")"))
            cell.RatingView.rating = Double(movie.average! / 2)
            
            return cell

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "인기영화"
        }else if section == 1 {
            return "상영영화"
        }else {
            return "개봉영화"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: R.CELL.segueId, sender: nil)
    }
}
