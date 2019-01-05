//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Seng Hwwa on 27/12/2018.
//  Copyright © 2018 senghwabeh. All rights reserved.
//

import Foundation

struct Emoji: Codable{
    var symbol: String
    var name: String
    var description: String
    var usage: String
}

struct OldEmojiGrouping: Codable {
    var groupName: String
    var emojis: [Emoji]
}

struct EmojiGrouping: Codable {
    var groupName: String
    var emojis: [Emoji]
    
    static let DocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentDirectory.appendingPathComponent("emojiGrouping").appendingPathExtension("plist")
    static func loadFromFile() -> [EmojiGrouping]? {
        guard let codedEmojiGrouping = try? Data(contentsOf: ArchiveURL) else {return nil}
        let decoder = PropertyListDecoder()
        return try? decoder.decode(Array<EmojiGrouping>.self, from: codedEmojiGrouping)
    }
    static func saveToFile(emojiGrouping: [EmojiGrouping]) {
        let encoder = PropertyListEncoder()
        let codedEmojiGrouping = try? encoder.encode(emojiGrouping)
        try? codedEmojiGrouping?.write(to: ArchiveURL, options: .noFileProtection)
        
    }
}

var emojiGroupNames = ["Smileys & People","Animals & Nature","Food & Drink","Activity","Travel & Places","Objects","Symbols","Flags"]

var emojiGrouping: [EmojiGrouping] = []

var emojis = [Emoji]()


func loadEmojiData() {
    emojis.append(Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"))
    emojis.append(Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"))
    emojis.append(Emoji(symbol: "😍", name: "Heart Eyes",description: "A smiley face with hearts for eyes.", usage: "love of something; attractive"))
    emojis.append(Emoji(symbol: "👮", name: "Police Officer", description: "A police officer wearing a blue cap with a gold badge.", usage: "person of authority"))
    emojiGrouping.append(EmojiGrouping(groupName: "Smileys & People", emojis: emojis))
    
    emojis.removeAll()
    emojis.append(Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "Something slow"))
    emojis.append(Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant.", usage: "good memory"))
    emojiGrouping.append(EmojiGrouping(groupName: "Animals & Nature", emojis: emojis))
    
    emojis.removeAll()
    emojis.append(Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti.", usage: "spaghetti"))
    emojiGrouping.append(EmojiGrouping(groupName: "Food & Drink", emojis: emojis))
    
    emojis.removeAll()
    emojis.append(Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"))
    emojis.append(Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"))
    emojiGrouping.append(EmojiGrouping(groupName: "Activity", emojis: emojis))
    
    emojis.removeAll()
    emojis.append(Emoji(symbol: "📚", name: "Stack of Books", description: "Three colored books stacked on each other.", usage: "homework, studying"))
    emojiGrouping.append(EmojiGrouping(groupName: "Objects", emojis: emojis))

    emojis.removeAll()
    emojis.append(Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"))
    emojis.append(Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"))
    emojiGrouping.append(EmojiGrouping(groupName: "Symbols", emojis: emojis))

    emojis.removeAll()
    emojis.append(Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage: "completion"))
    emojiGrouping.append(EmojiGrouping(groupName: "Flags", emojis: emojis))
}



