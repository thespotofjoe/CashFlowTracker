//
//  Utils.swift
//  Daily Goal Tracker WatchKit Extension
//
//  Created by Joseph Buchoff on 9/4/20.
//  Copyright © 2020 Joe's Studio. All rights reserved.
//

import Foundation

enum EntryType
{
    case Income
    case Expense
}

class Entry
{
    /* Properties */
    // $$$ amount in this Entry
    var amount: Float
    // String holding dollar sign in front of the amount with 2 decimal places
    var amountString: String { return "$\(String(format: "%.2f", amount))" }
    
    // Is this an expense or income?
    var entryType: EntryType
    
    // Full initializer
    init (amount: Float)
    {
        // Set self.amount to passed value
        self.amount = amount
        
        // Set whether this is an expense or income
        if self.amount < 0
        {
            self.entryType = .Expense
        } else {
            self.entryType = .Income
        }
    }
}
