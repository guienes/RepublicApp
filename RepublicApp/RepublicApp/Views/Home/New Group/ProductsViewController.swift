//
//  ProductsViewController.swift
//  RepublicApp
//
//  Created by Felipe Kaça Petersen on 10/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    
    @IBOutlet var views: [ProductView]!
    @IBOutlet var titleViews: [UIView]!
    
    @IBOutlet weak var itemTextField: UITextField!
    
    @IBOutlet weak var qtdLabel: UILabel!
    
    @IBOutlet weak var yesView: UIView!
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var noView: UIView!
    @IBOutlet weak var noLabel: UILabel!
    
    @IBOutlet weak var despensaComumTableView: UITableView!
    @IBOutlet weak var despensaPessoalTableView: UITableView!
    @IBOutlet weak var comprasComumTableView: UITableView!
    @IBOutlet weak var comprasPessoalTableView: UITableView!
    
   
    let productCell = "ProductTableViewCell"
    let model = ProductsViewModel()
    
    var selectedTag = -1
    let topConsts = [40, 110, 180, 250]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewTaps()
        self.registerViewTag()
        self.setShadow()
        self.setupTableView()
        self.setupSegmetTap()
    }
    
    func setupTableView() {
        self.comprasPessoalTableView.delegate = self
        self.comprasPessoalTableView.dataSource = self
        comprasPessoalTableView.register(UINib(nibName: productCell, bundle: nil), forCellReuseIdentifier: productCell)

    }
    
    func registerViewTag() {
        var tag = 0
        for view in titleViews {
            view.tag = tag
            tag += 1
        }
    }
    
    func setShadow() {
        for view in views {
            view.setupShadows()
        }
    }
    
    func viewTaps() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapView(_:)))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.didTapView(_:)))
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(self.didTapView(_:)))
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(self.didTapView(_:)))
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(teste))
        self.titleViews[0].addGestureRecognizer(tap)
        self.titleViews[1].addGestureRecognizer(tap2)
        self.titleViews[2].addGestureRecognizer(tap3)
        self.titleViews[3].addGestureRecognizer(tap4)
        self.view.addGestureRecognizer(dismissTap)
    }
    
    @objc func teste() {
        self.itemTextField.endEditing(true)
    }
    
    func setupSegmetTap() {
        let tapYes = UITapGestureRecognizer(target: self, action: #selector(didTapYes))
        let tapNo = UITapGestureRecognizer(target: self, action: #selector(didTapNo))
        
        self.yesView.addGestureRecognizer(tapYes)
        self.noView.addGestureRecognizer(tapNo)
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
//        if let constraint = sender.view?.constraints.filter{ $0.identifier == "checkmarkLeftMargin" }.first { }
//        let checkmarkImageViewLeftMargin = sender.view?.constraints.first { $0.identifier == "checkmarkLeftMargin" }
        if selectedTag != -1 {
            sendAllUp()
            selectedTag = -1
        } else {
            self.sendAllDown()
            self.views?[sender.view?.tag ?? 0].getAllConstraints().first { $0.identifier == "top" }?.constant = 0
            self.views?[sender.view?.tag ?? 0].getAllConstraints().first { $0.identifier == "bottom" }?.constant = 100
            self.selectedTag = sender.view?.tag ?? -1
        }
//        self.constView2.constant = sender.view?.frame.maxY ?? 0
//        self.constView2.constant = -100
        UIView.animate(withDuration: 0.6) {
            self.view.layoutIfNeeded()
        
        }
    }
    
    @objc func didTapYes() {
        yesView.backgroundColor = .white
        yesLabel.textColor = UIColor(red: 135/255.0, green: 81/255.0, blue: 131/255.0, alpha: 1)
        noView.backgroundColor = .clear
        noLabel.textColor = .white
        model.isConstant = true
    }
    
    @objc func didTapNo() {
        noView.backgroundColor = .white
        noLabel.textColor = UIColor(red: 135/255.0, green: 81/255.0, blue: 131/255.0, alpha: 1)
        yesView.backgroundColor = .clear
        yesLabel.textColor = .white
        model.isConstant = false
    }
    
    func sendAllDown() {
        var const:CGFloat = 130
        for view in views {
            view.getAllConstraints().first { $0.identifier == "top" }?.constant = self.view.frame.height - const
            view.getAllConstraints().first { $0.identifier == "bottom" }?.constant = -50
            const -= 10
        }
    }
    
    func sendAllUp() {
        for i in views.indices {
            views[i].getAllConstraints().first { $0.identifier == "top" }?.constant = CGFloat(self.topConsts[i])
            views[i].getAllConstraints().first { $0.identifier == "bottom" }?.constant = -40
        }
    }
    
    //MARK:- Add Buttons
    func moveAllDownForAdd() {
        self.sendAllDown()
        selectedTag = 5
        UIView.animate(withDuration: 0.6) {
            self.view.layoutIfNeeded()
            
        }
    }
    
    @IBAction func despensaComumTap(_ sender: Any) {
        moveAllDownForAdd()
    }
    
    @IBAction func despensaPessoalTap(_ sender: Any) {
        moveAllDownForAdd()
    }
    
    @IBAction func comprasComumTap(_ sender: Any) {
        moveAllDownForAdd()
    }
    
    @IBAction func comprasPessoalTap(_ sender: Any) {
        moveAllDownForAdd()
    }
    
    //MARK: - Create Buttons
    @IBAction func lessButtonTap(_ sender: Any) {
        self.qtdLabel.text = String(model.lessQtd())
    }
    @IBAction func moreButtonTap(_ sender: Any) {
        self.qtdLabel.text = String(model.addQtd())
    }
    @IBAction func createButtonTap(_ sender: Any) {
    }
    
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = comprasPessoalTableView.dequeueReusableCell(withIdentifier: productCell, for: indexPath) as! ProductTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("comi o cu do enes")
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
