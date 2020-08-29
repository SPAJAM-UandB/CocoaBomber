//
//  CocoaViewModel.swift
//  CocoaBomber
//
//  Created by 中岡黎 on 2020/08/29.
//  Copyright © 2020 中岡黎. All rights reserved.
//

import Foundation
import SocketIO

class CocoaViewModel: ObservableObject{
    @Published var all_num: String = "0"
    @Published var cocoa_num: String = "0"
    @Published var time: [Int] = [10, 10, 10]
    @Published var mission_or_default: Bool = false
    var manager: SocketManager!
    var socket: SocketIOClient!
    
    init(){
        manager = SocketManager(socketURL: URL(string: "http://163.221.68.245:5000/")!, config: [.log(true), .compress])
        socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect) { data, ack in
            print("connect")
        }
        
        socket.on(clientEvent: .disconnect) { data, ack in
            print("disconnect")
        }

        socket.on("message") { data, ark in
            print("Message received")
        }
        
        socket.on("led") { data, ark in
            print(type(of: data[0] as! String))
            // self.led_mess = data[0] as! String
        }
        


        socket.connect()
    }
    
    func turnOffGreen(){
        print("turn off green")
        self.socket.emit("off_green", "data")
    }
}
