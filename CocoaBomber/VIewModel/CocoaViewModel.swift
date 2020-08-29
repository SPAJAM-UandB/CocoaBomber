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
    @Published var all_num: Int = 0
    @Published var cocoa_num: Int = 0
    @Published var time: Int = 0
    @Published var mission_or_default: Bool = false
    @Published var clear_flag: Bool = false
    var manager: SocketManager!
    var socket: SocketIOClient!
    
    init(){
        manager = SocketManager(socketURL: URL(string: "http://163.221.68.245:5000/")!, config: [.log(true), .compress])
        socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect) { data, ack in
            print("connect")
            self.all_num = 0
        }
        
        socket.on(clientEvent: .disconnect) { data, ack in
            print("disconnect")
        }

        socket.on("person_number") { data, ark in
            //print(type(of: data[0]))
            let dict_string = data[0] as! String
            let dict = self.convertToDictionary(text: dict_string)
            self.all_num = dict!["all_person"]! as! Int
            self.cocoa_num = dict!["cocoa_person"]! as! Int
            print(self.cocoa_num)
            print(self.all_num)
            print(self.time)
            print("Message received")
            if self.cocoa_num == self.all_num {
                self.clear_flag = true
            }
        }
        
        socket.on("start_game") { data, ark in
            let dict_string = data[0] as! String
            let dict = self.convertToDictionary(text: dict_string)
            self.all_num = dict!["all_person"]! as! Int
            self.cocoa_num = dict!["cocoa_person"]! as! Int
            self.time = dict!["time"]! as! Int
            self.clear_flag = false
            //print(type(of: data[0]))
            //print(data[0])

        }
        socket.connect()
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}
