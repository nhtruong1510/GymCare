//
//  AddressVC.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 09/03/2023.
//

import UIKit
import CoreLocation

class AddressVC: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!

    var classId: Int?
    private var listSearchData: [Address] = []
    private let viewModel = AddressViewModel()
    private var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        determineCurrentLocation()
        viewModel.callApiGetAddress(classId: castToInt(classId)) { data, msg in
            if let msg = msg {
                AlertVC.show(viewController: self, msg: msg)
            } else {
                if let data = data, let address = data.address {
                    self.listSearchData = address
                    self.tableView.reloadData()
                }
            }
        }
    }

    private func configUI() {
        cutomNavi.onClickBack = { [weak self] in
            guard let `self` = self else { return }
            self.backScreen()
        }
        tableView.registerCells(from: .addressViewCell)
        tableView.tableFooterView = UIView()
    }
    
    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()

        if CLLocationManager.locationServicesEnabled() {
            DispatchQueue.main.async {
                self.locationManager.startUpdatingLocation()
            }
        }
    }
}

extension AddressVC: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSearchData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AddressViewCell.dequeueReuse(tableView: tableView)
        cell.fillData(data: listSearchData[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BookingVC()
        vc.address = listSearchData[indexPath.row]
        self.nextScreen(ctrl: vc)
    }

}

extension AddressVC: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0] as CLLocation
        locationManager.stopUpdatingLocation()
        Constants.LONGTITUDE = userLocation.coordinate.longitude
        Constants.LATITUDE = userLocation.coordinate.latitude
    }

    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error \(error)")
    }
}
