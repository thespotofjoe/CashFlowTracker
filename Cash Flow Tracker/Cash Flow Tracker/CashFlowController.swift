//
//  CashFlowController.swift
//  Daily Goal Tracker
//
//  Created by Joseph Buchoff on 10/3/20.
//  Copyright © 2020 Joe's Studio. All rights reserved.
//

import Foundation
import UIKit

class CashFlowController: UIViewController
{
    /* Outlets */
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    /* Overridden System Functions */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
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
    }
}
