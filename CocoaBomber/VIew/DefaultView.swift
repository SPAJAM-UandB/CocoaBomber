//
//  DefaultView.swift
//  CocoaBomber
//
//  Created by 中岡黎 on 2020/08/29.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import SwiftUI

struct DefaultView: View {
    @EnvironmentObject var cocoaViewModel: CocoaViewModel
    @State var alert_toggle = true
//    let alert: UIAlertController = UIAlertController(
//        title: "WARNING!!",
//        message: "MISSION is COMMING!",
//        preferredStyle: .alert
//        )
//
//    let defaultAction: UIAlertAction = UIAlertAction(
//        title: "Go",
//        style: .default,
//        handler: {
//            (action:UIAlertAction!) -> Void in
//
//    })
//
//    let cancelAction:UIAlertAction =
//    UIAlertAction(title: "Cancel",
//          style: .cancel,
//          handler:{
//            (action:UIAlertAction!) -> Void in
//            // 処理
//    })
    

    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Image("neko1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    Image("neko2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                }
                Text("MISSIONはまだないよ！")
                    .font(.custom("Makinas-4-Square", size: 40))
                    .frame(width: 350, height: 100)
                HStack{
                    Image("neko3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    Image("neko4")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                }
            }
            .alert(isPresented: $cocoaViewModel.start_flag){
                Alert(title: Text("Waring!!"), message: Text("MISSION START"), dismissButton: .default(Text("Go!")))
            }
            
            if !cocoaViewModel.start_flag && cocoaViewModel.alert_flag{
                BombView()
            }
        }
    }

}

struct DefaultView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultView().environmentObject(CocoaViewModel())
    }
}
