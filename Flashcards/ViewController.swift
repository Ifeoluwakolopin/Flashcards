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
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.initialQuestion = questionLabel.text
        creationController.initialAnswer = answerLabel.text
        
        creationController.flashcardsController = self
        
    }
    override func viewDidLoad() {
        // This function runs before the user sees the app
        
        // These customize the views of the card which contains the question and answer views
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        card.clipsToBounds = true
        questionLabel.clipsToBounds = true
        answerLabel.clipsToBounds = true
        
        btn1.layer.borderWidth = 3.0
        btn2.layer.borderWidth = 3.0
        btn3.layer.borderWidth = 3.0
        
        btn1.layer.cornerRadius = 20.0
        btn2.layer.cornerRadius = 20.0
        btn3.layer.cornerRadius = 20.0
        
        // colorLiteral will display when you type #colorLiteral(
        btn1.layer.borderColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        btn2.layer.borderColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        btn3.layer.borderColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
        
        
        super.viewDidLoad()
        
    }

    @IBAction func didTapOnBtn1(_ sender: Any) {
        questionLabel.isHidden = true
        btn1.layer.backgroundColor = #colorLiteral(red: 0.3204639256, green: 0.9908053279, blue: 0.5152505636, alpha: 1)
    }
    
    @IBAction func didTapOnBtn2(_ sender: Any) {
        btn2.layer.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    }
    
    @IBAction func didTapOnBtn3(_ sender: Any) {
        btn3.layer.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    }
    
    @IBAction func didTapOnFlashCard(_ sender: Any) {
        if questionLabel.isHidden {
            questionLabel.isHidden = false
        }
        else {
            questionLabel.isHidden = true
        }
        
    }
    
    func updateFlashcard(question:String, answer: String) {
        
        
    }
    
}
