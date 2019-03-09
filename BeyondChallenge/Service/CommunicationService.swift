//
//  CommunicationService.swift
//  BeyondChallenge
//
//  Created by Günter Hertz on 09/03/19.
//  Copyright © 2019 Günter Hertz. All rights reserved.
//


import Foundation
import UIKit
import Moscapsule
import RxSwift

class CommunicationService {
    
    private var mqttConfig: MQTTConfig
    private var mqqtClient: MQTTClient!
    
    //topics
    private lazy var subscribeTopic: String = {
        if let path = Bundle.main.path(forResource: "BeyondKeys", ofType: "plist"),
            let values = NSDictionary(contentsOfFile: path),
            let topic = values["Subscribe"] as? String {
            return topic
        } else {
            return ""
        }
    }()
    
    private lazy var publishTopic: String = {
        if let path = Bundle.main.path(forResource: "BeyondKeys", ofType: "plist"),
            let values = NSDictionary(contentsOfFile: path),
            let topic = values["Publish"] as? String {
            return topic
        } else {
            return ""
        }
    }()
    
    //connectionStatus
    private(set) var connectionStatus = ReplaySubject<Bool>.create(bufferSize: 1)
    
    //error handler
    //private(set) var errorHandler = ReplaySubject<ReturnCode>.create(bufferSize: 1)
    
    init() {
        let uuid = UUID()
        mqttConfig = MQTTConfig(clientId: "ambar-beyond-" + uuid.description, host: "ambar.mqtt.beyond.dm", port: 1883, keepAlive: 60)
        
        
        //define connection binder
        mqttConfig.onConnectCallback = { returnCode in
            if returnCode == ReturnCode.success {
                self.connectionStatus.onNext(true)
            } else {
                self.connectionStatus.onNext(false)
                //TO DO: better way to emit errors
                //self.errorHandler.onNext(returnCode)
            }
        }
        
        //define publish callback to control
        mqttConfig.onPublishCallback = { messageId in
            print("The message with id \(messageId) was publish on topic")
        }
    }
    
    func connect() {
        mqqtClient = MQTT.newConnection(mqttConfig)
    }
    
    func publishValue(value: Float) {
        //default config according github
        mqqtClient.publish(string: value.description, topic: publishTopic, qos: 2, retain: false)
    }
}
