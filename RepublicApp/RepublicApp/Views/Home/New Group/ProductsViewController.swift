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
        self.products()
        registerTableView()
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
    
    func registerTableView() {
        self.despensaComumTableView.tag = 1
        self.despensaPessoalTableView.tag = 2
        self.comprasComumTableView.tag = 3
        self.comprasPessoalTableView.tag = 4
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
    
    //MARK:-Get Products
    func products() {
        let group = DispatchGroup() // initialize the async
        var called = false
        group.enter()
        getProducts(idRepublic: UserDefaults.standard.string(forKey: REPUBLIC_ID) ?? "") { (result, error, products) in
            if !called {
                if let prod = products {
                    self.model.products = prod
                    called = true
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            //            let check = response["result"] as? String
            self.model.filterData()
            self.despensaPessoalTableView.reloadData()
            self.despensaComumTableView.reloadData()
            self.comprasComumTableView.reloadData()
            self.comprasPessoalTableView.reloadData()
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
        model.addIsList = false
        model.addIsComum = true
    }
    
    @IBAction func despensaPessoalTap(_ sender: Any) {
        moveAllDownForAdd()
        model.addIsList = false
        model.addIsComum = false
    }
    
    @IBAction func comprasComumTap(_ sender: Any) {
        moveAllDownForAdd()
        model.addIsList = true
        model.addIsComum = true
    }
    
    @IBAction func comprasPessoalTap(_ sender: Any) {
        moveAllDownForAdd()
        model.addIsList = true
        model.addIsComum = false
    }
    
    //MARK: - Create Buttons
    @IBAction func lessButtonTap(_ sender: Any) {
        self.qtdLabel.text = String(model.lessQtd())
    }
    @IBAction func moreButtonTap(_ sender: Any) {
        self.qtdLabel.text = String(model.addQtd())
    }
    @IBAction func createButtonTap(_ sender: Any) {
        if let itemName = itemTextField.text {
            self.model.requestNewProduct.isComum = self.model.addIsComum
            self.model.requestNewProduct.isListBuy = self.model.addIsList
            self.model.requestNewProduct.republic = UserDefaults.standard.string(forKey: REPUBLIC_ID)
            self.model.requestNewProduct.designation = UserDefaults.standard.string(forKey: USER_ID)
            self.model.requestNewProduct.quantity = self.model.quantity
            self.model.requestNewProduct.isRecorrente = self.model.isConstant
            self.model.requestNewProduct.name = itemName
            
            var response: [String : Any]?
            let group = DispatchGroup() // initialize the async
            var called = false
            group.enter()
            postProduct(product: self.model.requestNewProduct) { (result, error) in
                if !called {
                    if let re = result {
                        response = re
                        called = true
                        group.leave()
                        
                    }
                }
            }
            group.notify(queue: .main) {
                //            let check = response["result"] as? String
                if let response = response {
                    self.sendAllUp()
                    self.selectedTag = -1
                    UIView.animate(withDuration: 0.6) {
                        self.view.layoutIfNeeded()
                    }
                } else {
                    //error
                }
            }
        }
    }
    
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == despensaComumTableView {
            return self.model.getNumberOfRows(tableViewIndex: despensaComumTableView.tag)
        } else if tableView == despensaPessoalTableView {
            return self.model.getNumberOfRows(tableViewIndex: despensaPessoalTableView.tag)
        } else if tableView == comprasComumTableView {
            return self.model.getNumberOfRows(tableViewIndex: comprasComumTableView.tag)
        } else {
            return self.model.getNumberOfRows(tableViewIndex: comprasPessoalTableView.tag)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = despensaComumTableView.dequeueReusableCell(withIdentifier: productCell, for: indexPath) as! ProductTableViewCell
        
        let cell2 = despensaPessoalTableView.dequeueReusableCell(withIdentifier: productCell, for: indexPath) as! ProductTableViewCell

        let cell3 = comprasComumTableView.dequeueReusableCell(withIdentifier: productCell, for: indexPath) as! ProductTableViewCell

        let cell4 = comprasPessoalTableView.dequeueReusableCell(withIdentifier: productCell, for: indexPath) as! ProductTableViewCell

        cell.delegate = self
        cell2.delegate = self
        cell3.delegate = self
        cell4.delegate = self
        
        if tableView == despensaComumTableView {
            cell.setup(product: self.model.getCellForRow(index: indexPath.row, tableViewIndex: despensaComumTableView.tag))
            return cell
        } else if tableView == despensaPessoalTableView {
            cell2.setup(product: self.model.getCellForRow(index: indexPath.row, tableViewIndex: despensaPessoalTableView.tag))
            return cell2
        } else if tableView == comprasComumTableView {
            cell3.setup(product: self.model.getCellForRow(index: indexPath.row, tableViewIndex: comprasComumTableView.tag))
            return cell3
        } else {
            cell4.setup(product: self.model.getCellForRow(index: indexPath.row, tableViewIndex: comprasPessoalTableView.tag))
            return cell4
        }
    }
}

extension ProductsViewController: ProductTableViewCellDelegate {
    func deleteCell(id: String) {
        var response: [String : Any]?
        let group = DispatchGroup() // initialize the async
        var called = false
        deleteProducts(idProduct: id) { (result, error) in
            if !called {
                if let re = result {
                    response = re
                    called = true
                    group.leave()
                    
                }
            }
        }
        group.notify(queue: .main) {
            //            let check = response["result"] as? String
            if let response = response {
                //alguma coisa quando deletar
            } else {
                //error
            }
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
