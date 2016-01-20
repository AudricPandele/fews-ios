//
//  MapCollectionViewCell.swift
//  Fews
//
//  Created by Audric Pandelé on 20/01/2016.
//  Copyright © 2016 Audric Pandelé. All rights reserved.
//

import UIKit
import MapKit

class MapCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mapView: MKMapView!
    
    var location: String! = ""
    let regionRadius: CLLocationDistance = 1000
    let geocoder: CLGeocoder = CLGeocoder()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        setMap(location)
    }
    
    func setMap(location: String){
        self.geocoder.geocodeAddressString(location, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error)
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                self.centerMapOnLocation(coordinates)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinates
                annotation.title = self.location
                self.mapView.addAnnotation(annotation)
            }
        })
    }
    
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location,
            regionRadius * 200.0, regionRadius * 200.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
}
