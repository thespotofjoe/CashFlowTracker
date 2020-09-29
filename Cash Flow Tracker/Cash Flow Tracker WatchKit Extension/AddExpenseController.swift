//
//  AddExpenseController.swift
//  Daily Goal Tracker WatchKit Extension
//
//  Created by Joseph Buchoff on 9/16/20.
//  Copyright © 2020 Joe's Studio. All rights reserved.
//

import WatchKit
import Foundation

class AddExpenseController: WKInterfaceController
{

    // Label outlet
    @IBOutlet weak var amountLabel: WKInterfaceLabel!
    
    var amount = 0
    
    /* Local utility functions */
    // Changes goal by a value, then updates the label to reflect the change
    @IBAction func addEntry()
    {
        let entry = makeEntry()
        reset()
        // Pass it to iPhone program
        // Get info back from iPhone program
        // Use info to update variables
        // Reload hierarchy
    }
    
    // Resets local amount and label to $0.00
    func reset()
    {
        amount = 0
        amountLabel.setText("-$0")
    }
    
    // Updates local amount with change, subtracting it since it's the expenses screen
    func updateAmount(_ change: Int)
    {
        // Make change.
        amount -= change
        
        // Make sure this is below 0. We're on the income screen right now, not the expense screen.
        if amount > 0 { amount = 0 }
        
        // Update the label to reflect change for the user.
        amountLabel.setText("-$\(-amount)")
    }
    
    // Creates and spits back an Entry from the local amount
    func makeEntry() -> Entry { return Entry(Float(amount), category: .Uncategorized, description: "") }
    
    /* Integral system functions, overridden */
    override func awake(withContext context: Any?)
    {
        super.awake(withContext: context)
    }
    
    @IBAction func plus10Pressed()
    {
        updateAmount(10)
    }
    
    @IBAction func minus10Pressed()
    {
        updateAmount(-10)
    }
    
    @IBAction func plus5Pressed()
    {
        updateAmount(5)
    }
    
    @IBAction func minus5Pressed()
    {
        updateAmount(-5)
    }
    
    @IBAction func plus1Pressed()
    {
        updateAmount(1)
    }
    
    @IBAction func minus1Pressed()
    {
        updateAmount(-1)
    }

}
