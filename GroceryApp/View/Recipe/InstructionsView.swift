//
//  InstructionsView.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 3/11/25.
//

import SwiftUI

struct InstructionsView: View {
    let instructions: String
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            ForEach(Array(instructions.split(separator: "\r\n")
                .enumerated()), id: \.offset) { index, instruction in
                    HStack(alignment: .top, spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color.orange)
                                .frame(width: 28, height: 28)
                            Text("\(index + 1).")
                                .font(.caption.bold())
                                .foregroundStyle(.white)
                        }
                        Text(String(instruction))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding()
                .accessibilityIdentifier("instructionsList")
        }
    }
}
