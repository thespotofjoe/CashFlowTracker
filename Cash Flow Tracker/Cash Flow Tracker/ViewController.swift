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
    
    /* Our Variables */
    var totalIncome = 0
    var totalExpenses = 0
    var cashFlow: Int { return totalIncome - totalExpenses }
    
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
        
    }
    
    @IBAction func moneyOutAddPressed(_ sender: Any)
    {
        
    }
    
}

extension ViewController: WCSessionDelegate, UITableViewDelegate, UITableViewDataSource
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
}
