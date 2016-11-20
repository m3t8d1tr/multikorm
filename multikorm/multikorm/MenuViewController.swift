//
//  MenuViewController.swift
//  multikorm
//
//  Created by Денис on 29.10.16.
//  Copyright © 2016 DenisTkachev. All rights reserved.
//

import UIKit
//создаём протокол делегат для передачи нажатия в менюшки
//закрытие меню по нажатию на кнопку
protocol MenuViewControllerDelegate {
    func menuCloseButtonTapped()
}

//для таблицы добавили классы UITableViewDataSource, UITableViewDelegate
class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    var fruits = ["Apple", "Apricot", "Banana", "Blueberry", "Cantaloupe", "Cherry",
                  "Clementine", "Coconut", "Cranberry", "Fig", "Grape", "Grapefruit",
                  "Kiwi fruit", "Lemon", "Lime", "Lychee", "Mandarine", "Mango",
                  "Melon", "Nectarine", "Olive", "Orange", "Papaya", "Peach",
                  "Pear", "Pineapple", "Raspberry", "Strawberry"]
    
    //приминение протокола
    var delegate: MenuViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
// для таблицы две обязательные функции
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    //создаём ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
   
        
        cell.textLabel?.text = fruits[indexPath.row]
        return cell
    }
    
    
    //Добавляем заголовок секции
   // func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
   //     return "Категория \(section)" }


    @IBAction func menuCloseDidTouch(_ sender: AnyObject) {
    delegate?.menuCloseButtonTapped()
    }

}









































