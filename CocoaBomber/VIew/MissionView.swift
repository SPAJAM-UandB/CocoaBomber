//
//  MissionView.swift
//  CocoaBomber
//
//  Created by 中岡黎 on 2020/08/29.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    var body: some View {
        GeometryReader { bodyView in
            ZStack{
                Image("black_back")
                    .resizable()
                    .frame(width: 500, height: 500, alignment: .center)
                VStack{
                    Text("MISSION")
                    Text("START")
                }
                    .font(.custom("Makinas-4-Square", size: 30))
                    .frame(width: 350, height: 100)
                    .foregroundColor(Color.init(red: 57/255, green: 1, blue: 20/255))
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
        MissionView()
    }
}
