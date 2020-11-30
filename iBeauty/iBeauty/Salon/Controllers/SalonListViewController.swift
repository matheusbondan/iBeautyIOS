//
//  SalonListViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 15/10/20.
//

import UIKit
import CoreLocation
import GooglePlaces

class SalonListViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var categoryType:CategorieModelCell?
    
    var googlePlace:GMSPlace?
    
    var havePlace = false
    
    var dataSource:[SalonModel] = [SalonModel.init(image: UIImage.init(named: "salao1"), name: "People Beauty", address: "Av. Ipiranga, 6881 - Prédio 41 - Partenon, Porto Alegre - RS", rate: 3, coordinates: CLLocation(latitude: -30.057296, longitude: -51.1752087)), SalonModel.init(image: UIImage.init(named: "salao2"), name: "Corte Zero Bourbon Ipiranga", address: "Av. Ipiranga, 5200 - loja 92 - Partenon, Porto Alegre - RS", rate: 4, coordinates: CLLocation(latitude: -30.055883, longitude: -51.187499)), SalonModel.init(image: UIImage.init(named: "salao3"), name: "Santo Ofício Cabelo e Arte", address: "R Valparaíso, 634 - Jd Botânico, Porto Alegre - RS", rate: 5, coordinates: CLLocation(latitude: -30.053603, longitude: -51.188123))]
    
   
    
    var service:ServiceModel?
    var timeText:String?
    var dateText:String?
    var dateModel:DateScheduleModel?
    
    let locationManager = CLLocationManager()
    
    var currentPlacemark:CLPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = categoryType?.text
        coreLocation()
        
//        locationLabel.text = locationManager.location.cit
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(locationManager.location ?? CLLocation()) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count>0{
                let placemark = placemarks![0]
                self.currentPlacemark = placemark
                print(placemark.locality!)
                print(placemark.administrativeArea!)
                print(placemark.country!)

                self.locationLabel.text = "\(placemark.locality ?? "")"
            }
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
    
    @objc func scheduleButtonAction(sender: UIButton){
        
    }
    
    @objc func rateButtonAction(sender: UIButton){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "RateViewController") as? RateViewController{
            vc.salon = dataSource[sender.tag]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    @IBAction func changeLocationButtonAction(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController{
            vc.currentPlacemark = self.currentPlacemark
            vc.delegete = self
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
}

extension SalonListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "salonCell", for: indexPath) as! SalonListTableViewCell
        
        cell.setupCell(salon: dataSource[indexPath.row])
        
        
        cell.rateButton.addTarget(self, action:#selector(rateButtonAction(sender:)), for: .touchUpInside)
        cell.rateButton.tag = indexPath.row
        
       
        
        if havePlace{
            
            let location1 = CLLocation(latitude: googlePlace!.coordinate.latitude, longitude: googlePlace!.coordinate.longitude)
            let location2 = dataSource[indexPath.row].coordinates
            
            var distanceMeter = location1.distance(from: location2!)
            print(distanceMeter)
            
//            cell.distanceLabel.text = "\(distanceMeter)m"
            
            let distanceString = String(format: "%.2f", distanceMeter)
            
            cell.distanceLabel.text = "\(distanceString)m"
        }
        else{
            let location1 = locationManager.location
            let location2 = dataSource[indexPath.row].coordinates
            
            let distanceMeter = location1?.distance(from: location2!)
            print(distanceMeter)
            
            let distanceString = String(format: "%.2f", distanceMeter!)
            
            cell.distanceLabel.text = "\(distanceString)m"
        }
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "ServiceViewController") as? ServiceViewController{
//            vc.salon = dataSource[sender.tag]
//            
//            navigationController?.pushViewController(vc, animated: true)
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "EmployeeViewController") as? EmployeeViewController{
            vc.salon = dataSource[indexPath.row]
            vc.dateText = self.dateText
            vc.dateModel = self.dateModel
            vc.timeText = self.timeText
            vc.service = self.service

            navigationController?.pushViewController(vc, animated: true)
        }
    }
}



class SalonListTableViewCell: UITableViewCell {

    @IBOutlet weak var imageSalon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setupCell(salon:SalonModel){
        self.imageSalon.image = salon.image
        self.nameLabel.text = salon.name
        self.addressLabel.text = salon.address
    }
}

extension SalonListViewController: CLLocationManagerDelegate {
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
  }

  // 6
  func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      return
    }
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


extension SalonListViewController: MapViewControllerDelegate{
    func updatePlace(place: GMSPlace) {
        havePlace = true
        googlePlace = place
        locationLabel.text = place.name
        tableView.reloadData()
    }
}
