//
//  ViewController.swift
//  PageControl
//
//  Created by Vova Seuruk on 10/29/18.
//  Copyright © 2018 insider.io. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pageControl: PageControl!
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = 5
        pageControl.currentPage = 2
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
            let currentPage = strongSelf.pageControl.currentPage
            let numberOfPages = strongSelf.pageControl.numberOfPages - 1
            strongSelf.pageControl.currentPage = currentPage == numberOfPages ? 0 : currentPage + 1
        })
    }

}

