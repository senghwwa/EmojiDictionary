//
//  AddEditEmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Seng Hwwa on 31/12/2018.
//  Copyright © 2018 senghwabeh. All rights reserved.
//

import UIKit

class AddEditEmojiTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var groupNamePicker: UIPickerView!
    @IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var usageTextField: UITextField!
    @IBOutlet weak var saveButtonTapped: UIBarButtonItem!
    
    var emojiGrouping: [EmojiGrouping] = []
    var emojis = [Emoji]()
    var emoji = Emoji(symbol: "", name: "", description: "", usage: "")
    var groupName = ""
    var pickedGroupName = ""
    var pickedRow: Int = -1
    var editModeSelected = false
    var emojiInDictionary = true

    var groupNameExists = false
    
    //var matchingEmojiAndGroup = false
    //var editedGroupIndex = -1
    //var editedEmojiIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.groupNamePicker.dataSource = self
        self.groupNamePicker.delegate = self
        
        if let row = emojiGroupNames.index(of: groupName) {
            groupNamePicker.selectRow(row, inComponent: 0, animated: false)
        } else {
            groupNamePicker.selectRow(0, inComponent: 0, animated: false)

        }
        
        if editModeSelected {
            groupNamePicker.isUserInteractionEnabled = false
            symbolTextField.isEnabled = false
        } else {
            groupNamePicker.isUserInteractionEnabled = true
            symbolTextField.isEnabled = true
            saveButtonTapped.isEnabled = false
        }
        
        symbolTextField.text = emoji.symbol
        nameTextfield.text = emoji.name
        descriptionTextField.text = emoji.description
        usageTextField.text = emoji.usage
        updateSaveButtonState(tag: 0)
        
     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return emojiGroupNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //print("\(emojiGroupNames[row]) displayed")
        pickedGroupName = emojiGroupNames[row]
        return pickedGroupName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        UserDefaults.standard.set(groupNames[row], forKey: "selectedRow")
        //print("Row \(row) selected")
        pickedRow = row
    }
    
    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
     */
    
    /*
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
     */
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

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
        
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else {return}
        
        let symbol = symbolTextField.text ?? ""
        let name = nameTextfield.text ?? ""
        let description = descriptionTextField.text ?? ""
        let usage = usageTextField.text ?? ""

        emoji = Emoji(symbol: symbol, name: name, description: description, usage: usage)
        
        
    }

    func updateSaveButtonState(tag: Int) {
        let groupNameText = pickedGroupName
        let symbolText = symbolTextField.text ?? ""
        let nameText = nameTextfield.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let usageText = usageTextField.text ?? ""
        
        // Attribute for symbol field changed to give tag value of 1
        if tag == 1 {
            print("Tag = 1")
            // Make sure emoji being added does not already exist
            if !editModeSelected {
                
                emojiInDictionary = false
                
                for emojiGroupingIndex in emojiGrouping {
                    
                    if emojiGroupingIndex.groupName == pickedGroupName {
                        groupNameExists = true
                        
                    }
                    for emojiIndex in emojiGroupingIndex.emojis {
                        
                        if emojiIndex.symbol == symbolText {
                            
                            emojiInDictionary = true
                            print("Emoji already in dictionary")
                            break
                            
                        }
                    }
                }
            }
        }
        
        if !editModeSelected {
            
        saveButtonTapped.isEnabled = !groupNameText.isEmpty && !symbolText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty && !usageText.isEmpty && !emojiInDictionary
            
        } else {
            
            saveButtonTapped.isEnabled = !nameText.isEmpty && !descriptionText.isEmpty && !usageText.isEmpty
            
        }

    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
       updateSaveButtonState(tag: sender.tag)
    }
}
