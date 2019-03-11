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
    //control variables
    private var isSubscribed: Bool = false
    
    private var mqttConfig: MQTTConfig
    private var mqttClient: MQTTClient!
    
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
    
    private lazy var clientID: String = {
        if let path = Bundle.main.path(forResource: "BeyondKeys", ofType: "plist"),
            let values = NSDictionary(contentsOfFile: path),
            let topic = values["ClientID"] as? String {
            return topic
        } else {
            return ""
        }
    }()
    
    private lazy var clientHost: String = {
        if let path = Bundle.main.path(forResource: "BeyondKeys", ofType: "plist"),
            let values = NSDictionary(contentsOfFile: path),
            let topic = values["ClientHost"] as? String {
            return topic
        } else {
            return ""
        }
    }()
    //connectionStatus
    private(set) var connectionStatus = ReplaySubject<Bool>.create(bufferSize: 1)
    //subscribed value
    private(set) var dimmerValue = ReplaySubject<Int>.create(bufferSize: 1)
    
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
            //print("PUBLISHED - The message with id \(messageId) was publish on topic")
        }
        
        //define subscribe callback to control
        mqttConfig.onSubscribeCallback = { (messageId, grantedQos) in
            //print("SUBSCRIBED - (mid=\(messageId),grantedQos=\(grantedQos))")
        }
        
        //define message callback, should get value to bind to image?
        mqttConfig.onMessageCallback = { mqttMessage in
            if mqttMessage.topic == self.subscribeTopic {
                if let data = mqttMessage.payloadString, let value = Int(data) {
                    self.dimmerValue.onNext(value)
                    //print("RECEIVED MESSAGE: \(value) ON TOPIC: \(mqttMessage.topic)")
                }
            }
        }
    }
    
    func connectMQTT() {
        moscapsule_init()
        mqttClient = MQTT.newConnection(mqttConfig)
        //mqttClient.subscribe(self.publishTopic, qos: 2)
    }
    
    func publishValue(value: Int) {
        //default config according github
        mqttClient.publish(string: value.description, topic: publishTopic, qos: 2, retain: false)
    }
    
    func subscribeToChannel() {
        if !isSubscribed {
            self.mqttClient.subscribe(self.subscribeTopic, qos: 2)
            isSubscribed = true
        }
    }
}
