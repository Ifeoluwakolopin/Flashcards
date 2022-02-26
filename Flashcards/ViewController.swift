//
//  ViewController.swift
//  Flashcards
//
//  Created by Ifeoluwakolopin Are on 2/27/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    override func viewDidLoad() {
        // This function runs before the user sees the app
        super.viewDidLoad()
        
    }
    
    @IBAction func didTapOnFlashCard(_ sender: Any) {
        questionLabel.isHidden = true
    }
    
}

