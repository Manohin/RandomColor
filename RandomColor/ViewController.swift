//
//  ViewController.swift
//  RandomColor
//
//  Created by Alexey Manokhin on 03.07.2023.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 10
    }
    
    @IBAction func getColorButtonTapped() {
        
        let color = getRandomColor()
        
        colorView.backgroundColor = UIColor(hexString: color)
        colorNumberLabel.textColor = UIColor(hexString: color)
        colorNumberLabel.text = color
    }
    
    private func getRandomColor() -> String {
        let letters = "0123456789ABCDEF"
        var color = "#"
        
        for _ in 0..<6 {
            let randomIndex = Int(arc4random_uniform(UInt32(letters.count)))
            let randomLetter = letters[letters.index(letters.startIndex, offsetBy: randomIndex)]
            color += String(randomLetter)
        }
        return color
    }
}

extension UIColor {
    convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
                    g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
                    b = CGFloat(hexNumber & 0x0000FF) / 255.0
                    a = 1.0
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}
