//
//  SearchBar.swift
//  DrinkIt
//
//  Created by Omer Hagage on 15/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import Foundation

import SwiftUI
 
struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
 
    var body: some View {
        HStack {
 
            // placeholder text
            TextField("Search", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        // magnifyingglass image befor the text
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                 
                        // add x to exit the search bar
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                // tap on the search bar
                .onTapGesture {
                    self.isEditing = true
                }
 
            // add Cancel button to close the keyboard
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .animation(.default)
            }
        }.padding(.horizontal, 7)
    }
}
