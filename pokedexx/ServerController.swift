//
//  ServerController.swift
//  pokedexx
//
//  Created by binsnoel on 09/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol ServerControllerDelegate: class {
//    func didFinishTask(sender: ServerController)
//    func didFinishSingleTask(sender: ServerController)
//    func didFinishGetSpecies(sender: ServerController)
}

class ServerController {
    public static let shared = ServerController()
    weak var delegate:ServerControllerDelegate?
 

    
}
