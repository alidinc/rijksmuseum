//
//  ArtObjectDetailViewController.swift
//  rijksmuseum
//
//  Created by Ali Dinç on 05/08/2021.
//

import UIKit
import WebKit

class ArtObjectDetailViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.contentMode = .scaleAspectFit
        webView.navigationDelegate = self
        view = webView
    }
    
    // MARK: - Properties
    var artObject: ArtObject?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        guard let artObject = artObject else { return }
        loadWebView(artObject: artObject)
    }
    
    func loadWebView(artObject: ArtObject) {
        guard let url = URL(string: artObject.links.web) else { return }
        print(url)
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}

extension ArtObjectDetailViewController {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}
