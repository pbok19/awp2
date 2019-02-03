//
//  Bose.swift
//  awp2
//
//  Created by PB on 2/2/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import BoseWearable

@objc(Bose)
class Bose: NSObject, WearableDeviceSessionDelegate{
  
  func sessionDidOpen(_ session: WearableDeviceSession) {
    NSLog("session DidOpen", 1);
  }
  
  func session(_ session: WearableDeviceSession, didFailToOpenWithError error: Error?) {
      NSLog("session1 openwith error", 1);
  }
  
  func session(_ session: WearableDeviceSession, didCloseWithError error: Error?) {
        NSLog("session session2 close", 1);
}
  
  
  private var device: WearableDevice?
  
  private var token: ListenerToken?
  
  private let sensorDispatch = SensorDispatch(queue: .main)
  
  @objc class func initBose()
  {
    // Configure the BoseWearable SDK.
    BoseWearable.configure()
    
    // Enable common logging categories. Remove this from production code.
    BoseWearable.enableCommonLogging()
  
  }
  public override init() {
    
  }
  
  init(device: WearableDevice) {
    super.init()
    self.device = device
    // Listen for WearableDeviceEvents.
    token = device.addEventListener(queue: .main) { [weak self] event in
      self?.wearableDeviceEvent(event)
    }
    
    configureSensors()
    configureGestures()
  }
  
  @objc func configureSensors() {
    device?.configureSensors { config in
      // First, disable all currently-enabled sensors.
      config.disableAll()
      
      // Next, configure the sensors we are interested in.
      config.enable(sensor: .accelerometer, at: ._20ms)
      config.enable(sensor: .gyroscope, at: ._20ms)
    }
  }
  
  @objc func configureGestures() {
    device?.configureGestures { config in
      // First, disable all currently-enabled gestures.
      config.disableAll()
      
      // Next, configure the gestures we are interested in.
      config.set(gesture: .doubleTap, enabled: true)
    }
  }
  
  private func wearableDeviceEvent(_ event: WearableDeviceEvent) {
    switch event {
    case .didUpdateSensorConfiguration:
      // The sensor configuration change was accepted.
      NSLog("did update sensor configuration %1", 1)
      break;
    case .didFailToWriteSensorConfiguration(let error):
      // The sensor configuration change was rejected with the specified error.
      NSLog("didFailToWriteSensorConfigurationn %1", error.localizedDescription)
      break;
    case .didUpdateGestureConfiguration:
      // The gesture configuration change was accepted.
      NSLog("didUpdateGestureConfiguration %1", 3)
      break;
    case .didFailToWriteGestureConfiguration(let error):
      // The gesture configuration change was rejected with the specified error.
      NSLog("didFailToWriteGestureConfiguration %1", error.localizedDescription)
      break;
    default:
      break
    }
  }

}
extension Bose: SensorDispatchHandler {
  
  func receivedAccelerometer(vector: Vector, accuracy: VectorAccuracy, timestamp: SensorTimestamp) {
    // handle accelerometer reading
    
  }
  
  func receivedGyroscope(vector: Vector, accuracy: VectorAccuracy, timestamp: SensorTimestamp) {
    // handle gyroscope reading
  }
  
  func receivedGesture(type: GestureType, timestamp: SensorTimestamp) {
    // handle gesture
  }
}
