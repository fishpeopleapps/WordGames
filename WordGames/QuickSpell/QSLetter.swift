//
//  QSLetter.swift
//  WordGames
//
//  Created by Kimberly Brewer on 8/1/23.
//
// TODO: Separate out the string into individual somethings that represent each character
// so we can know how many times a character appears and adjust it as desired, is UGLY right now

import Foundation
/// Stores one letter, we must have a unique ID behind it that's stable
/// and won't change (Identifiable), it must be (Hashable) so we can utilize
/// it in dict and sets as keys if needed
struct Letter: Hashable, Identifiable {
    let id = UUID()
    var character: String
    init() {
        /// Pick a random character from our string
        character = String("""
                           EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE\
                           EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEETT\
                           TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT\
                           TTTTTTTTTTTTTTTTTTTTTTTTTTAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\
                           AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAOOOOOOOOOOOOOOOOOOOOOOOO\
                           OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOIIIIIIIIIIIII\
                           IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIINN\
                           NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN\
                           NNNNNSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS\
                           SSSSSRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR\
                           RRRHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHLLLLLLLLLLLL\
                           LLLLLLLLLLLLLLLLLLLLLLLLLLLLLDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD\
                           DDCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCUUUUUUUUUUUUUUUUUUUUUUUUUUUMMMM\
                           MMMMMMMMMMMMMMMMMMMMMFFFFFFFFFFFFFFFFFFFFFFFFPPPPPPPPPPPPPPPPPPPPP\
                           GGGGGGGGGGGGGGGGGGGWWWWWWWWWWWWWWWWWYYYYYYYYYYYYYYYYYBBBBBBBBBBBBB\
                           BBVVVVVVVVVVVKKKKKXXJJQZ
                           """
            .randomElement()!)
    }
}
