//
//  ViewController.swift
//  Flashcards
//
//  Created by Ifeoluwakolopin Are on 2/27/22.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    // Array to hold all our flashcards
    var flashcards = [Flashcard]()
//    current flashcards index
    var currentIndex = 0
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = questionLabel.text
            creationController.initialAnswer = answerLabel.text
//          added all options to edit question segue
            creationController.initialOption2 = btn2.title(for: .normal)
            creationController.initialOption3 = btn3.title(for: .normal)
        }
        
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
        
//        Read saved flashcards
        readSavedFlashcards()
        
//        Adding our initial flashcard if needed
        if flashcards.count == 0 {
            updateFlashcard(question: "What is the best way to learn?", answer: "Practicing", extraOne: "Procastinating", extraTwo: "Eating")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
        
    }

    @IBAction func didTapOnBtn1(_ sender: Any) {
        questionLabel.isHidden = true
        btn1.layer.backgroundColor = #colorLiteral(red: 0.3204639256, green: 0.9908053279, blue: 0.5152505636, alpha: 1)
        btn2.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btn3.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @IBAction func didTapOnBtn2(_ sender: Any) {
        btn2.layer.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        btn1.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btn3.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @IBAction func didTapOnBtn3(_ sender: Any) {
        btn3.layer.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        btn2.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btn1.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @IBAction func didTapOnFlashCard(_ sender: Any) {
        if questionLabel.isHidden {
            questionLabel.isHidden = false
        }
        else {
            questionLabel.isHidden = true
        }
        
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
//        increase current index
        currentIndex = currentIndex + 1
        
//        update labels
        updateLabels()
        
//        update buttons
        updateNextPrevButtons()
        
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
//       increase current index
        currentIndex = currentIndex - 1
                
//        update labels
        updateLabels()
        
//        update buttons
        updateNextPrevButtons()
        
    }
    
    // Update flashcard with new questions.
    func updateFlashcard(question:String, answer: String, extraOne: String?, extraTwo: String?) {
        
        let flashcard = Flashcard(question: question, answer: answer)
        
        //  Adding flashcard in the flashcards array
        flashcards.append(flashcard)
        
//        Update current index
        currentIndex = flashcards.count - 1
        
//        Update labels
        updateLabels()

//        Update buttons
        updateNextPrevButtons()
        
        btn1.setTitle(answer, for: .normal)
        btn2.setTitle(extraOne, for: .normal)
        btn3.setTitle(extraTwo, for: .normal)
        
//        update flashcards in disk memory with new flashcard
        saveAllFlashcardsToDisk()
    
    }
    
    func updateNextPrevButtons() {
//      Disable the next buton if at the end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
//      Disable previous button if at the beginning
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels() {
//        Get current flashcad
        let currentFlashcard = flashcards[currentIndex]
        
//        update labels
        questionLabel.text = currentFlashcard.question
        answerLabel.text = currentFlashcard.answer
    
    }
    
    func saveAllFlashcardsToDisk() {
        
//        Convert flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        
//       Save array on disk using UserDefaults
        UserDefaults.standard.set(
            dictionaryArray, forKey: "flashcards"
        )
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards() {
//        read dictionary Arry from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            let savedCards  = dictionaryArray.map {
                dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
//            put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
        
    }

}
