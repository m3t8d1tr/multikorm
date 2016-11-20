//
//  ViewController.swift
//  multikorm
//
//  Created by Денис on 29.10.16.
//  Copyright © 2016 DenisTkachev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MenuViewControllerDelegate {

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
        // Do any additional setup after loading the view, typically from a nib.
        
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
        //вот тут не как у него в видео, topContraint -> у него topConstraint
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
                let tapGesture = UITapGestureRecognizer(target: self, action: "tapGestureRecognized")
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
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


}

