//
//  CashFlowController.swift
//  Daily Goal Tracker WatchKit Extension
//
//  Created by Joseph Buchoff on 9/18/20.
//  Copyright © 2020 Joe's Studio. All rights reserved.
//

import WatchKit
import Foundation

class CashFlowController: WKInterfaceController
{
    /* IBOutlets for labels */
    @IBOutlet weak var dateLabel: WKInterfaceLabel!
    
    @IBOutlet weak var cashFlowLabel: WKInterfaceLabel!
    
    /* Useful variables */
    var cashFlow = 0
    
    /* Integral system functions, overridden */
    // Gets cashFlow from phone app, updates label to reflect current CashFlow
    // Also updates date and dateLabel
    override func willActivate()
    {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        // Update Date Label
        // Get right now's epochtime
        let epochTime = Date()
        
        // Get the user's calendar preferences
        let userCalendar = Calendar.current
        
        // Specify which components we want
        let requestedComponents: Set<Calendar.Component> = [.year,
            .month,
            .day]
        
        // Extract the components from epochtime
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: epochTime)
        
        // Set the text of the label to extracted date
        dateLabel.setText("\(dateTimeComponents.day!)  \(dateTimeComponents.month!), \(dateTimeComponents.year!)")
        
        // Get cashFlow from phone app
        // Set label to the current cashFlow
    }
}
