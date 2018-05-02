//
//  AppDelegate.swift
//  BarButtonItem
//
//  Created by Ahmed Khedr on 5/2/18.
//  Copyright © 2018 Ahmed Khedr. All rights reserved.
//

import UIKit

let userDefaultsKeyForFontName = "font"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        appearance()
        
        return true
    }
    
    private func appearance() {
        let baseFont = checkForSavedFont()
        
        /*
         Appearance proxies on
         1. navigation bar
         2. bar button items
         work as expected on app launch.
         */
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedStringKey.font : baseFont as Any
        ]
        
        for controlState in [UIControlState.disabled, .highlighted, .normal] {
            UIBarButtonItem.appearance().setTitleTextAttributes([
                NSAttributedStringKey.font : baseFont as Any
                ]
                , for: controlState)
        }
    }
    
    private func checkForSavedFont() -> UIFont {
        var fontName: String
        
        if let savedFontName = UserDefaults.standard.string(forKey: userDefaultsKeyForFontName) {
            fontName = savedFontName
        } else {
            fontName = "Palatino"
            
            UserDefaults.standard.set(fontName, forKey: userDefaultsKeyForFontName)
        }
        
        guard let baseFont = UIFont(name: fontName, size: 15) else {
            fatalError("Change the two fonts in view controller to a font names that exist!")
        }
        
        return baseFont
    }
}
