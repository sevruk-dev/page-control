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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages = 4
        pageControl.spacing = 13.0
        pageControl.indicatorDiameter = 8.0
        pageControl.currentIndicatorDiameter = 12.0
        pageControl.currentIndicatorTintColor = UIColor.gray
        pageControl.indicatorTintColor = UIColor.blue
        pageControl.currentPage = 2
    }

}

