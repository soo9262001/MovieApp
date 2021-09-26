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
    }

    fileprivate func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: R.CELL.tableViewCell, bundle: nil), forCellReuseIdentifier: R.CELL.mainCellId)
    }
    
    fileprivate func getMovieData() {
        movieViewModel.getMovies { [self] state in
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
        detailVC.id = movieViewModel.movies[index!.row].id
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.CELL.mainCellId, for: indexPath) as! MovieTableViewCell
        
        let movie = movieViewModel.movies[indexPath.row]
        
        cell.titleLabel.text = movie.title
        cell.dateLabel.text = "출시일 : \(movie.date!)"
//        cell.overviewLabel.text = movie.overview
        cell.imgView.kf.setImage(with: URL(string: R.URL.imgURL + "\(movie.img ?? "")"))
        cell.RatingView.rating = Double(movie.average! / 2)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: R.CELL.segueId, sender: nil)
    }
}
