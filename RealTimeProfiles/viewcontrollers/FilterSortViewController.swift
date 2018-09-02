//
//  FilterSortViewController.swift
//  RealTimeProfiles
//
//  Created by Rachel Parsons on 9/1/18.
//  Copyright © 2018 Rachel Parsons. All rights reserved.
//

import UIKit

protocol FilterSortViewDelegate {
    func sortSelectionMade(_ sortSelection: String)
    func filterSelectionMade(_ filterSelection: String)
}

class FilterSortViewController: UIViewController {

    var delegate: FilterSortViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelButtonTapped() {
        dismiss(animated: true) {}
    }

}

extension FilterSortViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Filter By:"
        }
        
        return "Sort By:"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return Constants.filterData.count
        }
        
        return Constants.sortData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "filtersortcell") else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0: //filter
            cell.textLabel?.text = Constants.filterData[indexPath.row]
            break
        case 1:
            cell.textLabel?.text = Constants.sortData[indexPath.row]
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let delegate = self.delegate else {
            return
        }
        
        if indexPath.section == 0 {
            delegate.filterSelectionMade(Constants.filterData[indexPath.row])
        }
        
        delegate.sortSelectionMade(Constants.sortData[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        dismiss(animated: true, completion: nil)
    }
}
