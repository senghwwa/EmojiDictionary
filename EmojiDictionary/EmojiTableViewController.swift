//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Seng Hwwa on 27/12/2018.
//  Copyright © 2018 senghwabeh. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    var editModeSelected = false
    var selectedSection = 0
    var selectedRow = 0
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEmojiData()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return emojiGrouping.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiGrouping[section].emojis.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell
        let emojiGroup = emojiGrouping[indexPath.section]
        let emoji = emojiGroup.emojis[indexPath.row]
        cell.update(with: emoji)
        cell.showsReorderControl = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return emojiGrouping[section].groupName
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojiGrouping[indexPath.section].emojis.remove(at: indexPath.row)
            if emojiGrouping[indexPath.section].emojis.count == 0 {
                if emojiGrouping.count > 0 {
                    emojiGrouping.remove(at: indexPath.section)
                }
            }
            tableView.reloadData()
        }
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        if fromIndexPath.section == to.section {
            let movedEmoji = emojiGrouping[fromIndexPath.section].emojis.remove(at: fromIndexPath.row)
            emojiGrouping[fromIndexPath.section].emojis.insert(movedEmoji, at: to.row)
        }
        tableView.reloadData()
    }
    
    // To remove the Delete indicator
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }

    // Check if editing mode is selected for the table and disable the add button
    // note the need to enable and disable editing as we have overriddden the standard function
    override func setEditing(_ editing: Bool, animated: Bool) {
        if editing {
            super.setEditing(true, animated: true)
            addButton.isEnabled = false
        } else {
            super.setEditing(false, animated: true)
            addButton.isEnabled = true
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let addEditEmojiTableViewController = navController.topViewController as! AddEditEmojiTableViewController
        addEditEmojiTableViewController.emojiGrouping = emojiGrouping
        if segue.identifier == "EditEmoji" {
            editModeSelected = true
            let indexPath = tableView.indexPathForSelectedRow!
            selectedSection = indexPath.section
            selectedRow = indexPath.row
            let groupName = emojiGrouping[indexPath.section].groupName
            let emoji = emojiGrouping[indexPath.section].emojis[indexPath.row]
            addEditEmojiTableViewController.emoji = emoji
            addEditEmojiTableViewController.groupName = groupName
            addEditEmojiTableViewController.editModeSelected = true
        } else {
            editModeSelected = false
        }
        
    }
   
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        var i = 0
        var groupNameIndex = -1
        
        guard segue.identifier == "saveUnwind" else {return}
        let sourceViewController = segue.source as! AddEditEmojiTableViewController
        if editModeSelected {
            emojiGrouping[selectedSection].emojis[selectedRow] = sourceViewController.emoji
        } else {
            let pickedGroupName = sourceViewController.pickedGroupName
            let returnedEmojis = sourceViewController.emojis
            while i < emojiGrouping.count {
                if pickedGroupName == emojiGrouping[i].groupName {
                    groupNameIndex = i
                    break
                }
                i += 1
            }
            if groupNameIndex != -1 {
                var currentEmojis = emojiGrouping[groupNameIndex].emojis
                currentEmojis += returnedEmojis
                emojiGrouping[groupNameIndex].emojis = currentEmojis
            } else {
                emojiGrouping.append(EmojiGrouping(groupName: pickedGroupName, emojis: returnedEmojis))
            }
            tableView.reloadData()
        }
    }
    
}
