//
//  ViewController.swift
//  Daily Goal Tracker
//
//  Created by Joseph Buchoff on 9/4/20.
//  Copyright © 2020 Joe's Studio. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController
{
    /* Outlets */
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var entryTableView: UITableView!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var expenseOrIncome: UISegmentedControl!
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    /* Our properties */
    var entries: [Entry] = []
    let categories = ["Food", "Gas", "Gym", "Rent", "Utilities", "Subscriptions", "Toiletries and Cleaning Supplies", "Car Payments", "Car Insurance", "Other"]
    var selectedCategory = Category.Uncategorized
    
    // Computed properties
    var totalIncome: Float
    {
        var total = Float.zero
        for entry in entries
        {
            if entry.type == .Income
            {
                total = total + entry
            }
        }
        
        return total
    }
    
    var totalExpenses: Float
    {
        var total = Float.zero
        for entry in entries
        {
            if entry.type == .Expense
            {
                total = total + entry
            }
        }
        
        return total
    }
    
    var cashFlow: Float { return totalIncome - totalExpenses }
    
    
    
    /* Overridden System Functions */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        /* Do any additional setup after loading the view. */
        // Update Date Label
        // Get right now's epochtime
        let todaysDate = Date()
        
        // Get the user's calendar preferences
        let userCalendar = Calendar.current
        
        // Specify which components we want
        let requestedComponents: Set<Calendar.Component> = [.year,
            .month,
            .day]
        
        // Extract the components from epochtime
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: todaysDate)
        
        // Set the text of the label to extracted date
        dateLabel.text = "\(dateTimeComponents.month!)/\(dateTimeComponents.day!)/\(dateTimeComponents.year!)"
        
        // Setup connection to watch app
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    /* IBAction Functions */
    @IBAction func addPressed(_ sender: Any)
    {
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
    }
    
    /* Our Functions */
    func totalForCategory(_ category: Category) -> Float
    {
        var total = Float.zero
        for entry in entries
        {
            if entry.category == category { total -= entry.amount }
        }
        
        return total
    }
    
}

extension ViewController: WCSessionDelegate, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! EntryCell

        let entry = entries[indexPath.row]
        cell.descriptionLabel?.text     = entry.description
        cell.amountLabel?.text          = entry.amountString
        cell.categoryLabel?.text        = Category.asString(entry.category)

        return cell
    }
    
    /* Protocol functions */
    // WCSessionDelegate functions
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
    }
    
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
