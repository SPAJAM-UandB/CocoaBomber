//
//  BombView.swift
//  CocoaBomber
//
//  Created by 中岡黎 on 2020/08/29.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import SwiftUI
import AVKit

struct BombView: View {
    @State var beat = false
    @State var alert_toggle = true
    @State var count = 0
    @State var currentDate = Date()
    @State var bomb_timer = 180.00
    @State var bomb_timer2 = 4.99
    @State var intbomb_timer = 100
    @State var bomb_timer_m = 0.0
    @State var intbomb_timer_m = 0
    @State var strbomb_timer_m = "0"
    @State var bomb_timer_s = 0.0
    @State var intbomb_timer_s = 0
    @State var strbomb_timer_s = "0"
    @State var intbomb_timer_r = 0
    @State var strbomb_timer_r = "0"
    @State var num = 1
    @State var all = 4
    @EnvironmentObject var cocoaViewModel: CocoaViewModel
    
    
    func bomb_timer_calc(){
        intbomb_timer = Int(self.cocoaViewModel.time)
        intbomb_timer_r = Int(100.0*(self.cocoaViewModel.time - Double(intbomb_timer)))
        bomb_timer_m = self.cocoaViewModel.time/60.0
        intbomb_timer_m = Int(bomb_timer_m)
        bomb_timer_s = self.cocoaViewModel.time - 60*Double(intbomb_timer_m)
        intbomb_timer_s = Int(bomb_timer_s)
        
        strbomb_timer_m = String(format:"%02d", intbomb_timer_m)
        strbomb_timer_s = String(format:"%02d", intbomb_timer_s)
        strbomb_timer_r = String(format:"%02d", intbomb_timer_r)
        
//        Strbomb_timer_s = String(format: "%05.2f", bomb_timer_s)
        
//        bomb_timer_s =  floor(bomb_timer_s*10)/10
        
    }
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    let timer2 = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { bodyView in
            ZStack{
                Image("black_back")
                    .resizable()
                    .frame(width: bodyView.size.width, height: bodyView.size.height, alignment: .topLeading)
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.all)
                Spacer()
                VStack{
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Text("MISSION")
                        .font(.custom("Makinas-4-Square", size: 50))
                        .foregroundColor(Color.init(red: 57/255, green: 1, blue: 20/255))
                    Text("会場の全員にcocoaをインストールさせよ")
                        .font(.custom("Makinas-4-Square", size: 30))
                        .frame(width: 350, height: 100)
                        .foregroundColor(.red)
                    ZStack{
                        Image("ironmat")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .edgesIgnoringSafeArea(.all)
                            .scaledToFill()
                            .frame(width: 0, height: 700, alignment: .bottom)
                        Circle()
                            .frame(width: 150, height: 150)
                            .position(x:330, y:540)
                        Text("\(self.cocoaViewModel.cocoa_num)/\(self.cocoaViewModel.all_num)")
                            .font(.custom("Makinas-4-Square", size: 50))
                            .foregroundColor(.red)
                            .position(x:330, y:540)
                        Image("bomb")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 480, height: 480)
                            .position(x:230, y:300)
                            .scaleEffect(self.beat ? 1 : 1.1)
                            .animation(.easeInOut(duration: 1.0))
                            .onReceive(self.timer){_ in
                                self.beat.toggle()
                            }
                        Rectangle()
                            .stroke(Color.red, lineWidth: 3)
                            .frame(width: 200, height: 60)
                        Rectangle()
                            .frame(width: 200, height: 60)
                        Text("\(self.strbomb_timer_m):\(self.strbomb_timer_s):\(self.strbomb_timer_r)")
                            .font(.custom("DJB Get Digital", size: 50))
                            .foregroundColor(.red)
                    }
                    
                }
                .onReceive(self.timer2){_ in
                    self.count += 1
                    if self.cocoaViewModel.time > 0 {
                        self.cocoaViewModel.time -= 0.01
                        self.bomb_timer_calc()
                    }
                }
                if self.cocoaViewModel.time < 0{
                    Image("black_back")
                        .resizable()
                        .frame(width: bodyView.size.width, height: bodyView.size.height, alignment: .topLeading)
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    MovieView()
                } else if self.cocoaViewModel.clear_flag {
                    MissionView()
                }
            }
//            Image("black_back")
//                .resizable()
//                .frame(width: bodyView.size.width, height: bodyView.size.height, alignment: .topLeading)
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//            MovieView()
        }
    }
}

struct MovieView: UIViewRepresentable {
func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<MovieView>) {
}

func makeUIView(context: Context) -> UIView {
return PlayerClass(frame: .zero)
}
}

class PlayerClass: UIView {
private let avPlayerLayer = AVPlayerLayer()

let startTime : CMTime = CMTimeMake(value: 1, timescale: 1)

override init(frame: CGRect) {
super.init(frame: frame)

let url = Bundle.main.path(forResource: "explosion", ofType: "mp4")
let player = AVPlayer(url: URL(fileURLWithPath: url!))

//player.actionAtItemEnd = .none
player.seek(to: startTime)
player.play()
avPlayerLayer.player = player

//NotificationCenter.default.addObserver(self,selector: #selector(playerDidEnd(notification:)),name: .AVPlayerItemDidPlayToEndTime,object: player.currentItem)

layer.addSublayer(avPlayerLayer)

}

//@objc func playerDidEnd(notification: Notification) {
//if let avPlayerItem = notification.object as? AVPlayerItem {
//avPlayerItem.seek(to: startTime, completionHandler: nil)
//}
//}

required init?(coder: NSCoder) {
fatalError("init error")
}

override func layoutSubviews() {
super.layoutSubviews()
avPlayerLayer.frame = bounds
}
}

struct BombView_Previews: PreviewProvider {
    static var previews: some View {
        BombView().environmentObject(CocoaViewModel())
    }
}
