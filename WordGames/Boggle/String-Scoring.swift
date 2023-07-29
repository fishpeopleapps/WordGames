//
//  String-Scoring.swift
//  WordGames
//
//  Created by Kimberly Brewer on 7/28/23.
//

import Foundation

extension String {
    var score: Int {
        if count < 5 {
            return 1
        } else {
            return count - 3
        }
    }
}
