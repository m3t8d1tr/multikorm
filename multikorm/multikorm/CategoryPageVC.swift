//
//  CategoryPagyVC.swift
//  multikorm
//
//  Created by Денис on 05.11.16.
//  Copyright © 2016 DenisTkachev. All rights reserved.
//

import UIKit



class CategoryPageVC: UIViewController, MenuViewControllerDelegate {
    
    
    func menuCloseButtonTapped() {
        delegate?.menuCloseButtonTapped()
    }
    
    //приминение протокола
    var delegate: MenuViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backtomenu(_ sender: Any) {
    //delegate?.menuCloseButtonTapped()
    }
    
    
}
