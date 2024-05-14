//
//  SelectedCategoriesListView.swift
//  Mac Bible Jeopardy
//
//  Created by Allen Wilson on 7/26/23.
//

import SwiftUI

struct SelectedCategoriesListView: View {
    @Binding var sourceItems: [Categories]
    @Binding var selectedItems: [Categories]
    
    var availableItems: [Categories] {
        var availableItems = sourceItems
        
        var items: [Categories] = []
        for item in availableItems {
            if items.contains(where: { item.rawValue.displayName == $0.rawValue.displayName }) {
                availableItems.removeAll(where: { $0 == item })
            }
            
            items.append(item)
        }
        
        for item in availableItems {
            if selectedItems.contains(where: { item.rawValue.displayName == $0.rawValue.displayName }) {
                availableItems.removeAll(where: { $0 == item })
            }
        }
        
        return availableItems
    }
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("Selected Categories:")
                        .font(.custom("Arial Rounded MT Bold", size: 24))
                        .bold()
                        .foregroundColor(.white)
                        .padding(5)
                    
                    Spacer()
                }
                
                HStack {
                    VStack {
                        ForEach(selectedItems, id: \.self) { item in
                            HStack {
                                Text("\(item.rawValue.displayName)")
                                    .font(.custom("Arial Rounded MT Bold", size: 20))
                                    .bold()
                                    .foregroundColor(.white)
                                
                                if Categories.newCategories.contains(item) {
                                    Text("NEW!")
                                        .font(.custom("Arial Rounded MT Bold", size: 12))
                                        .bold()
                                        .foregroundColor(.yellow)
                                        .offset(y: -5)
                                }
                                
                                Spacer()
                            }
                            .foregroundColor(.white)
                            .padding(5)
                        }
                        .listRowBackground(Color.black)
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding()
            
            VStack {
                HStack {
                    Text("Available Categories:")
                        .font(.custom("Arial Rounded MT Bold", size: 24))
                        .bold()
                        .foregroundColor(.white)
                        .padding(5)
                    
                    Spacer()
                }
                
                HStack {
                    LazyHGrid(rows: [GridItem(.adaptive(minimum: 40))]) {
                        ForEach(availableItems) { item in
                            HStack {
                                Text("\(item.rawValue.displayName)")
                                    .font(.custom("Arial Rounded MT Bold", size: 20))
                                    .bold()
                                    .foregroundColor(.white)
                                
                                if Categories.newCategories.contains(item) {
                                    Text("NEW!")
                                        .font(.custom("Arial Rounded MT Bold", size: 12))
                                        .bold()
                                        .foregroundColor(.yellow)
                                        .offset(y: -5)
                                }
                                
                                Spacer()
                            }
                            .foregroundColor(.white)
                            .padding(5)
                        }
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding()
        }
    }
}
