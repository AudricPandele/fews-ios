//
//  MapCell.swift
//  Fews
//
//  Created by Clément Quennesson on 16/12/15.
//  Copyright © 2015 Audric Pandelé. All rights reserved.
//

import UIKit
import MapKit

class MapCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    let geocoder: CLGeocoder = CLGeocoder()
    
    var location: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()

//        self.geocoder.geocodeAddressString(self.location, completionHandler: {(placemarks, error) -> Void in
//            if((error) != nil){
//                print("Error", error)
//            }
//            if let placemark = placemarks?.first {
//                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
//                self.centerMapOnLocation(coordinates)
//                
//                let annotation = MKPointAnnotation()
//                annotation.coordinate = coordinates
//                annotation.title = self.location
//                self.mapView.addAnnotation(annotation)
//            }
//        })
    }
    
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
