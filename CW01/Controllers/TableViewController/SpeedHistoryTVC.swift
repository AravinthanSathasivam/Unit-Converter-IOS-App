//
//  SpeedHistoryTVC.swift
//  CW01
//
//  Created by Aravinthan Sathasivam on 3/17/21.
//

import UIKit

class SpeedHistoryTVC: UITableViewController {
    var history : [String]  = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        initSpeedInfo()

    }
    
    func initSpeedInfo(){
        loadDefaultData("SpeedHistory")
    }
    
    func loadDefaultData(_ historyKey: String) {
        let defaults = UserDefaults.standard
        history = defaults.object(forKey: historyKey) as? [String] ?? [String]()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "speedCell")!
        cell.textLabel?.textAlignment = .center
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = history[indexPath.row]
        return cell
    }


}
