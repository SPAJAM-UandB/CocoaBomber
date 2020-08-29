//
//  ContentView.swift
//  CocoaBomber
//
//  Created by 中岡黎 on 2020/08/29.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var cocoaViewModel: CocoaViewModel
    
    var body: some View {
        if self.cocoaViewModel.mission_or_default {
            return DefaultView()
        } else {
            return BombView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(CocoaViewModel())
    }
}
