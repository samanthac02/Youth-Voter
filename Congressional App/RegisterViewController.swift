//
//  RegisterViewController.swift
//  Congressional App
//
//  Created by Samantha Chang on 10/26/21.
//

import UIKit
import MapKit
import CoreLocation

class RegisterViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate  {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var requirementsImage: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    
    let myLocation = CLLocation(latitude: 33.866340, longitude: -118.255070)
    var state = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        centerMapOnLocation(myLocation, mapView: mapView)
    }

    
    var locationManager: CLLocationManager!
    var currentLocationStr = "Current location"
    let annotation = MKPointAnnotation()
    

    override func viewDidAppear(_ animated: Bool) {
        determineCurrentLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)

        // Get user's Current Location and Drop a pin
        let annotation: MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        annotation.title = currentLocationStr

        mapView.addAnnotation(annotation)
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
            
            getAddressFromLatLon(Latitude: (locationManager.location?.coordinate.latitude)!, Longitude: (locationManager.location?.coordinate.longitude)!)
        }
    }

    func getAddressFromLatLon(Latitude: Double, Longitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()


        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = Latitude
        center.longitude = Longitude

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]

                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.country)
                    print(pm.locality)
                    print(pm.subLocality)
                    print(pm.thoroughfare)
                    print(pm.postalCode)
                    print(pm.subThoroughfare)
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    if pm.administrativeArea != nil {
                        self.state = pm.administrativeArea!
                        
                        print(self.state)
                        
                        DispatchQueue.global().async {
                            DispatchQueue.main.async {
                                var data = try? Data(contentsOf: URL(string: "https://youthvoter.blob.core.windows.net/stateinfo/\(self.state.lowercased()).png")!)
                                
                                self.requirementsImage.image = UIImage(data: data!)
                            }
                        }
                        self.requirementsImage.contentMode = .scaleAspectFill
                    }

                    print(addressString)
                    self.addressLabel.text = addressString
                    
                    
              }
        })
    }
    
    func centerMapOnLocation(_ location: CLLocation, mapView: MKMapView) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
        
    }
    
    @IBAction func registerNowButton(_ sender: Any) {
        guard let url = URL(string: "https://www.vote.org/register-to-vote/") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func callHelpline(_ sender: Any) {
        guard let number = URL(string: "tel://" + "8443388743") else { return }
        UIApplication.shared.open(number)
    }
    
    
    @IBAction func sendHelplineMessage(_ sender: Any) {
        guard let url = URL(string: "https://www.voteriders.org/freehelp/") else { return }
        UIApplication.shared.open(url)
    }
}
