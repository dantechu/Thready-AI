//
//  Colors+Extension.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/9/23.
//

import Foundation

import SwiftUI

extension Color {
    //static let BGCOLOR = Color(red: 28/255, green: 28/255, blue: 29/255)
    static let BGCOLOR = Color(red: 0/255, green: 0/255, blue: 0/255)
    
    
    static let TEXTFIELDBGCOLOR = Color(red: 44/255, green: 45/255, blue: 46/255)
    static let TEXTFIELDPLACEHOLDERCOLOR = Color(red: 101/255, green: 101/255, blue: 105/255)
    
    static let GRADIENTFIRSTCOLOR = Color(red: 0/255, green: 221/255, blue: 255/255)
    
    
    static let PERSONTITLECOLOR = Color(red: 0/255, green: 108/255, blue: 124/255)
    
    
    
    static let BOTREPLYCOLOR = Color(red: 19/255, green: 19/255, blue: 19/255)
    static let BOTTITLECOLOR = Color(red: 148/255, green: 148/255, blue: 155/255)
    
    
    static let WATCHBTNCOLOR = Color(red: 72/255, green: 156/255, blue: 172/255)
    
    static let APPERANCEUNSELECTEDBGCOLOR = Color(red: 45/255, green: 45/255, blue: 52/255)
    
    
    //static let BLUECOLOR = Color(red: 0/255, green: 221/255, blue: 225/255)
    static let REDCOLOR = Color(red: 255/255, green: 69/255, blue: 58/255)
    static let YELLOWCOLOR = Color(red: 255/255, green: 213/255, blue: 11/255)
    static let GREENCOLOR = Color(red: 46/255, green: 209/255, blue: 88/255)
    static let PURPLECOLOR = Color(red: 125/255, green: 65/255, blue: 254/255)
    static let MINTCOLOR = Color(red: 99/255, green: 230/255, blue: 226/255)
    
    
    
    static let BOTTOMSHEETBGCOLOR = Color(red: 20/255, green: 20/255, blue: 21/255)
    
    
    static let BLUECOLOR = Color(red: 33/255, green: 202/255, blue: 245/255)
    
    
    static func getCurrentColor(_ colorIndex: Int)-> Color{
        return .BLUECOLOR
        
//        if colorIndex == 0{
//            return .BLUECOLOR
//        }else if colorIndex == 1{
//            return .REDCOLOR
//        }else if colorIndex == 2{
//            return .YELLOWCOLOR
//        }else if colorIndex == 3{
//            return .GREENCOLOR
//        }else if colorIndex == 4{
//            return .PURPLECOLOR
//        }else if colorIndex == 5{
//            return .MINTCOLOR
//        }else{
//            return .BLUECOLOR
//        }
    }

}



