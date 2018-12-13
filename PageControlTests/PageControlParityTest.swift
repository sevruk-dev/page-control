//
//  Created by Vova Seuruk on 12/13/18.
//  Copyright © 2018 Sevruk Development. All rights reserved.
//

import XCTest
@testable import PageControl

class PageControlParityTest: XCTestCase {
    
    var pageControl: PageControl!
    var uiPageControl: UIPageControl!
    

    override func setUp() {
        super.setUp()
        pageControl = PageControl()
        uiPageControl = UIPageControl()
        
        pageControl.numberOfPages = 30
        uiPageControl.numberOfPages = 30
        
        pageControl.currentPage = 3
        uiPageControl.currentPage = 3
    }

    func testPageControlDefaults() {
        XCTAssertEqual(pageControl.numberOfPages, uiPageControl.numberOfPages)
        XCTAssertEqual(pageControl.currentPage, uiPageControl.currentPage)
    }
    
    func testUIControlDefaults() {
        XCTAssertEqual(pageControl.isEnabled, uiPageControl.isEnabled)
        XCTAssertEqual(pageControl.isHighlighted, uiPageControl.isHighlighted)
        XCTAssertEqual(pageControl.isSelected, uiPageControl.isSelected)
        XCTAssertEqual(pageControl.contentVerticalAlignment, uiPageControl.contentVerticalAlignment)
        XCTAssertEqual(pageControl.contentHorizontalAlignment, uiPageControl.contentHorizontalAlignment)
        XCTAssertEqual(pageControl.state, uiPageControl.state)
        XCTAssertEqual(pageControl.isTracking, uiPageControl.isTracking)
    }
    
    func testUIViewDefaults() {
        // UI Direction
        XCTAssertEqual(UIPageControl.userInterfaceLayoutDirection(for: uiPageControl.semanticContentAttribute), PageControl.userInterfaceLayoutDirection(for: pageControl.semanticContentAttribute))
        XCTAssertEqual(uiPageControl.semanticContentAttribute, pageControl.semanticContentAttribute)
        
        // Event Related Behaviour
        XCTAssertEqual(pageControl.isUserInteractionEnabled, uiPageControl.isUserInteractionEnabled)
        XCTAssertEqual(pageControl.isMultipleTouchEnabled, uiPageControl.isMultipleTouchEnabled)
        XCTAssertEqual(pageControl.isExclusiveTouch, uiPageControl.isExclusiveTouch)
        
        // Visual Appearance
        XCTAssertEqual(pageControl.clipsToBounds, uiPageControl.clipsToBounds)
        XCTAssertEqual(pageControl.alpha, uiPageControl.alpha)
        XCTAssertEqual(pageControl.isOpaque, uiPageControl.isOpaque)
        XCTAssertEqual(pageControl.clearsContextBeforeDrawing, uiPageControl.clearsContextBeforeDrawing)
        XCTAssertEqual(pageControl.isHidden, uiPageControl.isHidden)
        XCTAssertEqual(pageControl.contentMode, uiPageControl.contentMode)
        XCTAssertEqual(pageControl.mask == nil, uiPageControl.mask == nil)
    }
    
    func testUIResponderDefaults() {
        XCTAssertEqual(pageControl.canBecomeFirstResponder, uiPageControl.canBecomeFirstResponder)
        XCTAssertEqual(pageControl.becomeFirstResponder(), uiPageControl.becomeFirstResponder())
    }
    
    override func tearDown() {
        pageControl = nil
        uiPageControl = nil
        super.tearDown()
    }

}
