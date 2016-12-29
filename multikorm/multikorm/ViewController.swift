//
//  ViewController.swift
//  multikorm
//
//  Created by Денис on 29.10.16.
//  Copyright © 2016 DenisTkachev. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,  MenuViewControllerDelegate {
    
    @IBOutlet weak var slideImageView: UIImageView!
    
   
    // объект хранения категорий
    var categories: [Category] = []
    
    //область для затемнения второй части экрана при активации меню
    var blackMaskView = UIView(frame: CGRect.zero)
    
    //View Controller - связываем два контроллера
    let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
    
    //constraint для анимации показа меню
    var menuLeftconstraint: NSLayoutConstraint?
    
    //начальное положение меню
    var isShowingMenu = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // загружаем данные с сервера
        loadCategories()
        
        //скрываем навигационное меню
        navigationController?.isNavigationBarHidden = true
        
        // подключаем картинки в слайдер
        slideImageView.animationImages = [
            UIImage(named: "slide1.jpg")!,
            UIImage(named: "slide2.png")!,
            UIImage(named: "slide3.jpg")!
        ]
        slideImageView.animationDuration = 5
        slideImageView.startAnimating()
        
        //добавляем меню на вьюшку
        addChildViewController(menuViewController)
        menuViewController.delegate = self
        menuViewController.didMove(toParentViewController: self)
        //почитать в документации про translatesAutoresizingMaskIntoConstraints
        menuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menuViewController.view)
        
        //верхний отступ для кнопки меню
        let topContraint = NSLayoutConstraint(item: menuViewController.view, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        let bottomContraint = NSLayoutConstraint(item: menuViewController.view, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        // на сколько будет выдвигаться меню
        let widthConstraint = NSLayoutConstraint(item: menuViewController.view, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 250)
   
        menuLeftconstraint = NSLayoutConstraint(item: menuViewController.view, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: -widthConstraint.constant)
        
        view.addConstraints([topContraint, menuLeftconstraint!, bottomContraint, widthConstraint])
        
        //toogleMenu()
    
    }
    //переключатель показа меню
     func toogleMenu() {
        
        isShowingMenu = !isShowingMenu
        if(isShowingMenu) {
            //hide menu
            menuLeftconstraint?.constant = -menuViewController.view.bounds.size.width
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in self.view.layoutIfNeeded()}, completion: {(completed) -> Void in self.menuViewController.view.isHidden = true})
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in self.view.layoutIfNeeded(); self.blackMaskView.alpha = 0.0}, completion: { (completed) -> Void in self.blackMaskView.removeFromSuperview()
            })
            
        } else {
            //present menu
            blackMaskView = UIView(frame: CGRect.zero)
            blackMaskView.alpha = 0.0
            blackMaskView.translatesAutoresizingMaskIntoConstraints = false
            blackMaskView.backgroundColor = UIColor.black
            view.insertSubview(blackMaskView, belowSubview: menuViewController.view)
            
            let topConstraint = NSLayoutConstraint(item: blackMaskView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
            
            let bottomConstraint = NSLayoutConstraint(item: blackMaskView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
            
            let leftConstraint = NSLayoutConstraint(item: blackMaskView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
            
            let rightConstraint = NSLayoutConstraint(item: blackMaskView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
            view.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
            view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in self.view.layoutIfNeeded()
                self.blackMaskView.alpha = 0.5}, completion: { (completed) -> Void in
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapGestureRecognized))
                self.blackMaskView.addGestureRecognizer(tapGesture)})
            
            menuViewController.view.isHidden = false
            menuLeftconstraint?.constant = 0
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in self.view.layoutIfNeeded()}, completion: {(completed) -> Void in self.menuViewController.view.isHidden = false})
            
        }
       
    }
    
    func tapGestureRecognized() {
        toogleMenu()
    }
    
    func menuCloseButtonTapped() {
        toogleMenu()
    }
    
    @IBAction func menuButtonDidTouch(_ sender: AnyObject) {
        toogleMenu()
    }
    // передаём данные в следующий контроллер
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // !указываем на какой контроллер переходим!
        var DestViewController : CategoryTableViewController = segue.destination as! CategoryTableViewController
        // получаем индекс выбранного элемента
        //что передаём?
        //передаём целую структуру с данными
        DestViewController.categories = self.categories
        
    }
    
    
    // функция для получения json
    func loadCategories() {
        
        let url = "https://multikorm.ru/json/category.json"
        
        Alamofire.request(url).responseJSON { (response) in // параметр безымянная функция - лямьда
            
            if let obj = response.result.value {
                let json = JSON(obj)
                var results: [Category] = []
                let categories = json["Category"].arrayValue
                for item in categories {
                    let name = item["name"].string!
                    let parent_id = item["parent_id"].int16!
                    let id = item["id"].int16!
                    
                    let category = Category(id: id, name: name, parent_id: parent_id)
                    results.append(category)
                }
                //results.sort(by: { (venue1, venue2) -> Bool in
                //   return venue1.distance! < venue2.distance!
                //})
                self.categories = results
                //self.tableView.reloadData()
                
            }
            
        } // получаем файл
    
    }
    
    
}

