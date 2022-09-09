//
//  ViewController.swift
//  MVPDesignMode
//
//  Created by 林文俊 on 2022/9/6.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationController?.pushViewController(HomeVC(), animated: true)
    }
}

