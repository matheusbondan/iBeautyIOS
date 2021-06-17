//
//  MapViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 22/10/20.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces

protocol MapViewControllerDelegate {
    func updatePlace(place:GMSPlace)
}

class MapViewController: UIViewController {

    
    var service:ServiceModel?
    var timeText:String?
    var dateText:String?
    var dateModel:DateScheduleModel?
    var currentPlacemark:CLPlacemark?
    
    var delegete:MapViewControllerDelegate?
    
    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var currentPlaceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        
        currentPlaceLabel.text = currentPlacemark?.locality
        
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
    
    // Present the Autocomplete view controller when the button is pressed.
      @objc func autocompleteClicked() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self

        // Specify the place data types to return.
//        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
//                                                    UInt(GMSPlaceField.placeID.rawValue))
//        autocompleteController.placeFields = fields

        // Specify a filter.
//        let filter = GMSAutocompleteFilter()
//        filter.type = .address
//        autocompleteController.autocompleteFilter = filter

        // Display the autocomplete view controller.
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
    
    
    @IBAction func searchLocationButtonAction(_ sender: Any) {
        autocompleteClicked()
    }
    
}

extension MapViewController:GMSAutocompleteViewControllerDelegate{
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
      print("Place name: \(place.name)")
      print("Place ID: \(place.placeID)")
      print("Place attributions: \(place.attributions)")
        
        currentPlaceLabel.text = place.name
        delegete?.updatePlace(place: place)
        
        mapView.camera = GMSCameraPosition(
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
extension MapViewController: CLLocationManagerDelegate {
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


extension MapViewController:GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
      print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }
}


