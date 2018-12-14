//
//  Created by Vova Seuruk on 12/13/18.
//  Copyright © 2018 Sevruk Development. All rights reserved.
//

import XCTest
@testable import PageControl

class PageControlInterfaceTest: XCTestCase {
    
    var pageControl1: PageControl!
    var pageControl2: PageControl!
    
    
    override func setUp() {
        super.setUp()
        pageControl1 = PageControl()
        pageControl2 = PageControl()
    }
    
    func testPageControlSizing() {
        pageControl1.numberOfPages = 0
        XCTAssertEqual(pageControl1.size(forNumberOfPages: pageControl1.numberOfPages), pageControl1.intrinsicContentSize)
        
        pageControl1.numberOfPages = 3
        XCTAssertEqual(pageControl1.size(forNumberOfPages: pageControl1.numberOfPages), pageControl1.intrinsicContentSize)
        
        pageControl1.numberOfPages = 18
        pageControl1.spacing = 18.0
        pageControl1.indicatorDiameter = 33.0
        XCTAssertEqual(pageControl1.size(forNumberOfPages: pageControl1.numberOfPages), pageControl1.intrinsicContentSize)
    }
    
    func testPageControlParitySizing() {
        let numberOfPages = 9
        pageControl1.numberOfPages = numberOfPages
        pageControl2.numberOfPages = numberOfPages
        
        pageControl1.indicatorDiameter = 9.0
        pageControl2.indicatorDiameter = 9.0
        
        pageControl1.spacing = 20.0
        pageControl2.spacing = 20.0
        
        XCTAssertEqual(pageControl1.intrinsicContentSize, pageControl2.intrinsicContentSize)
        
        pageControl1.currentIndicatorDiameter = 12.0
        pageControl2.currentIndicatorDiameter = 10.0
        
        XCTAssertNotEqual(pageControl1.intrinsicContentSize, pageControl2.intrinsicContentSize)
        XCTAssertNotEqual(pageControl1.size(forNumberOfPages: numberOfPages), pageControl2.size(forNumberOfPages: numberOfPages))
    }
    
    override func tearDown() {
        pageControl1 = nil
        pageControl2 = nil
        super.tearDown()
    }

}
