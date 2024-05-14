//
//  TitleView.swift
//  Mac Bible Jeopardy
//
//  Created by Allen Wilson on 7/25/22.
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                Text("BIBLE")
                    .font(.custom("Arial Rounded MT Bold", size: 60))
                    .bold()
                    .foregroundColor(Color(red: 165 / 255, green: 224 / 255, blue: 251 / 255))
                
                Spacer()
            }
            
            VStack {
                Text("JEOPARDY")
                    .font(.custom("System Font Bold", size: 80))
                    .bold()
                    .foregroundColor(Color(red: 248 / 255, green: 218 / 255, blue: 133 / 255))
                    .padding(.top, 9)
                
                Spacer()
            }
            
            Spacer()
        }
        .frame(height: 90)
    }
}

#Preview {
    TitleView()
}
