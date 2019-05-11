//
//  ProductsViewController.swift
//  RepublicApp
//
//  Created by Felipe Kaça Petersen on 10/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var constView1: NSLayoutConstraint!
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var constView2: NSLayoutConstraint!
    
    @IBOutlet var views: [UIView]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewTaps()
        // Do any additional setup after loading the view.
    }
    
    func viewTaps() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapView(_:)))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.didTapView(_:)))

        self.views[0].addGestureRecognizer(tap)
        self.views[1].addGestureRecognizer(tap2)
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
//        if let constraint = sender.view?.constraints.filter{ $0.identifier == "checkmarkLeftMargin" }.first { }
//        let checkmarkImageViewLeftMargin = sender.view?.constraints.first { $0.identifier == "checkmarkLeftMargin" }
        self.sendAllDown()
        sender.view?.getAllConstraints().first { $0.identifier == "top" }?.constant = 0
        sender.view?.getAllConstraints().first { $0.identifier == "bottom" }?.constant = 32
        
//        self.constView2.constant = sender.view?.frame.maxY ?? 0
//        self.constView2.constant = -100
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
    
    func sendAllDown() {
        for view in views {
            view.getAllConstraints().first { $0.identifier == "top" }?.constant = self.view.frame.height - 160
            view.getAllConstraints().first { $0.identifier == "bottom" }?.constant = -50
        }
    }

}

extension UIView {
    func findConstraint(layoutAttribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        if let constraints = superview?.constraints {
            for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: layoutAttribute) {
                return constraint
            }
        }
        return nil
    }
    
    func itemMatch(constraint: NSLayoutConstraint, layoutAttribute: NSLayoutConstraint.Attribute) -> Bool {
        if let firstItem = constraint.firstItem as? UIView, let secondItem = constraint.secondItem as? UIView {
            let firstItemMatch = firstItem == self && constraint.firstAttribute == layoutAttribute
            let secondItemMatch = secondItem == self && constraint.secondAttribute == layoutAttribute
            return firstItemMatch || secondItemMatch
        }
        return false
    }
    
    func getAllConstraints() -> [NSLayoutConstraint] {
        
        // array will contain self and all superviews
        var views = [self]
        
        // get all superviews
        var view = self
        while let superview = view.superview {
            views.append(superview)
            view = superview
        }
        
        // transform views to constraints and filter only those
        // constraints that include the view itself
        return views.flatMap({ $0.constraints }).filter { constraint in
            return constraint.firstItem as? UIView == self ||
                constraint.secondItem as? UIView == self
        }
    }
}
