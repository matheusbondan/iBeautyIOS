//
//  UserLocationViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 17/06/21.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces

class UserLocationViewController: BaseViewController {

    var timeText:String?
    var dateText:String?
    var dateModel:DateScheduleModel?
    var category:CategoryModel?
    var service:ServiceModel?
    @IBOutlet weak var switchUseLocation: UISwitch!
    var currentPlacemark:CLPlacemark?
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var currentLocationLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    var currentLocation:UserLocationModel = UserLocationModel()
    var haveLocation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreLocation()

        mapView.delegate = self
        
        // 1
        locationManager.delegate = self

        // 2
        if CLLocationManager.locationServicesEnabled() {
          // 3
          locationManager.requestLocation()

          // 4
          mapView.isMyLocationEnabled = true
          mapView.settings.myLocationButton = true
        } else {
          // 5
          locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        callGeocode()
    }

    @IBAction func changeLocationLabel(_ sender: Any) {
        autocompleteClicked()
    }
    
    @objc func autocompleteClicked() {
      let autocompleteController = GMSAutocompleteViewController()
      autocompleteController.delegate = self
      present(autocompleteController, animated: true, completion: nil)
    }

    // Add a button to the view.
    func makeButton() {
      let btnLaunchAc = UIButton(frame: CGRect(x: 5, y: 150, width: 300, height: 35))
      btnLaunchAc.backgroundColor = .blue
      btnLaunchAc.setTitle("Launch autocomplete", for: .normal)
      btnLaunchAc.addTarget(self, action: #selector(autocompleteClicked), for: .touchUpInside)
      self.view.addSubview(btnLaunchAc)
    }
    
    @IBAction func confirmButton(_ sender: Any) {
        if switchUseLocation.isOn {
            if currentLocation.lat != nil && currentLocation.lng != nil && currentLocation.addressName != nil {
                if let vc = storyboard?.instantiateViewController(withIdentifier: "SalonListViewController") as? SalonListViewController{
                    
                    vc.dateText = self.dateText
                    vc.dateModel = self.dateModel
                    vc.timeText = self.timeText
                    vc.service = self.service
                    vc.category = self.category
                    vc.currentLocation = self.currentLocation
                    vc.useUserLocation = true
                    
                    AppContextHelper.share.currentLocation = self.currentLocation
                    
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
            else {
                self.showAlertToast(title: "Verifique a localização atual!", displayTime: 10)
            }
            
            
        } else {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "SalonListViewController") as? SalonListViewController{
                
                vc.dateText = self.dateText
                vc.dateModel = self.dateModel
                vc.timeText = self.timeText
                vc.service = self.service
                vc.category = self.category
                vc.currentLocation = self.currentLocation
                vc.useUserLocation = false
                
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    private func callGeocode(){
        let geocoder = CLGeocoder()
        if let lml = locationManager.location{
            geocoder.reverseGeocodeLocation(lml) { (placemarks, error) in
                if (error != nil){
                    print("error in reverseGeocode")
                    self.haveLocation = false
                }
                if let placemark = placemarks as? [CLPlacemark]{
                    if placemark.count>0{
                        let placemark = placemarks![0]
                        self.currentPlacemark = placemark

                        self.currentLocationLabel.text = "\(placemark.locality ?? "")"
                        
                        self.currentLocation.addressName = placemark.locality
                        self.currentLocation.lat = placemark.location?.coordinate.latitude
                        self.currentLocation.lng = placemark.location?.coordinate.longitude
                        
                        if let loc = placemark.location{
                            self.mapView.camera = GMSCameraPosition(
                                target: loc.coordinate,
                              zoom: 15,
                              bearing: 0,
                              viewingAngle: 0)
                        }
                        
                        self.haveLocation = true
                        
                    } else{
                        self.haveLocation = false
                    }
                }
                else{
                    self.haveLocation = false
                }
            }
        } else {
            self.haveLocation = false
        }
    }
    
    func coreLocation(){
        // 1
        locationManager.delegate = self

        // 2
        if CLLocationManager.locationServicesEnabled() {
          // 3
          locationManager.requestLocation()
        } else {
          // 5
          locationManager.requestWhenInUseAuthorization()
        }
    }
    
}

extension UserLocationViewController:GMSAutocompleteViewControllerDelegate{
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        currentLocationLabel.text = place.name
        
        currentLocation.addressName = place.name
        currentLocation.lat = place.coordinate.latitude
        currentLocation.lng = place.coordinate.longitude
        
        self.mapView.camera = GMSCameraPosition(
          target: place.coordinate,
          zoom: 15,
          bearing: 0,
          viewingAngle: 0)
        
      dismiss(animated: true, completion: nil)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
      // TODO: handle the error.
      print("Error: ", error.localizedDescription)
    }

    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
      dismiss(animated: true, completion: nil)
    }

    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

// MARK: - CLLocationManagerDelegate
//1
extension UserLocationViewController: CLLocationManagerDelegate {
  // 2
  func locationManager(
    _ manager: CLLocationManager,
    didChangeAuthorization status: CLAuthorizationStatus
  ) {
    // 3
    guard status == .authorizedWhenInUse else {
      locationManager.requestWhenInUseAuthorization()
      return
    }
    // 4
    locationManager.startUpdatingLocation()

    //5
    mapView.isMyLocationEnabled = true
    mapView.settings.myLocationButton = true
  }

  // 6
  func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      return
    }
    
//    callGeocode()

    // 7
//    mapView.camera = GMSCameraPosition(
//      target: location.coordinate,
//      zoom: 15,
//      bearing: 0,
//      viewingAngle: 0)
  }

  // 8
  func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
  ) {
    print(error)
  }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error::: \(error)")
        locationManager.stopUpdatingLocation()
        let alert = UIAlertController(title: "Settings", message: "Allow location from settings", preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "Alerta", style: .default, handler: { action in
            switch action.style{
            case .default: UIApplication.shared.openURL(NSURL(string: UIApplication.openSettingsURLString)! as URL)
            case .cancel: print("cancel")
            case .destructive: print("destructive")
            }
        }))
    }
}


extension UserLocationViewController:GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
      print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }
}
