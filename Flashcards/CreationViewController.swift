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
        
//      assign data from existing question into these
//          variables to create new questions.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        extraAnswerOne.text = initialOption2
        extraAnswerTwo.text = initialOption3
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Get the question and answer fields as IBOutlets
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var extraAnswerOne: UITextField!
    @IBOutlet weak var extraAnswerTwo: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    var initialOption2: String?
    var initialOption3: String?
    
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
//    Get the text for the extra answers
        let answerText1 = extraAnswerOne.text
        let answerText2 = extraAnswerTwo.text
        
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
//          See if card exists
            var isExisting = false
            
            if initialQuestion != nil {
                isExisting = true
            }
            
        // Call the function to update the flashcard
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraOne: answerText1!, extraTwo: answerText2!, isExisting: isExisting)
        
        // dismiss after tapping done.
        dismiss(animated: true)
            
        }
    }

}
