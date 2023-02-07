//
//  WebViewController.swift
//  RxNews
//
//  Created by Sezgin Çiftci on 7.02.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    private var webView = WKWebView()
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func configureUI() {
        view.backgroundColor = .systemIndigo
        view.addSubviewsFromExt(webView)
        webView.anchor(top: view.layoutMarginsGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    private func loadWebView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let url = URL(string: self.urlString ?? "https://newsapi.org") else { return }
            self.webView.load(URLRequest(url: url))
        }
    }
}
