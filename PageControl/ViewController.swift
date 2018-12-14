//
//  ViewController.swift
//  PageControl
//
//  Created by Vova Seuruk on 10/29/18.
//  Copyright © 2018 Sevruk Development. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private func createView(with color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private let pageControl1: PageControl = {
        let control = PageControl()
        control.numberOfPages = 4
        control.currentIndicatorDiameter = 15.0
        control.indicatorDiameter = 10.0
        control.spacing = 30.0
        control.currentIndicatorTintColor = .green
        control.indicatorTintColor = .darkGray
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let pageControl2: PageControl = {
        let control = PageControl()
        control.currentIndicatorTintColor = .white
        control.indicatorTintColor = .gray
        control.indicatorDiameter = 8.0
        control.numberOfPages = 3
        control.spacing = 15.0
        control.currentPage = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let pageControl3: PageControl = {
        let control = PageControl()
        control.numberOfPages = 5
        control.currentPage = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var view1: UIView = {
        return createView(with: .white)
    }()
    
    private lazy var view2: UIView = {
        return createView(with: .black)
    }()
    
    private lazy var view3: UIView = {
        return createView(with: .white)
    }()
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view1.addSubview(pageControl1)
        view2.addSubview(pageControl2)
        view3.addSubview(pageControl3)
        
        let views = [view1, view2, view3]
        views.forEach { view.addSubview($0) }
        
        var previousView: UIView = view
        let viewHeight: CGFloat = view.bounds.size.height / CGFloat(views.count)
        
        for view in views {
            let anchor: NSLayoutAnchor = (view == views.first) ? previousView.topAnchor : previousView.bottomAnchor
            
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: anchor),
                view.heightAnchor.constraint(equalToConstant: viewHeight),
                view.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
                ])
            
            previousView = view
        }
        
        NSLayoutConstraint.activate([
            pageControl1.centerXAnchor.constraint(equalTo: view1.centerXAnchor),
            pageControl1.centerYAnchor.constraint(equalTo: view1.centerYAnchor),
            pageControl2.centerXAnchor.constraint(equalTo: view2.centerXAnchor),
            pageControl2.centerYAnchor.constraint(equalTo: view2.centerYAnchor),
            pageControl3.centerXAnchor.constraint(equalTo: view3.centerXAnchor),
            pageControl3.centerYAnchor.constraint(equalTo: view3.centerYAnchor)
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
            for pageControl in [strongSelf.pageControl1, strongSelf.pageControl2, strongSelf.pageControl3] {
                let currentPage = pageControl.currentPage
                let numberOfPages = pageControl.numberOfPages - 1
                pageControl.currentPage = currentPage == numberOfPages ? 0 : currentPage + 1
            }
        })
    }

}

