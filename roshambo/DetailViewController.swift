//
//  DetailViewController.swift
//  roshambo
//
//  Created by Colin Walsh on 1/8/18.
//  Copyright © 2018 Colin Walsh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var resultImageView: UIImageView!
    
    var victoryModel: (VictoryImage, Int)!
    
    @IBOutlet weak var resultDescriptionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let (image, victoryCheck) = victoryModel
        
        resultImageView.image = image.image
        
        if victoryCheck == 0 {
            resultDescriptionLabel.text = image.description + " You win!"
        } else if victoryCheck == 1 {
            resultDescriptionLabel.text = image.description + " You lose!"
        } else {
            resultDescriptionLabel.text = image.description
        }
    }
    
    @IBAction func playAgain() {
       self.dismiss(animated: true, completion: nil)
    }
}
