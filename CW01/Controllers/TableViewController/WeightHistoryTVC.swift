//
//  WeightHistoryTVC.swift
//  CW01
//
//  Created by Aravinthan Sathasivam on 3/17/21.
//

import UIKit

class WeightHistoryTVC: UITableViewController {
    var history : [String]  = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initWeightInfo()

    }
    func initWeightInfo(){
        loadDefaultData("weightHistory")
    }


    func loadDefaultData(_ historyKey: String) {
        let defaults = UserDefaults.standard
        history = defaults.object(forKey: historyKey) as? [String] ?? [String]()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weightCell")!
        cell.textLabel?.textAlignment = .center
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = history[indexPath.row]
        return cell
    }

}
