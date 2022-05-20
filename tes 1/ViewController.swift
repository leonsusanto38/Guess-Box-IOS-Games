//
//  ViewController.swift
//  tes 1
//
//  Created by IOS on 17/03/22.
//

import UIKit
import AVFoundation

@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    var life = 5
    var number = 0
        
    @IBOutlet var allButton: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lifeDisplay.text = String(life)
        
        number = Int.random(in: 1...25)
        //tes angka yang di random
        print(number)
    }

    @IBOutlet weak var mainDisplay: UITextView!
    
    @IBOutlet weak var lifeDisplay: UITextView!
    
    @IBAction func buttonClick(_ sender: UIButton) {
        
        //mengetahui button mana yang dicek
        print(sender.titleLabel!.text!)
        if(sender.titleLabel?.text == String(number)) {
            sender.backgroundColor = UIColor.green
            mainDisplay.text = "YOU WIN!"
            for button in allButton {
                button.isUserInteractionEnabled = false
            }
            playWinSound()
        }
        else {
            if(life <= 1) {
                sender.backgroundColor = UIColor.red
                life = 0
                lifeDisplay.text = String(life)
                mainDisplay.text = "GAME OVER!"
                playGameOverSound()
                
                for button in allButton {
                    button.isUserInteractionEnabled = false
                }
            }
            else {
                sender.backgroundColor = UIColor.red
                life = life - 1
                lifeDisplay.text = String(life)
                playWrongSound()
            }
        }
        sender.isUserInteractionEnabled = false
    }
    
    @IBAction func restartButton(_ sender: UIButton) {
        restartGame()
    }
    
    func restartGame() {
        number = Int.random(in: 1...25)
        //tes angka yang di random
        print(number)
        
        life = 5
        lifeDisplay.text = String(life)
        
        for button in allButton {
            button.backgroundColor = UIColor.white
            button.isUserInteractionEnabled = true
        }
        
        mainDisplay.text = "Life left:"
    }
    
    func playWinSound() {
        if let url = Bundle.main.url(forResource: "win", withExtension: "wav") {
            player = try!
            AVAudioPlayer(contentsOf: url)
            player.play()
        }
        else {
            print("Error play sound")
        }
    }
    
    func playWrongSound() {
        if let url = Bundle.main.url(forResource: "wrong", withExtension: "wav") {
            player = try!
            AVAudioPlayer(contentsOf: url)
            player.play()
        }
        else {
            print("Error play sound")
        }
    }
    
    func playGameOverSound() {
        if let url = Bundle.main.url(forResource: "game over", withExtension: "wav") {
            player = try!
            AVAudioPlayer(contentsOf: url)
            player.play()
        }
        else {
            print("Error play sound")
        }
    }
}

