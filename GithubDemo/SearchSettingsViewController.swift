//
//  SearchSettingsViewController.swift
//  GithubDemo
//
//  Created by Siraj Zaneer on 2/10/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit
protocol SwitchCellDelegate: class {
    func didSwitch()
}

class SearchSettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: SettingsPresentingViewControllerDelegate?
    var settings: GithubRepoSearchSettings!
    var filterCount = 1
    var languages = ["Java", "Javascript", "Swift", "C", "Python", "Objective-C"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onStars(_ sender: Any) {
        print("hi")
        let slider = sender as! UISlider
        let multiply: Float = 10000.0
        settings.minStars = Int(slider.value.multiplied(by: multiply))
        let cell = slider.superview!.superview as! SliderCell
        cell.starLabel.text = "\(settings.minStars)"
    }
    
    
    @IBAction func onSave(_ sender: Any) {
        self.delegate?.didSaveSettings(settings: settings)
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func onCancel(_ sender: Any) {
        self.delegate?.didCancelSettings()
        self.dismiss(animated: true, completion: nil)
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

extension SearchSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return filterCount
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if indexPath.section == 0 {
            let starCell = tableView.dequeueReusableCell(withIdentifier: "StarCell") as! SliderCell
            return starCell
        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                var filterCell = tableView.dequeueReusableCell(withIdentifier: "FilterCell")! as! SwitchCell
                filterCell.delegate = self
                return filterCell
            default:
                cell = UITableViewCell()
            }
            
            if (indexPath.row > 0 && indexPath.row < languages.count + 1) {
                cell.textLabel?.text = languages[indexPath.row - 1]
            }
            
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 && indexPath.row > 0 {
            let cell = tableView.cellForRow(at: indexPath)
            if cell?.accessoryType == .checkmark {
                cell?.accessoryType = .none
            } else {
                cell?.accessoryType = .checkmark
            }
        }
    }
}

extension SearchSettingsViewController: SwitchCellDelegate {
    func didSwitch() {
        if filterCount == 1 {
            filterCount = 7
        } else {
            filterCount = 1
        }
        tableView.reloadData()
    }
}
