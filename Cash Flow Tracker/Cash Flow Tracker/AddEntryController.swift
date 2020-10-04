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
    /* Our Properties */
    var entries: [Entry] = []
    let categories = ["Food", "Gas", "Gym", "Rent", "Utilities", "Subscriptions", "Toiletries and Cleaning Supplies", "Car Payments", "Car Insurance", "Other"]
    var selectedCategory = Category.Uncategorized
    
    /* Outlets */
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var expenseOrIncome: UISegmentedControl!
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    /* Overridden System Functions */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        
        /*// Setup connection to watch app
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }*/
    }
    
    /* IBAction Functions */
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

extension AddEntryController: /*WCSessionDelegate,*/ UIPickerViewDelegate, UIPickerViewDataSource
{
    /* Protocol functions */
    /*// WCSessionDelegate functions
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?)
    {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession)
    {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession)
    {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Swift.Void)
    {
        print("Received request from Watch. Trying to send dictionary back to Watch.")
        let returnMessage: [String : Any] = ["cashflow" : cashFlow as Any]
        
        // Send it over to the Apple Watch
        replyHandler(returnMessage)
        
        print("Successfully replied to Watch.")
    }*/
    
    // UIPickerViewDelegate functions
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch row
        {
        case 0:
            selectedCategory = .Food
        case 1:
            selectedCategory = .Gas
        case 2:
            selectedCategory = .Gym
        case 3:
            selectedCategory = .Rent
        case 4:
            selectedCategory = .Utilities
        case 5:
            selectedCategory = .Subscriptions
        case 6:
            selectedCategory = .Toiletries_and_Cleaning_Supplies
        case 7:
            selectedCategory = .Car_Payments
        case 8:
            selectedCategory = .Car_Insurance
        case 9:
            selectedCategory = .Other
        default:
            // We'll never get here, but the compiler doesn't know that
            return
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return categories[row]
    }
    
    // UIPickerViewDataSource functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return categories.count
    }
}

