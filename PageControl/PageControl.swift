//
//  PageControl.swift
//  PageControl
//
//  Created by Vova Seuruk on 10/29/18.
//  Copyright © 2018 insider.io. All rights reserved.
//

import UIKit

open class PageControl: UIControl {
    
    open var numberOfPages: Int = 3 {
        didSet {
            removeViews()
            setupViews()
        }
    }
    
    open var spacing: CGFloat = 22.0 {
        didSet {
            //TODO: refactor to make it more efficient
            removeViews()
            setupViews()
        }
    }
    
    open var indicatorDiameter: CGFloat = 6.0 {
        didSet {
            NSLayoutConstraint.deactivate(sizeConstraints)
            pageIndicators.forEach { $0.layer.cornerRadius = indicatorDiameter / 2.0 }
            setupSizeConstraints()
        }
    }
    
    open var currentIndicatorDiameter: CGFloat = 10.0 {
        didSet {
            NSLayoutConstraint.deactivate(sizeConstraints)
            currentPageIndicator.layer.cornerRadius = currentIndicatorDiameter / 2.0
            setupSizeConstraints()
        }
    }
    
    open var indicatorTintColor: UIColor = UIColor(red: 216.0/255.0, green: 216.0/255.0, blue: 216/255.0, alpha: 1.0) {
        didSet {
            pageIndicators.forEach { $0.backgroundColor = indicatorTintColor }
        }
    }
    
    open var currentIndicatorTintColor: UIColor = UIColor(red: 255.0/255.0, green: 52.0/255.0, blue: 130.0/255.0, alpha: 1.0) {
        didSet {
            currentPageIndicator.backgroundColor = currentIndicatorTintColor
        }
    }
    
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
        return pageIndicator(with: currentIndicatorDiameter, backgroundColor: currentIndicatorTintColor)
    }()
    private var pageIndicators: [UIView] = []
    
    private var sizeConstraints: [NSLayoutConstraint] = []
    
    private func pageIndicator(with diameter: CGFloat, backgroundColor: UIColor?) -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = diameter / 2
        return view
    }
    
    private func removeViews() {
        for view in subviews {
            pageIndicators = []
            sizeConstraints = []
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
            
            setCurrrentIndicatorLocation()
        }
    }
    
    private func setCurrrentIndicatorLocation() {
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
        var constraints = [NSLayoutConstraint]()
        
        setupSizeConstraints()
        
        let isEvenNumber = Double(pageIndicators.count).truncatingRemainder(dividingBy: 2.0) == 0.0
        let initialElementIndex = isEvenNumber ? (pageIndicators.count / 2) - 1 : (pageIndicators.count / 2)
        let initialElement = pageIndicators[initialElementIndex]
        
        for index in 0...pageIndicators.count - 1 {
            let view = pageIndicators[index]
            let constraint: NSLayoutConstraint
            
            if (index != initialElementIndex) {
                constraint = view.centerXAnchor.constraint(equalTo: initialElement.centerXAnchor, constant: (CGFloat(index - initialElementIndex) * spacing))
            } else {
                constraint = view.centerXAnchor.constraint(equalTo: centerXAnchor, constant: isEvenNumber ? -(spacing / 2) : 0.0)
            }
            
            constraints.append(constraint)
        }
        
        (pageIndicators + [currentPageIndicator]).forEach {
            constraints.append($0.centerYAnchor.constraint(equalTo: centerYAnchor))
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupSizeConstraints () {
        sizeConstraints = sizeConstraintsForIndicators()
        NSLayoutConstraint.activate(sizeConstraints)
    }
    
    private func sizeConstraintsForIndicators() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: constraintsWithHeightAndWidth(equalTo: currentIndicatorDiameter, for: currentPageIndicator))
        pageIndicators.forEach { view in
            constraints.append(contentsOf: constraintsWithHeightAndWidth(equalTo: indicatorDiameter, for: view))
        }
        
        return constraints
    }
    
    private func constraintsWithHeightAndWidth(equalTo constant: CGFloat, for view: UIView) -> [NSLayoutConstraint] {
        return [
            view.heightAnchor.constraint(equalToConstant: constant),
            view.widthAnchor.constraint(equalTo: view.heightAnchor)
        ]
    }
}
