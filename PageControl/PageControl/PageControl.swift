//
//  PageControl.swift
//
//  Created by Vova Seuruk on 10/29/18.
//  Copyright © 2018 Sevruk Development. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

open class PageControl: UIControl {
    
    /// The number of page indicators to display.
    open var numberOfPages: Int = 3 {
        didSet {
            removeViews()
            setupViews()
        }
    }
    
    /// The current page, displayed as a filled circle.
    open var currentPage: Int = 0 {
        didSet {
            UIView.animate(withDuration: 0.1) { [weak self] in
                guard let self = self, self.pageIndicators.count > self.currentPage else {
                    return
                }
                let newCenter = self.pageIndicators[self.currentPage].center
                self.currentPageIndicator.center = newCenter
            }
        }
    }
    
    /// The spacing between page indicators.
    open var spacing: CGFloat = 22.0 {
        didSet {
            NSLayoutConstraint.deactivate(horizontalConstraints)
            setupHorizontalConstraints()
        }
    }
    
    /// Diameter of page indicator.
    open var indicatorDiameter: CGFloat = 6.0 {
        didSet {
            NSLayoutConstraint.deactivate(sizeConstraints)
            pageIndicators.forEach { $0.layer.cornerRadius = indicatorDiameter / 2.0 }
            setupSizeConstraints()
        }
    }
    
    /// Diameter of current page indicator.
    open var currentIndicatorDiameter: CGFloat = 10.0 {
        didSet {
            NSLayoutConstraint.deactivate(sizeConstraints)
            currentPageIndicator.layer.cornerRadius = currentIndicatorDiameter / 2.0
            setupSizeConstraints()
        }
    }
    
    /// Color of page indicator.
    open var indicatorTintColor: UIColor = UIColor.white.withAlphaComponent(0.5) {
        didSet {
            pageIndicators.forEach { $0.backgroundColor = indicatorTintColor }
        }
    }
    
    /// Color of current page indicator.
    open var currentIndicatorTintColor: UIColor = .white {
        didSet {
            currentPageIndicator.backgroundColor = currentIndicatorTintColor
        }
    }
    
    /// Used to size control to fit a certian number of pages.
    /// - Parameter pagesNumber: A number of pages to calculate size for.
    /// - Returns: Minimum size required to fit pageControl with certian number of pages.
    open func size(forNumberOfPages numberOfPages: Int) -> CGSize {
        guard numberOfPages > 0 else { return .zero }
        let maxDiameter = max(indicatorDiameter, currentIndicatorDiameter)
        let diametersDifference = maxDiameter - min(indicatorDiameter, currentIndicatorDiameter)
        let width = CGFloat(numberOfPages - 1) * spacing + CGFloat(numberOfPages) * indicatorDiameter + diametersDifference
        return CGSize(width: width, height: maxDiameter)
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: private methods
    
    private lazy var currentPageIndicator: UIView = {
        return self.pageIndicator(with: self.currentIndicatorDiameter, backgroundColor: self.currentIndicatorTintColor, currentIndicator: true)
    }()
    
    private var pageIndicators: [UIView] = []
    
    private var sizeConstraints: [NSLayoutConstraint] = []
    private var horizontalConstraints: [NSLayoutConstraint] = []
    
    private func pageIndicator(with diameter: CGFloat, backgroundColor: UIColor?, currentIndicator: Bool = false) -> UIView {
        let frame = (currentIndicator) ? CGRect(x: 0, y: 0, width: diameter, height: diameter) : .zero
        let view = UIView(frame: frame)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = diameter / 2.0
        return view
    }
    
    private func removeViews() {
        for view in subviews {
            pageIndicators = []
            sizeConstraints = []
            horizontalConstraints = []
            NSLayoutConstraint.deactivate(view.constraints)
            view.removeFromSuperview()
        }
    }
    
    private func setupViews() {
        if numberOfPages != 0 {
            for _ in 0..<numberOfPages {
                pageIndicators.append(pageIndicator(with: indicatorDiameter, backgroundColor: indicatorTintColor))
            }
            
            (pageIndicators + [currentPageIndicator]).forEach { addSubview($0) }
            
            setupLayout()
            
            setCurrentIndicatorLocation()
        }
    }
    
    private func setCurrentIndicatorLocation() {
        if numberOfPages != 0 {
            let firstDot = pageIndicators[0]
            currentPageIndicator.center = firstDot.center
        }
    }
    
    // MARK: layout
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        guard pageIndicators.count > currentPage else { return }
        let updatedCenter = pageIndicators[currentPage].center
        
        if self.currentPageIndicator.center != updatedCenter {
            self.currentPageIndicator.center = updatedCenter
        }
    }
    
    private func setupLayout() {
        setupSizeConstraints()
        setupHorizontalConstraints()
        
        let verticalConstraints = pageIndicators.map {
            return $0.centerYAnchor.constraint(equalTo: centerYAnchor)
        }
        
        NSLayoutConstraint.activate(verticalConstraints)
    }
    
    private func setupHorizontalConstraints() {
        horizontalConstraints = horizontalConstraintsForIndicators()
        NSLayoutConstraint.activate(horizontalConstraints)
    }
    
    private func setupSizeConstraints () {
        sizeConstraints = sizeConstraintsForIndicators()
        NSLayoutConstraint.activate(sizeConstraints)
    }
    
    private func horizontalConstraintsForIndicators() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        let isNumberOfIndicatorsEven = Double(pageIndicators.count).truncatingRemainder(dividingBy: 2.0) == 0.0
        let initialElementIndex = isNumberOfIndicatorsEven ? (pageIndicators.count / 2) - 1 : (pageIndicators.count / 2)
        let initialElement = pageIndicators[initialElementIndex]
        
        for index in 0...pageIndicators.count - 1 {
            let view = pageIndicators[index]
            let constraint: NSLayoutConstraint
            
            if (index != initialElementIndex) {
                let constant = (spacing + indicatorDiameter) * CGFloat(index - initialElementIndex)
                constraint = view.centerXAnchor.constraint(equalTo: initialElement.centerXAnchor, constant: constant)
            } else {
                constraint = view.centerXAnchor.constraint(equalTo: centerXAnchor, constant: isNumberOfIndicatorsEven ? -((spacing + indicatorDiameter) / 2.0) : 0.0)
            }
            
            constraints.append(constraint)
        }
        
        return constraints
    }
    
    private func sizeConstraintsForIndicators() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        pageIndicators.forEach { view in
            constraints.append(contentsOf: constraintsWithHeightAndWidth(equalTo: indicatorDiameter, for: view))
        }
        
        return constraints
    }
    
    private func constraintsWithHeightAndWidth(equalTo constant: CGFloat, for view: UIView) -> [NSLayoutConstraint] {
        return [
            view.heightAnchor.constraint(equalToConstant: constant),
            view.widthAnchor.constraint(equalToConstant: constant)
        ]
    }
}

// MARK: - Self sizing
extension PageControl {
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        if numberOfPages == 0 {
            return .zero
        } else {
            let size = self.size(forNumberOfPages: numberOfPages)
            let width: CGFloat = min(superview?.bounds.width ?? .greatestFiniteMagnitude, size.width)
            return CGSize(width: width, height: size.height)
        }
    }
    
    open override var intrinsicContentSize: CGSize {
        if numberOfPages == 0 {
            return .zero
        } else {
            return size(forNumberOfPages: numberOfPages)
        }
    }
}
