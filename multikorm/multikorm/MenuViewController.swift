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

    //сюда кладём получаемую структуру с данными
    
    
    //список пунктов меню
    var menuList = ["Category", "News", "Special", "Cabinet", "Shipping", "Payment"]
    
    //приминение протокола
    var delegate: MenuViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
// для таблицы две обязательные функции
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    //создаём ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: menuList[indexPath.row], for: indexPath)
        //cell.textLabel?.text = menuList[indexPath.row]
        return cell
    }
    
    //Добавляем заголовок секции
   // func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
   //     return "Категория \(section)" }


    @IBAction func menuCloseDidTouch(_ sender: AnyObject) {
    delegate?.menuCloseButtonTapped()
    }

    // передаём данные в следующий контроллер
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Category" {
            //что передаём?
            //передаём целую структуру с данными JSON
            if let destinationVC : CategoryTableViewController = segue.destination as? CategoryTableViewController {
                destinationVC.categories = 
                //print(categories.count)
                
            }
        }
    }
}









































