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
    
    func getRandomColor() -> String {
        // Создаем строку с символами, которые будут использованы для формирования HEX-кода цвета
        let letters = "0123456789ABCDEF"
        
        // Инициализируем переменную, которая будет содержать сгенерированный цвет в формате HEX
        var color = "#"

        // Генерируем случайный цвет путем итерации 6 раз (6 символов в HEX-коде)
        for _ in 0..<6 {
            // Генерируем случайный индекс символа из диапазона letters (от 0 до 15)
            let randomIndex = Int(arc4random_uniform(UInt32(letters.count)))
            
            // Получаем случайный символ из letters по сгенерированному индексу
            let randomLetter = letters[letters.index(letters.startIndex, offsetBy: randomIndex)]
            
            // Добавляем полученный случайный символ к строке color
            color += String(randomLetter)
        }

        // Возвращаем сгенерированный случайный цвет в формате HEX
        return color
    }
}

extension UIColor {
    convenience init?(hexString: String) {
        // Объявляем переменные для компонентов цвета (красный, зеленый, синий, альфа-канал)
        let r, g, b, a: CGFloat
        
        // Проверяем, начинается ли строка hexString с символа "#"
        if hexString.hasPrefix("#") {
            // Если да, то удаляем символ "#" из начала строки
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            // Проверяем, что строка hexColor содержит 6 символов (для представления HEX-кода цвета)
            if hexColor.count == 6 {
                // Используем Scanner для преобразования HEX-кода в числовые значения
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                // Сканируем HEX-код и преобразуем его в целочисленное значение hexNumber
                if scanner.scanHexInt64(&hexNumber) {
                    // Извлекаем компоненты цвета из целочисленного значения
                    // и преобразуем их в дробные значения (CGFloat) в диапазоне от 0 до 1
                    r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
                    g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
                    b = CGFloat(hexNumber & 0x0000FF) / 255.0
                    a = 1.0 // Устанавливаем альфа-канал в значение 1.0 (полностью непрозрачный цвет)
                    
                    // Инициализируем UIColor с полученными компонентами цвета
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        // В случае неверного формата HEX-кода возвращаем nil
        return nil
    }
}
