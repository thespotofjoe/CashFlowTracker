//
//  Utils.swift
//  Cash Flow Tracker
//
//  Created by Joseph Buchoff on 9/24/20.
//  Copyright © 2020 Joe's Studio. All rights reserved.
//

import Foundation

enum Category
{
    case Food
    case Gas
    case Gym
    case Rent
    case Utilities
    case Subscriptions
    case Toiletries_and_Cleaning_Supplies
    case Car_Payments
    case Car_Insurance
    case Other
    case Uncategorized
    
    static func asString(_ category: Category) -> String
    {
        switch category
        {
        case Food:
            return "Food"

        case Gas:
            return "Gas"
            
        case Gym:
            return "Gas"
            
        case Rent:
            return "Rent"
            
        case Utilities:
            return "Utilities"
            
        case Subscriptions:
            return "Subscriptions"
            
        case Toiletries_and_Cleaning_Supplies:
            return "Toiletries and Cleaning Supplies"
            
        case Car_Payments:
            return "Car Payments"
            
        case Car_Insurance:
            return "Car Insurance"
            
        case Other:
            return "Other"
            
        case Uncategorized:
            return "Uncategorized"
        }
    }
}

class Budget
{
    /* Instance Properties */
    // $$$ amount in this Budget
    var amount: Float
    
    // $$$ amount already spent towards this budget
    var currAmount = Float.zero
    
    // What category?
    var category: Category
    
    /* Calculated Properties */
    var amountLeft: Float { return amount - currAmount }
    
    // Full initializer with 0 spend so far
    init (_ amount: Float, category: Category)
    {
        // Set self.amount to passed value
        self.amount = amount
        
        // Set what budget category
        self.category = category
    }
    
    // Full initializer with nonzero spend
    init (_ amount: Float, currAmount: Float, category: Category)
    {
        // Set self.amount to passed value
        self.amount = amount
        
        // Set current amount to passed value
        self.currAmount = currAmount
        
        // Set what budget category
        self.category = category
    }
    
    // Full initializer with nonzero spend, array of Entries
    init (_ amount: Float, entries: [Entry], category: Category)
    {
        // Set self.amount to passed value
        self.amount = amount
        
        // Calculate current amount spent in this budget
        for entry in entries
        {
            // These will be expenses, so subtract the negative to add it to currAmount
            currAmount -= entry.amount
        }
        
        // Set what budget category
        self.category = category
    }
    
    // Add to spend
    func addSpend (_ newSpend: Float)
    {
        currAmount += newSpend
    }
    
    // Calculate new spend from an array of entries
    func addSpend (_ entries: [Entry])
    {
        for entry in entries
        {
            // These will be expenses, so subtract the negative to add it to currAmount
            currAmount -= entry.amount
        }
    }
    
    // Calculate base spend from an array of entries
    func calcSpend (_ entries: [Entry])
    {
        // Reset currAmount
        currAmount = Float.zero
        
        // Calculate total spend in this budget
        for entry in entries
        {
            // These will be expenses, so subtract the negative to add it to currAmount
            currAmount -= entry.amount
        }
    }
}

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
    var amountString: String { return (type == .Expense) ? "-$\(String(format: "%.2f", -amount))" : "$\(String(format: "%.2f", amount))" }
    
    // Is this an expense or income?
    var type: EntryType
    
    // Category
    var category: Category
    
    // Description
    var description: String
    
    /* Initializers */
    // Full initializer
    init (_ amount: Float, category: Category, description: String)
    {
        // Set self.amount to passed value
        self.amount = amount
        
        self.description = description
        
        // Set whether this is an expense or income
        if self.amount < 0
        {
            self.type = .Expense
        } else {
            self.type = .Income
        }
    }
    
    /* Our Functions */
    func changeCategory(to newCategory: Category)
    {
        self.category = newCategory
    }
    
    /* Operrator overrides */
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
