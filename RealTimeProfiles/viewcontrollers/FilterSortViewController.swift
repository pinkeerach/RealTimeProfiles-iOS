//
//  FilterSortViewController.swift
//  RealTimeProfiles
//
//  Created by Rachel Parsons on 9/1/18.
//  Copyright © 2018 Rachel Parsons. All rights reserved.
//

import UIKit

class FilterSortViewController: UIViewController {

    let sortData: [String] = ["Age - Ascending","Age - Descending","Name - Ascending","Name - Descending"]
    let filterData: [String] = ["Female","Male","Other"]

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FilterSortViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return filterData.count
        }
        
        return sortData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "filtersortcell") else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0: //filter
            cell.textLabel?.text = filterData[indexPath.row]
            break
        case 1:
            cell.textLabel?.text = sortData[indexPath.row]
            break
        default:
            break
        }
        
        return cell
    }
    

}
