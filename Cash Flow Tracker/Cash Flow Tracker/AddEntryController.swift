//
//  AddEntryController.swift
//  Daily Goal Tracker
//
//  Created by Joseph Buchoff on 10/3/20.
//  Copyright © 2020 Joe's Studio. All rights reserved.
//

import Foundation
import UIKit

class AddEntryController: UIViewController
{
    /* Outlets */
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var expenseOrIncome: UISegmentedControl!
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    /* Action functions */
    @IBAction func addPressed(_ sender: Any)
    {
        print("In addPressed()\nThere are \(entries.count) entries right now.")
        let amountString = amountTextField.text!
        let description = descriptionTextField.text!
        var isIncome = true
        
        // Read the segmented control and note whether this is an expense or income
        switch expenseOrIncome.selectedSegmentIndex
        {
        case 0:
            isIncome = true
        case 1:
            isIncome = false
        default:
            break
        }
        
        var amountFloat = Float(amountString)!
        
        // If it's income, make sure it's positive
        if isIncome
        {
            if amountFloat < 0 {amountFloat *= -1}
        } else {
            // Of if it's an expense, make sure it's negative
            if amountFloat > 0 {amountFloat *= -1}
        }
        
        entries.append(Entry(amountFloat, category: selectedCategory, description: description))
        print("Just appended a new entry. There are now \(entries.count) entries")
    }
}
