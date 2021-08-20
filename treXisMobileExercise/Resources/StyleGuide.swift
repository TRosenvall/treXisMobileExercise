//
//  StyleGuide.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/13/21.
//

import UIKit

class StyleGuide {
    ///I had in my mind to call this application Lucas because at some point I got became slightly distracted by lucas
    ///numbers, a small mutation to the Fibonnaci numbers wherein the first numbers are 2, 1, 3, 4, 7, and so on. Much
    ///like the Fibonacci numbers, ratios formed by Lucas numbers converge to the golden ratio which I was going to use
    ///to scale various elements in the app. Incidentally, I had the thought to create a small icon and logo for the app
    ///using the Lucas spiral. I may still make and add it in, but that depends on time constraints.
    static let ratio: CGFloat = 0.618 //The golden ratio, Used for resizing elements.
    
    //Color Guide
    static let lucasPrimaryColor: UIColor = #colorLiteral(red: 0.184291482, green: 0.1843293309, blue: 0.184286505, alpha: 1)
    static let lucasAccentLightColor: UIColor = #colorLiteral(red: 0.8754730225, green: 0.8788470626, blue: 0.9136125445, alpha: 1)
    static let lucasAccentGreenColor: UIColor = #colorLiteral(red: 0.3864992857, green: 1, blue: 0.6309787631, alpha: 1)
    static let lucasAccentRedColor: UIColor = #colorLiteral(red: 1, green: 0.2400430441, blue: 0.3274297714, alpha: 1)
    
    //Error Styles
    ///I would normally make Code Smells into TODOs to remind me to come back later and fix the Style Guide. However given
    ///the nature of the application, it didn't seem prudent. If I have a code smell, I will be formatting it as follows.
    //Code Smell - Code Smell Type: What is the code smell, Why did the code smell happen, What should have been done.
}
