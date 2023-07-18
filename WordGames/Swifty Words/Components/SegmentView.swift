//
//  SegmentView.swift
//  WordGames
//
//  Created by Kimberly Brewer on 7/18/23.
//

import SwiftUI

struct SegmentView: View {
    /// We need to pass in our segment so we can determine if it has been used or not
    var segment: Segment
    /// Provides a Text view for each segment
    var body: some View {
        Text(segment.text).kerning(2)
            .opacity(segment.isUsed ? 0 : 1)
            .font(.title3)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .background(.indigo)
            .cornerRadius(8)
    }
}

struct SegmentView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentView(segment: .example)
    }
}
