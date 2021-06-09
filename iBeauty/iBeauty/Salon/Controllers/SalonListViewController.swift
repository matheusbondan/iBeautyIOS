//
//  SalonListViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 15/10/20.
//

import UIKit
import CoreLocation
import GooglePlaces
import Cosmos
import SVProgressHUD

class SalonListViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var categoryType:CategorieModelCell?
    
    var googlePlace:GMSPlace?
    
    var havePlace = false
    
    var dataSource:[SalonModel] = []
    
    var category:CategoryModel?
    var service:ServiceModel?
    var timeText:String?
    var dateText:String?
    var dateModel:DateScheduleModel?
    
    let locationManager = CLLocationManager()
    
    var currentPlacemark:CLPlacemark?
    var dateMonthYear:String?
    var haveLocation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dateFormatterWeekDay = DateFormatter()
        dateFormatterWeekDay.dateFormat = "dd/MM/yyyy"
        dateFormatterWeekDay.locale = Locale.init(identifier: "pt_BR")
        dateMonthYear = dateFormatterWeekDay.string(from: (dateModel?.date)!)
        
        tableView.tableFooterView = UIView()
        
//        SVProgressHUD.show()
//        SalonAPI().getSalonByService(idService: service?.serviceId ?? "") { salons, error in
//            DispatchQueue.main.async {
//                SVProgressHUD.dismiss()
//            }
//            if error == nil{
//                self.dataSource = salons ?? []
//                self.tableView.reloadData()
//            } else {
//                print(error)
//            }
//        }
        
        self.title = categoryType?.text
        coreLocation()
        callGeocode()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    private func callGeocode(){
        let geocoder = CLGeocoder()
        if let lml = locationManager.location{
            geocoder.reverseGeocodeLocation(lml) { (placemarks, error) in
                if (error != nil){
                    print("error in reverseGeocode")
                    self.haveLocation = false
                    self.callAPI()
                }
                let placemark = placemarks! as [CLPlacemark]
                if placemark.count>0{
                    let placemark = placemarks![0]
                    self.currentPlacemark = placemark

                    self.locationLabel.text = "\(placemark.locality ?? "")"
                    
                    self.haveLocation = true
                    self.callAPI()
                    
                } else{
                    self.haveLocation = false
                    self.callAPI()
                }
            }
        } else {
            callAPI()
        }
    }
    
    private func callAPI(){
        var lat = 0.0
        var lng = 0.0
        
        if haveLocation {
            if let la = self.currentPlacemark?.location?.coordinate.latitude, let lg = self.currentPlacemark?.location?.coordinate.longitude{
                lat = la
                lng = lg
            } else {
                haveLocation = false
            }
        }
        
        if havePlace {
            haveLocation = true
            
            if let la = googlePlace?.coordinate.latitude, let lg = googlePlace?.coordinate.longitude{
                lat = la
                lng = lg
            } else {
                haveLocation = false
            }
        }
        
        SVProgressHUD.show()
        SalonAPI().getSalonByService(idService: service?.serviceId ?? "", lat: lat, lng: lng, dayMonthYear: dateMonthYear ?? "", hour: timeText ?? "", haveLocation: haveLocation) { salons, error in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            if error == nil{
                self.dataSource = salons ?? []
                self.tableView.reloadData()
            } else {
                print(error)
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
        
        if let rate = dataSource[indexPath.row].rating {
            cell.cosmosRatings.isHidden = false
            cell.cosmosRatings.rating = rate
        } else {
            cell.cosmosRatings.isHidden = true
        }
        
        if havePlace{

            let location1 = CLLocation(latitude: googlePlace!.coordinate.latitude, longitude: googlePlace!.coordinate.longitude)
            let location2:CLLocation?
                
            if let la = dataSource[indexPath.row].address?.lat, let lg = dataSource[indexPath.row].address?.lng{
                location2 = CLLocation(latitude: la, longitude: lg)

                let distanceMeter = location1.distance(from: location2!)

                let distanceString = String(format: "%.2f", distanceMeter)
                
                cell.distanceLabel.text = "\(distanceString)m"
            } else{
                cell.distanceLabel.text = ""
            }
        }
        else{
            let location1 = locationManager.location
            
            let location2:CLLocation?
                
            if let la = dataSource[indexPath.row].address?.lat, let lg = dataSource[indexPath.row].address?.lng, let loc1 = location1{
                location2 = CLLocation(latitude: la, longitude: lg)

                let distanceMeter = loc1.distance(from: location2!)

                let distanceString = String(format: "%.2f", distanceMeter)
                
                cell.distanceLabel.text = "\(distanceString)m"
            } else{
                cell.distanceLabel.text = ""
            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
    @IBOutlet weak var cosmosRatings: CosmosView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setupCell(salon:SalonModel){
        self.imageSalon.image = UIImage.init(named: "salao1")
        self.nameLabel.text = salon.name
        self.addressLabel.text = "\(salon.address?.street ?? ""), \(salon.address?.number ?? "") \(salon.address?.complement ?? "") - \(salon.address?.city ?? ""), \(salon.address?.state ?? "")"
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
        
        callAPI()
        
        tableView.reloadData()
    }
}
