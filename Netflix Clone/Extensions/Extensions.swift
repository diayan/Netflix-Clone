//
//  Extensions.swift
//  Netflix Clone
//
//  Created by diayan siat on 26/02/2022.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        //capitalize first letter, then extend that first letter and append the rest of the word to it without the first letter  
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
