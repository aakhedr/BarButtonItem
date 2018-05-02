//
//  ViewController.swift
//  BarButtonItem
//
//  Created by Ahmed Khedr on 5/2/18.
//  Copyright © 2018 Ahmed Khedr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var selectButton: UIBarButtonItem!
    @IBOutlet weak var updateButton: UIBarButtonItem!
    @IBOutlet weak var changeFontButton: UIButton!
    
    private let palatinoFontName = "Palatino"
    private let anotherFontName = "CourierNewPSMT"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChangeFontButton()
        title = "This title changes font"
    }

    @IBAction func changeFont(_ sender: UIButton) {
        guard let currentFontName = UserDefaults.standard.string(forKey: userDefaultsKeyForFontName) else { return }
        
        if currentFontName == palatinoFontName {
            setFont(anotherFontName)
        } else {
            setFont(palatinoFontName)
        }
    }
    
    private func setFont(_ fontName: String) {
        guard let font = UIFont(name: fontName, size: 15) else {
            fatalError("Change the '\(fontName)' to a font name that exists!")
        }
        
        // Navigation Bar title changes its font as expected
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font : font as Any
        ]
        
        /*
         ***** The problem is here ******
         This is happening only on iOS 11 - iOS 10 bar button items change font as expected
         
         Bar button items do not get affected by setting the title text attributes
         It seems that the project HAS TO either:
         1. be re-run or
         2. the bar button item title HAS TO change
         for the new text attributes to take effect?
        */
        for controlState in [UIControlState.disabled, .highlighted, .normal] {
            updateButton.setTitleTextAttributes([
                NSAttributedStringKey.font : font as Any
                ], for: controlState)
            
            selectButton.setTitleTextAttributes([
                NSAttributedStringKey.font : font as Any
                ], for: controlState)
        }
        
        UserDefaults.standard.set(fontName, forKey: userDefaultsKeyForFontName)
    }
    
    private func setupChangeFontButton() {
        changeFontButton.titleLabel?.textColor = .black
        changeFontButton.layer.borderWidth = 1
        changeFontButton.layer.cornerRadius = 5
        changeFontButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

