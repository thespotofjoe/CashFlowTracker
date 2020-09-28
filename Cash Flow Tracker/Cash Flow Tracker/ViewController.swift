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
    
    @IBOutlet weak var moneyInTableView: UITableView!
    
    @IBOutlet weak var moneyInTextField: UITextField!
    
    @IBOutlet weak var moneyOutTableView: UITableView!
    
    @IBOutlet weak var moneyOutTextField: UITextField!
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    /* Our properties */
    var entries: [String:[Entry]] = ["expenses":[], "income":[]]
    let categories = ["Food", "Gas", "Gym", "Rent", "Utilities", "Subscriptions", "Toiletries and Cleaning Supplies", "Car Payments", "Car Insurance", "Other"]
    var selectedCategory = Category.Uncategorized
    
    // Computed properties
    var totalIncome: Float
    {
        var total = Float.zero
        for incomeEntry in entries["income"]!
        {
            total = total + incomeEntry
        }
        
        return total
    }
    
    var totalExpenses: Float
    {
        var total = Float.zero
        for incomeEntry in entries["expenses"]!
        {
            total = total + incomeEntry
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
        dateLabel.text = "\(dateTimeComponents.day!)  \(dateTimeComponents.month!), \(dateTimeComponents.year!)"
        
        // Setup connection to watch app
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    /* IBAction Functions */
    @IBAction func moneyInAddPressed(_ sender: Any)
    {
        let amountString = moneyInTextField.text!
        var amountFloat = Float(amountString)!
        
        // Make sure it's above 0, since this is income
        if amountFloat < 0 {amountFloat *= -1}
        
        entries["income"]!.append(Entry(amountFloat, category: selectedCategory))
    }
    
    @IBAction func moneyOutAddPressed(_ sender: Any)
    {
        let amountString = moneyInTextField.text!
        var amountFloat = Float(amountString)!
        
        // Make sure it's under 0, since this is an expense
        if amountFloat > 0 {amountFloat *= -1}
        
        entries["expenses"]!.append(Entry(amountFloat, category: selectedCategory))
    }
    
    /* Our Functions */
    func totalForCategory(_ category: Category) -> Float
    {
        var total = Float.zero
        for expense in entries["expenses"]!
        {
            if expense.category == category { total -= expense.amount }
        }
        
        return total
    }
    
}

extension ViewController: WCSessionDelegate, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        <#code#>
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
            // Will never get here, but the compiler doesn't know that
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
