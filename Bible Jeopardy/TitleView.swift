//
//  TitleView.swift
//  Bible Jeopardy
//
//  Created by Allen Wilson on 7/22/22.
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("BIBLE")
                    .font(.custom("Arial Rounded MT Bold", size: 40))
                    .bold()
                    .foregroundColor(Color(red: 165 / 255, green: 224 / 255, blue: 251 / 255))
                    .padding(.top, 15)
                Spacer()
            }
            VStack {
                Text("JEOPARDY")
                    .font(.custom("System Font Bold", size: 60))
                    .bold()
                    .foregroundColor(Color(red: 248 / 255, green: 218 / 255, blue: 133 / 255))
                    .padding(.top, 10)
                Spacer()
            }
            Spacer()
        }
        .frame(height: 80)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
            .background(Color.black)
    }
}
