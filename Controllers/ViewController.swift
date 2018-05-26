//
//  ViewController.swift
//  CatchOliver
//
//  Created by Rebecca Hsiao on 2018/05/25.
//  Copyright © 2018年 Rebecca Hsiao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var resultLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    var myResult = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.29, green: 0.56, blue: 0.89, alpha: 1)
        self.button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        resultLabel.text = myResult
    }

    @objc func buttonPressed() {
        let vc = GameViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

