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
        //return 1
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
 
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let emoji = emojis[indexPath.row]

        let emojiGroup = emojiGrouping[indexPath.section]
        let emoji = emojiGroup.emojis[indexPath.row]
        
        print("\(emoji.symbol) \(indexPath)")
    }
    */
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
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
 //       return .none
        return .delete
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    /*
        if segue.identifier == "EditEmoji" {
            
            editModeSelected = true
            
            let indexPath = tableView.indexPathForSelectedRow!
            let groupName = emojiGrouping[indexPath.section].groupName
            let emoji = emojiGrouping[indexPath.section].emojis[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let addEditEmojiTableViewController = navController.topViewController as! AddEditEmojiTableViewController
            
            addEditEmojiTableViewController.emoji = emoji
            addEditEmojiTableViewController.groupName = groupName
            addEditEmojiTableViewController.emojiGrouping = emojiGrouping
            print("Source grouping count is \(emojiGrouping.count)")
            addEditEmojiTableViewController.editModeSelected = true
            
            //addEditEmojiTableViewController.editedGroupIndex = indexPath.section
            //addEditEmojiTableViewController.editedEmojiIndex = indexPath.row
            
        } else {
            
            editModeSelected = false

        }
 */
        
        let navController = segue.destination as! UINavigationController
        let addEditEmojiTableViewController = navController.topViewController as! AddEditEmojiTableViewController
        addEditEmojiTableViewController.emojiGrouping = emojiGrouping

        if segue.identifier == "EditEmoji" {
            
            editModeSelected = true
            
            let indexPath = tableView.indexPathForSelectedRow!
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
        
        guard segue.identifier == "saveUnwind" else {return}
        
        print("Edit mode selected is \(editModeSelected)")
        
        //let sourceViewController = segue.source as! AddEditEmojiTableViewController
        
        //let selectedSection = tableView.indexPathForSelectedRow?.section ?? -1
        //let selectedRow = tableView.indexPathForSelectedRow?.row ?? -1
        
        
        //        if originatingGroupName == sourceViewController.pickedGroupName {
//            // then just update the emoji
//            emojiGrouping[selectedSection].emojis[selectedRow] = sourceViewController.emoji
//        }
//        else {
//            // first check if picked group exists in array
//            // if it does then remove current emoji and remove the original group if required
//            // then insert emoji into the picked group
//            // then check if the emoji does not exist in target
//            // remove the current emoji in the group and remove the group if required
//            // insert the
//
//        }
        
//
//        if let row = emojiGroupNames.index(of: sourceViewController.pickedGroupName) {
//
//        } else {
//
//        }
        
//        if let selectedIndexPath = tableView.indexPathForSelectedRow {
//
//        } else {
//
//        }
        
    }
    
}
