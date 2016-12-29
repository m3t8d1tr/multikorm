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
    var categories : [Category?] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        //print(categories.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    //нужно создать и настроить ячейку для строки под номером indexPath.row
    //в секции indexPath.section
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //таблица из сториборда достанет ячейку по шаблону с идентификатором
        //CategoryCell. Изначально это будет UITableViewCell и мы преобразуем его
        //в наш собственный класс CategoryCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CategoryCell
        
        //настраиваем внешний вид ячейки
        let category = categories[indexPath.row]
        cell.textLabel?.text = category?.name
        return cell
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
