//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Seng Hwwa on 27/12/2018.
//  Copyright © 2018 senghwabeh. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {
  
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
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
          emojiGrouping[indexPath.section].emojis.remove(at: indexPath.row)
          tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//        let movedEmoji = emojis.remove(at: fromIndexPath.row)
//        emojis.insert(movedEmoji, at: to.row)

        print("Section is \(fromIndexPath.section). From row is \(fromIndexPath.row). To row is \(to.section):\(to.row)")
        
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
        if segue.identifier == "EditEmoji" {
            let indexPath = tableView.indexPathForSelectedRow!
            let groupName = emojiGrouping[indexPath.section].groupName
            let emoji = emojiGrouping[indexPath.section].emojis[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let addEditEmojiTableViewController = navController.topViewController as! AddEditEmojiTableViewController
            
            addEditEmojiTableViewController.emoji = emoji
            addEditEmojiTableViewController.groupName = groupName
            
        }
    }
   
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        
        guard segue.identifier == "saveUnwind" else {return}
        let sourceViewController = segue.source as! AddEditEmojiTableViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            
        } else {
            
        }
    
    }
    
}
