//
//  CurrentEarningsController.swift
//  Gig Counter WatchKit Extension
//
//  Created by Joe on 8/19/20.
//  Copyright © 2020 Joe's Studio. All rights reserved.
//

import WatchKit
import Foundation

class CurrentEarningsController: WKInterfaceController {

    @IBOutlet weak var currentEarningsLabel: WKInterfaceLabel!
    
    var goal = 100
    var current = 0
    var data = ["goal": 100,
                "current": 0]
    
    /* Local utility functions */
    // Changes current by a value, then updates the label to reflect that change
    func updateCurrent(_ change : Int) -> Void
    {
        // Make the change
        self.current += change
        
        // Make sure 0 is the lowest it can be
        if (current < 0) { current = 0 }
        
        // Update dictionary to reflect the change
        self.data["goal"] = goal
        self.data["current"] = current
        
        // Reload interfaces to update data throughout the app
        WKInterfaceController.reloadRootPageControllers(withNames : ["SetGoalController", "CurrentEarningsController", "EarningsLeftController"], contexts : [data, data, data], orientation : WKPageOrientation.horizontal, pageIndex: 1)
    }
    
    /* Integral system functions, overridden */
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Unpack the dictionary passed from previous interface controller,
        // but if this is the beginning of the program, do nothing.
        if let dataAsAny = context
        {
            self.data = dataAsAny as! [String : Int]
            self.goal = data["goal"]!
            self.current = data["current"]!
            
            // Update the label to reflect the data passed
            currentEarningsLabel.setText("$\(self.current)")
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    /* Button Press functions */
    @IBAction func plus10Pressed()
    {
        updateCurrent(10)
    }
    
    @IBAction func minus10Pressed()
    {
        updateCurrent(-10)
    }
    
    @IBAction func plus5Pressed()
    {
        updateCurrent(5)
    }
    
    @IBAction func minus5Pressed()
    {
        updateCurrent(-5)
    }
    
    @IBAction func plus1Pressed()
    {
        updateCurrent(1)
    }
    
    @IBAction func minus1Pressed()
    {
        updateCurrent(-1)
    }

}
