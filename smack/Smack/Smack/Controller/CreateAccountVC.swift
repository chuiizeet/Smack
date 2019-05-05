//
//  CreateAccountVC.swift
//  Smack
//
//  Created by imac on 5/5/19.
//  Copyright © 2019 JeguLabs. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    


}
