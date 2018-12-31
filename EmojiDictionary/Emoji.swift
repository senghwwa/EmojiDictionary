//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Seng Hwwa on 27/12/2018.
//  Copyright © 2018 senghwabeh. All rights reserved.
//

import Foundation

class Emoji {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    init(symbol: String, name: String, description: String, usage: String) {
    self.symbol = symbol
    self.name = name
    self.description = description
    self.usage = usage
     }
    
}

struct EmojiGrouping {
    var groupName: String
    var emojis: [Emoji]
}

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



