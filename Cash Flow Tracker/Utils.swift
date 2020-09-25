//
//  Utils.swift
//  Cash Flow Tracker
//
//  Created by Joseph Buchoff on 9/24/20.
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
    // String holding dollar sign in front of the amount with 2 decimal places, if it's an expense, put a negative sign in front of it and negate the negative in the amount
    var amountString: String { return (entryType == .Expense) ? "-$\(String(format: "%.2f", -amount))" : "$\(String(format: "%.2f", amount))" }
    
    // Is this an expense or income?
    var entryType: EntryType
    
    // Full initializer
    init (_ amount: Float)
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
    
    static func + (lhs: Entry, rhs: Entry) -> Float
    {
        return lhs.amount + rhs.amount
    }
    
    static func + (lhs: Entry, rhs: Float) -> Float
    {
        return lhs.amount + rhs
    }
    
    static func + (lhs: Float, rhs: Entry) -> Float
    {
        return lhs + rhs.amount
    }
}
