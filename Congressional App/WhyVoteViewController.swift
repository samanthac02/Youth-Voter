//
//  WhyVoteViewController.swift
//  Congressional App
//
//  Created by Samantha Chang on 10/2/21.
//

import UIKit
import CoreLocation

class WhyVoteViewController: UIViewController, CLLocationManagerDelegate {
    let myLocation = CLLocation(latitude: 33.866340, longitude: -118.255070)
    
    var locationManager: CLLocationManager!
    var currentLocationStr = "Current location"
    
    @IBOutlet weak var whyVoteImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        whyVoteImage.clipsToBounds = true
        whyVoteImage.layer.cornerRadius = 16
        whyVoteImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    override func viewDidAppear(_ animated: Bool) {
        determineCurrentLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
    }

    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            
            switch locationManager.authorizationStatus {
            case .notDetermined, .restricted, .denied:
                print("No access")
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
            @unknown default:
            break
            }
        }
    }

    func setUsersClosestLocation(mLattitude: CLLocationDegrees, mLongitude: CLLocationDegrees) -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: mLattitude, longitude: mLongitude)

        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in

            if let placemark = placemarks{
                if let dict = placemark[0].addressDictionary as? [String: Any]{
                    if let Name = dict["Name"] as? String{
                        if let City = dict["City"] as? String{
                            self.currentLocationStr = Name + ", " + City
                        }
                    }
                }
            }
        }
        return currentLocationStr
    }
    
    @IBAction func registerButton(_ sender: Any) {
        guard let url = URL(string: "https://www.vote.org/register-to-vote/") else { return }
        UIApplication.shared.open(url)
    }
}
