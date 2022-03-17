//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Ifeoluwakolopin Are on 3/13/22.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer

        // Do any additional setup after loading the view.
    }
    
    // Get the question and answer fields as IBOutlets
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    var initialQuestion: String?
    var initialAnswer: String?
    
//    Handles action for cancling new question action.
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
// Handles the action for taping Done after pop-up
    @IBAction func didTapOnDone(_ sender: Any) {
        
//    Get the text in the question text field
        let questionText = questionTextField.text
        
//    Get the text in the answer text field
        let answerText = answerTextField.text
        
//        design alert button
        let missingTextAlert = UIAlertController(
            title: "Missing text", message: "You need to enter both a question and an answer", preferredStyle: UIAlertController.Style.alert        )
//    add OK button
        let okAction = UIAlertAction(title: "Ok", style: .default)
//        attach Ok button to alertbutton
        missingTextAlert.addAction(okAction)
        
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty {
            present(missingTextAlert, animated: true)
        } else {
        // Call the function to update the flashcard
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
        
        // dismiss after tapping done.
        dismiss(animated: true)
            
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
