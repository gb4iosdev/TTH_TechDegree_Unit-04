//
//  PassanCodeTemp.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 03-09-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation


//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == "startAdventure" {
//
//        do {
//            if let name = nameTextField.text {
//                if name == "" {
//                    throw AdventureError.nameNotProvided
//                } else {
//                    guard let pageController = segue.destination as? PageController else { return }
//
//                    pageController.page = Adventure.story(withName: name)
//                }
//            }
//        } catch AdventureError.nameNotProvided {
//            let alertController = UIAlertController(title: "Name Not Provided", message: "Provide a name to start the story", preferredStyle: .alert)
//
//            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alertController.addAction(action)
//
//            present(alertController, animated: true, completion: nil)
//        } catch let error {
//            fatalError("\(error.localizedDescription)")
//        }
//    }
//}
