//
//  TitleView.swift
//  Bible Jeopardy (iPad)
//
//  Created by Allen Wilson on 3/31/24.
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
                    .foregroundStyle(Color.cyan)
                
                Spacer()
            }
            
            VStack {
                Text("JEOPARDY")
                    .font(.custom("System Font Bold", size: 80))
                    .bold()
                    .foregroundStyle(Color.yellow)
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
