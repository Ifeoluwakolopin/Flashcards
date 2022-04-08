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
    var extraOne: String
    var extraTwo: String
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
        card.layer.cornerRadius = 25.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        questionLabel.layer.cornerRadius = 25.0
        answerLabel.layer.cornerRadius = 25.0
        
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
            updateFlashcard(question: "What is the best way to learn?", answer: "Practicing", extraOne: "Procastinating", extraTwo: "Eating", isExisting: false)
        } else {
            updateOptions()
            updateLabels()
            updateNextPrevButtons()
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        First start with the flashcard invisible and slightly smaller in size
        card.alpha = 0.0
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
//        Animation
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.card.alpha = 1.0
            self.card.transform = CGAffineTransform.identity
        })
    }
    
//    ACTIONS
    
    @IBAction func didTapOnBtn1(_ sender: Any) {
//        Flip flashcard if correct answer else disable
        if btn1 == correctAnswerButton {
            flipFlashcard()
            btn1.layer.backgroundColor = #colorLiteral(red: 0.3204639256, green: 0.9908053279, blue: 0.5152505636, alpha: 1)
        } else {
            questionLabel.isHidden = false
            btn1.setTitleColor(.white, for: .normal)

        }

    }
    

    
    @IBAction func didTapOnBtn2(_ sender: Any) {
//        Flip flashcard if correct answer else disable
        if btn2 == correctAnswerButton {
            flipFlashcard()
            btn2.layer.backgroundColor = #colorLiteral(red: 0.3204639256, green: 0.9908053279, blue: 0.5152505636, alpha: 1)
        } else {
            questionLabel.isHidden = false
            btn2.setTitleColor(.white, for: .normal)
        }
    }
    
    @IBAction func didTapOnBtn3(_ sender: Any) {
//        Flip flashcard if correct answer else disable
        if btn3 == correctAnswerButton {
            flipFlashcard()
            btn3.layer.backgroundColor = #colorLiteral(red: 0.3204639256, green: 0.9908053279, blue: 0.5152505636, alpha: 1)
        } else {
            questionLabel.isHidden = false
            btn3.setTitleColor(.white, for: .normal)

        }
    }
    
    @IBAction func didTapOnFlashCard(_ sender: Any) {
        flipFlashcard()
    }
    
    func flipFlashcard() {
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            if self.questionLabel.isHidden == false {
                self.questionLabel.isHidden = true
            } else {
                self.questionLabel.isHidden = false
            }
            
        })
    }
    
//    Added function parameters infloat and outfloat to specify the
//    direction of the card animations and reuse the functions for both next and previous buttons
    func animateCardOut(outfloat: CGFloat, infloat: CGFloat) {
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: outfloat, y: 0.0)
//            This flips the card to the question label before switching to the next card. This is important incase use leaves the answerlabel form the previous question on.
            self.questionLabel.isHidden = false
        }, completion: {
            finished in
            // update labels
            self.updateLabels()
//            Run other animation
            self.animateCardIn(infloat: infloat)
        })
    }
    
    func animateCardIn(infloat: CGFloat) {
        
//        Start on the right side
        card.transform = CGAffineTransform.identity.translatedBy(x: infloat, y: 0.0)
//        Animate the card going back to its original position
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
//        increase current index
        currentIndex = currentIndex + 1
                
//        update options
        updateOptions()
        
//        reset buttons colors to white
        resetButtonColors()
        
//        update buttons
        updateNextPrevButtons()
        
        animateCardOut(outfloat: -300, infloat: 300)
        
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
//       increase current index
        currentIndex = currentIndex - 1
        
//        update options
        updateOptions()
        
//        reset button colors to white
        resetButtonColors()
        
//        update buttons
        updateNextPrevButtons()
        
        animateCardOut(outfloat: 300, infloat: -300)
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        
//       Show confirmation
        let alert = UIAlertController(
            title: "Delete flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
            action in self.deleteCurrentFlashcard()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    
//    FUNCTIONS
    
    // Update flashcard with new questions.
    func updateFlashcard(question:String, answer: String, extraOne: String?, extraTwo: String?, isExisting: Bool) {
        
        let flashcard = Flashcard(question: question, answer: answer, extraOne: extraOne ?? "None", extraTwo: extraTwo ?? "None")
        
        if isExisting {
            flashcards[currentIndex] = flashcard
        } else {
//        Adding flashcard in the flashcards array
            flashcards.append(flashcard)
            
//        Update current index
            currentIndex = flashcards.count - 1
        }
//        update options
        updateOptions()
        
//        Update labels
        updateLabels()

//        Update buttons
        updateNextPrevButtons()
        
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
    
    var correctAnswerButton: UIButton!
    
    func updateLabels() {
//        Get current flashcad
        let currentFlashcard = flashcards[currentIndex]
        
//        update labels
        questionLabel.text = currentFlashcard.question
        answerLabel.text = currentFlashcard.answer
    
    }
    
    func resetButtonColors() {
        self.btn1.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btn2.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btn3.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btn1.setTitleColor(.black, for: .normal)
        self.btn2.setTitleColor(.black, for: .normal)
        self.btn3.setTitleColor(.black, for: .normal)
    }
    
    func updateOptions() {
        
        let flashcard = flashcards[currentIndex]
        
        let buttons = [btn1, btn2, btn3].shuffled()
        let answers = [flashcard.answer, flashcard.extraOne, flashcard.extraTwo].shuffled()
        
        for (button, answer) in zip(buttons, answers) {
            button?.setTitle(answer, for: .normal)
            
            if answer == flashcard.answer {
                correctAnswerButton = button
            }
        }
        
    }
    
    func saveAllFlashcardsToDisk() {
        
//        Convert flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer, "extraOne":card.extraOne, "extraTwo":card.extraTwo]
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
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extraOne: dictionary["extraOne"] ?? "None", extraTwo: dictionary["extraTwo"] ?? "None")
            }
            
//            put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
        
    }
    
    func deleteCurrentFlashcard() {
//        Delete current
        flashcards.remove(at: currentIndex)
        
//        Edge case: Check if the last card was deleted
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        
        updateOptions()
        
        updateLabels()
        updateNextPrevButtons()
        saveAllFlashcardsToDisk()
        
    }

}
