//
//  RxNewsTableViewController.swift
//  RxNews
//
//  Created by Sezgin Çiftci on 5.02.2023.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class RxNewsTableViewController: UITableViewController {
    
    private let disposeBag = DisposeBag()
    private var articles = [Article]()
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .lightGray
        spinner.transform = CGAffineTransform(scaleX: 3, y: 3)
        spinner.hidesWhenStopped = true
        spinner.backgroundColor = .clear
        return spinner
    }()
    
    //MARK: - View Controller Life Cycle Methos
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureUI() {
        view.addSubviewsFromExt(spinner)
        spinner.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: (view.frame.size.height/2) - 150, paddingLeft: (view.frame.size.width/2) - 25, width: 50, height: 50)
    }
    
    //MARK: - Reload TableView with News Data
    private func loadNews() {
        spinner.startAnimating()
        guard let url = URL(string: ConstantsApi.api) else {
            print("Url might be wrong!")
            return
        }
        let resource = Resource<NewsModel>(url: url)
        
        URLRequest.load(resource: resource)
            .subscribe { [weak self] result in
                if let result = result {
                    self?.articles = result.articles
                }
            } onError: { _ in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.spinner.stopAnimating()
                }
                print("Could not operate this")
            } onCompleted: {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.spinner.stopAnimating()
                    self.tableView.reloadData()
                }
            } onDisposed: {
                print("disposed")
            }.disposed(by: disposeBag)
    }
    
    //MARK: - TableView Delegate Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ArticleCell.self), for: indexPath) as? ArticleCell
        guard let cell = cell else { return UITableViewCell()}
        cell.titleLabel.text = articles[indexPath.row].title
        cell.descriptionLabel.text = articles[indexPath.row].description ?? ""
        cell.newsImageView.kf.setImage(with: URL(string: articles[indexPath.row].urlToImage ?? ""))
        cell.addDateAuthor(articles[indexPath.row].publishedAt ?? "", articles[indexPath.row].author ?? "")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let webVC = WebViewController()
        webVC.urlString = articles[indexPath.row].url
        self.navigationController?.pushViewController(webVC, animated: true)
    }
}

