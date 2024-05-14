//
//  MultiSelectPickerView.swift
//  Bible Jeopardy
//
//  Created by Allen Wilson on 7/24/22.
//

import SwiftUI

struct MultiSelectPickerView: View {
    @State var sourceItems: [Categories]
    @Binding var selectedItems: [Categories]
    
    var body: some View {
        List {
            ForEach(sourceItems, id: \.self) { item in
                Button(action: {
                    withAnimation {
                        if self.selectedItems.contains(item) {
                            self.selectedItems.removeAll(where: { $0 == item })
                        } else {
                            self.selectedItems.append(item)
                        }
                    }
                }, label: {
                    HStack {
                        Image(systemName: "checkmark")
                            .opacity(self.selectedItems.contains(item) ? 1.0 : 0.0)
                        Text("\(item.rawValue.name)")
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
                    }
                })
                .foregroundColor(.white)
            }
            .listRowBackground(Color.black)
        }
        .listStyle(.plain)
        .onAppear {
            var newCategories: [Categories] = []
            var oldCategories: [Categories] = []
            
            for item in sourceItems {
                if Categories.newCategories.contains(item) {
                    newCategories.append(item)
                } else {
                    oldCategories.append(item)
                }
            }
            
            sourceItems = newCategories + oldCategories
        }
    }
}
