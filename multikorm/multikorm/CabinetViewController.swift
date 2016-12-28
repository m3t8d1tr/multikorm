//
//  CabinetViewController.swift
//  multikorm
//
//  Created by Денис on 22.11.16.
//  Copyright © 2016 DenisTkachev. All rights reserved.
//

import UIKit

class CabinetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
navigationController?.isNavigationBarHidden = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // после возврата на предыдущий контроллер там выполнить код
    // метод вызыввется перед удалением вида из иерархии вью.
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        if (self.isMovingFromParentViewController){
            navigationController?.isNavigationBarHidden = true //скрываем навигацию
        }
    }
    
}
