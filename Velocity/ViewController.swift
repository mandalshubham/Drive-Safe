//
//  ViewController.swift
//  Velocity
//
//  Created by Shubham Mandal on 7/6/19.
//  Copyright © 2019 Shubham Mandal. All rights reserved.
//

import UIKit
import CoreMotion
import simd
import CoreLocation

class ViewController: UIViewController {
    var motionManager: CMMotionManager?
    var locationManager : CLLocationManager?

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager?.pausesLocationUpdatesAutomatically = false
        locationManager?.showsBackgroundLocationIndicator = true
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.distanceFilter = 50.0
        locationManager?.requestAlwaysAuthorization()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //startUpdates()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //stopUpdates()
    }

/* Use these functions to interpret accelerometer data 
    func startUpdates() {
        
        guard let motionManager = motionManager, motionManager.isAccelerometerAvailable else { return }


        motionManager.accelerometerUpdateInterval = TimeInterval(0.1)
        motionManager.showsDeviceMovementDisplay = true

        motionManager.startAccelerometerUpdates(to: .main) { accelerometerData, error in
            guard let accelerometerData = accelerometerData else { return }

            print(accelerometerData)
        }
    }

    func stopUpdates() {
        guard let motionManager = motionManager, motionManager.isAccelerometerAvailable else { return }

        motionManager.stopAccelerometerUpdates()
    }
 */
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let updatedLocation = locations.last {
            
            var speed = round(updatedLocation.speed * 3.6)
            if speed < 0 {
                speed = 0
            }
            label.text = String(Int(speed))
            let sp = (speed > 60) ? 60 : speed
            let val = (60 - sp) * 4.25
            view.backgroundColor = UIColor(red: 1.0, green: CGFloat(val/255), blue: CGFloat(val/255), alpha: 1.0)
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            print("always")
            locationManager?.startUpdatingLocation()
        }
    }
}
