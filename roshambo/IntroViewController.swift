//
//  ViewController.swift
//  roshambo
//
//  Created by Colin Walsh on 1/8/18.
//  Copyright © 2018 Colin Walsh. All rights reserved.
//

import UIKit

enum roshamboSelect {
    case rock
    case paper
    case scissors
    
    static func computerPlayer() -> roshamboSelect {
        let randNumber = arc4random() % 3
        
        switch randNumber {
        case 0:
            return roshamboSelect.rock
        case 1:
            return roshamboSelect.paper
        default:
            return roshamboSelect.scissors
        }
    }

}

extension roshamboSelect: CustomStringConvertible {
    var description: String {
        switch self {
        case .paper:
            return "paper"
        case .rock:
            return "rock"
        case .scissors:
            return "scissors"
        }
    }
    
    static func getDescriptionFor(_ string: String) -> roshamboSelect {
        switch string {
        case "paper":
            return self.paper
        case "rock":
            return self.rock
        default:
            return self.scissors
        }
    }
}

enum VictoryImage: CustomStringConvertible {
    case paperCoversRock
    case scissorsCutPaper
    case rockCrushesScissors
    case itATie
    
    var image: UIImage {
        switch self {
        case .paperCoversRock:
            return UIImage(named: "PaperCoversRock") ?? UIImage()
        case .scissorsCutPaper:
            return UIImage(named: "ScissorsCutPaper") ?? UIImage()
        case .rockCrushesScissors:
            return UIImage(named: "RockCrushesScissors") ?? UIImage()
        default:
            return UIImage(named: "itsATie") ?? UIImage()
        }
    }
    
    var description: String {
        switch self {
        case .paperCoversRock:
            return "Paper covers rock."
        case .rockCrushesScissors:
            return "Rock crushes scissors."
        case .scissorsCutPaper:
            return "Scissors cut paper."
        default:
            return "It's a tie!"
        }
    }
}

final class IntroViewController: UIViewController {

    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func victoryCheck(_ playerSelect: String, computerSelect: String) -> (VictoryImage, Int) {
        if playerSelect == computerSelect {
            return (VictoryImage.itATie, 2)
        }
        
        switch playerSelect {
        case "rock":
            return computerSelect == "scissors" ?
                (VictoryImage.rockCrushesScissors, 0) :
                (VictoryImage.paperCoversRock, 1)
        case "paper":
            return computerSelect == "rock" ?
                (VictoryImage.paperCoversRock, 0) :
                (VictoryImage.scissorsCutPaper, 1)
        default:
            return computerSelect == "paper" ?
                (VictoryImage.scissorsCutPaper, 0) :
                (VictoryImage.rockCrushesScissors, 1)
        }
    }
    
    @IBAction func displayDetail(_ sender: UIButton) {
        switch sender.accessibilityIdentifier! {
        case "rock":
            
            let destination = self.storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
            
            destination.victoryModel = victoryCheck(sender.accessibilityIdentifier!, computerSelect: roshamboSelect.computerPlayer().description)
            present(destination, animated: true, completion: nil)
        case "paper":
            self.performSegue(withIdentifier: "viewControllerSegue",
                              sender:
                victoryCheck(sender.accessibilityIdentifier!, computerSelect: roshamboSelect.computerPlayer().description))
        default:
            print("Tie")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewControllerSegue" {
            let destination = segue.destination as! DetailViewController
            destination.victoryModel = sender as! (VictoryImage, Int)
        } else {
            let destination = segue.destination as! DetailViewController
            destination.victoryModel = victoryCheck("scissors", computerSelect: roshamboSelect.computerPlayer().description)
        }
    }
    


}

