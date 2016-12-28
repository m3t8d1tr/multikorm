//
//  CategoryTableViewController.swift
//  multikorm
//
//  Created by Денис on 22.11.16.
//  Copyright © 2016 DenisTkachev. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    //сюда кладём получаемую структуру с данными
    var category : ViewController.Catalog?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
                 //отбираем корневые категории
        for parent_id in (category?.parentIdDict)! {
            if parent_id.value == 0 {
                print(category?.NameDict[parent_id.key])
            } else {
                print("ничего")}
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    
// после возврата на предыдущий контроллер там выполнить код
    // метод вызыввется перед удалением вида из иерархии вью.
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        if (self.isMovingFromParentViewController){
            navigationController?.isNavigationBarHidden = true //скрываем навигацию
        }
    }
    
    
}
