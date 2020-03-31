//
//  ViewController.swift
//  OptionAlert
//
//  Created by Deftsoft on 03/03/20.
//  Copyright © 2020 Deftsoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }


    @IBAction func showAlertAction(_ sender: UIButton) {

        let alert = OptionAlt(labelArray: ["Camera","Gallery"], imagesArray: [#imageLiteral(resourceName: "camera"),#imageLiteral(resourceName: "gallery")])
        alert.show()
        alert.firstButton.addTarget {
            alert.remove()
        }
        alert.secondButton.addTarget {
           alert.remove()
        }
      
        
        
    }
}
   
    


