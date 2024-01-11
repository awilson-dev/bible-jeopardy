//
//  MultiSelectPickerView.swift
//  Mac Bible Jeopardy
//
//  Created by Allen Wilson on 7/25/22.
//

import SwiftUI

struct MultiSelectPickerView: View {
    @Binding var sourceItems: [Categories]
    @Binding var selectedItems: [Categories]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(sourceItems, id: \.self) { item in
                    HStack {
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
                        .padding(.leading, 20)
                        .padding(.bottom, 5)
                        
                        Spacer()
                    }
                }
                .listRowBackground(Color.black)
            }
            .padding(.top, 125)
            .padding(.bottom, 80)
        }
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
