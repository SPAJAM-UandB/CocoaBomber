//
//  ContentView.swift
//  CocoaBomber
//
//  Created by 中岡黎 on 2020/08/29.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Text("Hello, World!")
                .font(.custom("DJB Get Digital", size: 40))
            Text("Hello, World!")
                .font(.custom("Makinas-4-Square", size: 40))
            Text("Hello, World!")
                .font(.custom("Makinas-4-Flat", size: 40))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
