//
//  ProfileViewHeader.swift
//  GroceryApp
//
//  Created by Yenat Feyyisa on 6/4/25.
//

import SwiftUI

struct ProfileViewHeader: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding(.trailing, 8)
                VStack(alignment: .leading) {
                    Text("username")
                        .font(.headline)
                    Text("username")
                        .foregroundStyle(.gray)
                }
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.title2)
                }
            }
            Text("📅 Joined May 15, 2025")
                .font(.caption)
                .foregroundStyle(.gray)
            HStack(spacing: 16) {
                Text("1 Posts").bold()
                Text("1 Following").bold()
                Text("0 Followers").bold()
            }
            .font(.subheadline)
            .foregroundStyle(.purple)
        }
        .padding()
    }
}

#Preview {
    ProfileViewHeader()
}
