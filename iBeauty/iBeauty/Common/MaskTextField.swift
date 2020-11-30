//
//  UITextField.swift
//  Superdigital
//
//  Created by Matheus Alves on 24/05/18.
//  Copyright © 2018 Matheus Alves. All rights reserved.
//

import Foundation
import UIKit

open class MaskTextField: UITextField {
    
    //**************************************************
    // MARK: - Properties
    //**************************************************
    
    public let lettersAndDigitsReplacementChar = "*"
    public let anyLetterReplecementChar = "@"
    public let lowerCaseLetterReplecementChar = "a"
    public let upperCaseLetterReplecementChar = "A"
    public let digitsReplecementChar = "#"
    
    /**
     Var that holds the format pattern that you wish to apply
     to some text
     
     If the pattern is set to "" no mask would be applied and
     the textfield would behave like a normal one
     */
    @IBInspectable open var formatPattern = ""
    
    /**
     Var that have the maximum length, based on the mask set
     */
    open var maxLength: Int {
        return formatPattern.count
    }
    
    /**
     Overriding the var text from UITextField so if any text
     is applied programmatically by calling formatText
     */
    override open var text: String? {
        set {
            super.text = newValue
            self.formatText()
        }
        
        get {
            return super.text
        }
    }
    
    //**************************************************
    // MARK: - Constructors
    //**************************************************
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    deinit {
        self.deRegisterForNotifications()
    }
    
    //**************************************************
    // MARK: - Private Methods
    //**************************************************
    
    fileprivate func setup() {
        registerForNotifications()
    }
    
    fileprivate func registerForNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange),
                                               name: NSNotification.Name(rawValue: "UITextFieldTextDidChangeNotification"),
                                               object: self)
    }
    
    fileprivate func deRegisterForNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func textDidChange() {
        undoManager?.removeAllActions()
        formatText()
    }
    
    fileprivate func getOnlyDigitsString(_ string: String) -> String {
        let charactersArray = string.components(separatedBy: CharacterSet.decimalDigits.inverted)
        return charactersArray.joined(separator: "")
    }
    
    fileprivate func getOnlyLettersString(_ string: String) -> String {
        let charactersArray = string.components(separatedBy: CharacterSet.letters.inverted)
        return charactersArray.joined(separator: "")
    }
    
    fileprivate func getUppercaseLettersString(_ string: String) -> String {
        let charactersArray = string.components(separatedBy: CharacterSet.uppercaseLetters.inverted)
        return charactersArray.joined(separator: "")
    }
    
    fileprivate func getLowercaseLettersString(_ string: String) -> String {
        let charactersArray = string.components(separatedBy: CharacterSet.lowercaseLetters.inverted)
        return charactersArray.joined(separator: "")
    }
    
    fileprivate func getFilteredString(_ string: String) -> String {
        let charactersArray = string.components(separatedBy: CharacterSet.alphanumerics.inverted)
        return charactersArray.joined(separator: "")
    }
    
    //**************************************************
    // MARK: - Self Public Methods
    //**************************************************
    
    /**
     Func that formats the text based on formatPattern
     
     Override this function if you want to customize the behaviour of
     the class
     */
    open func formatText() {
        var currentTextForFormatting = ""
        
        if let text = super.text {
            if text.count > 0 {
                currentTextForFormatting = text
            }
        }
        
        if self.maxLength > 0 {
            var formatterIndex = formatPattern.startIndex, currentTextForFormattingIndex = currentTextForFormatting.startIndex
            var finalText = ""
            
            currentTextForFormatting = getFilteredString(currentTextForFormatting)
            
            if currentTextForFormatting.count > 0 {
                while true {
                    let formatPatternRange = formatterIndex ..< formatPattern.index(after: formatterIndex)
                    let currentFormatCharacter = String(self.formatPattern[formatPatternRange])
                    
                    let currentTextForFormattingPatterRange = currentTextForFormattingIndex ..< currentTextForFormatting.index(after: currentTextForFormattingIndex)
                    let currentTextForFormattingCharacter = String(currentTextForFormatting[currentTextForFormattingPatterRange])
                    
                    switch currentFormatCharacter {
                    case self.lettersAndDigitsReplacementChar:
                        finalText += currentTextForFormattingCharacter
                        currentTextForFormattingIndex = currentTextForFormatting.index(after: currentTextForFormattingIndex)
                        formatterIndex = formatPattern.index(after: formatterIndex)
                    case self.anyLetterReplecementChar:
                        let filteredChar = self.getOnlyLettersString(currentTextForFormattingCharacter)
                        if !filteredChar.isEmpty {
                            finalText += filteredChar
                            formatterIndex = formatPattern.index(after: formatterIndex)
                        }
                        currentTextForFormattingIndex = currentTextForFormatting.index(after: currentTextForFormattingIndex)
                    case self.lowerCaseLetterReplecementChar:
                        let filteredChar = self.getLowercaseLettersString(currentTextForFormattingCharacter)
                        if !filteredChar.isEmpty {
                            finalText += filteredChar
                            formatterIndex = formatPattern.index(after: formatterIndex)
                        }
                        currentTextForFormattingIndex = currentTextForFormatting.index(after: currentTextForFormattingIndex)
                    case self.upperCaseLetterReplecementChar:
                        let filteredChar = self.getUppercaseLettersString(currentTextForFormattingCharacter)
                        if !filteredChar.isEmpty {
                            finalText += filteredChar
                            formatterIndex = formatPattern.index(after: formatterIndex)
                        }
                        currentTextForFormattingIndex = currentTextForFormatting.index(after: currentTextForFormattingIndex)
                    case self.digitsReplecementChar:
                        let filteredChar = self.getOnlyDigitsString(currentTextForFormattingCharacter)
                        if !filteredChar.isEmpty {
                            finalText += filteredChar
                            formatterIndex = formatPattern.index(after: formatterIndex)
                        }
                        currentTextForFormattingIndex = currentTextForFormatting.index(after: currentTextForFormattingIndex)
                    default:
                        finalText += currentFormatCharacter
                        formatterIndex = formatPattern.index(after: formatterIndex)
                    }
                    
                    if formatterIndex >= self.formatPattern.endIndex ||
                        currentTextForFormattingIndex >= currentTextForFormatting.endIndex {
                        break
                    }
                }
            }
            super.text = finalText
            
            if let text = self.text {
                if text.count > self.maxLength {
                    super.text = String(text[text.index(text.startIndex, offsetBy: self.maxLength)])
                }
            }
        }
    }
}
