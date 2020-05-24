//
//  SelectGameViewController.swift
//  XO-game
//
//  Created by Денис Баринов on 23.5.20.
//  Copyright © 2020 plasmon. All rights reserved.
//

import UIKit

class SelectGameViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "HumanGame":
            if let controller = segue.destination as? GameViewController {
                controller.isComputerVsHuman = false
                controller.isBlindPlayerGame = false
            }
        case "ComputerGame":
            if let controller = segue.destination as? GameViewController {
                controller.isComputerVsHuman = true
                controller.isBlindPlayerGame = false
            }
        case "BlindPlayerGame":
            if let controller = segue.destination as? GameViewController {
                controller.isComputerVsHuman = false
                controller.isBlindPlayerGame = true
            }
        default :
            return
        }
    }
}
