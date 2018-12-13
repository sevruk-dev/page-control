//
//  ViewController.swift
//  PageControl
//
//  Created by Vova Seuruk on 10/29/18.
//  Copyright © 2018 Sevruk Development. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let pageControl1: PageControl = {
        let control = PageControl()
        control.numberOfPages = 5
        control.currentPage = 2
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let pageControl2: PageControl = {
        let control = PageControl()
        control.numberOfPages = 4
        control.currentIndicatorDiameter = 15.0
        control.indicatorDiameter = 10.0
        control.spacing = 20.0
        control.currentIndicatorTintColor = .green
        control.indicatorTintColor = .black
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [pageControl1, pageControl2].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            pageControl1.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50.0),
            pageControl1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl2.bottomAnchor.constraint(equalTo: pageControl1.topAnchor, constant: -100.0),
            pageControl2.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showDemo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    private func showDemo() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            guard let strongSelf = self else {
                return
            }
            for pageControl in [strongSelf.pageControl1, strongSelf.pageControl2] {
                let currentPage = pageControl.currentPage
                let numberOfPages = pageControl.numberOfPages - 1
                pageControl.currentPage = currentPage == numberOfPages ? 0 : currentPage + 1
            }
        })
    }

}

