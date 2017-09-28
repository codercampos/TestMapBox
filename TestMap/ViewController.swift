//
//  ViewController.swift
//  TestMap
//
//  Created by Carlos Campos on 9/27/17.
//  Copyright © 2017 Carlos Campos. All rights reserved.
//

import UIKit
import Mapbox
import Alamofire

class ViewController: UIViewController, MGLMapViewDelegate {
    var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a new map view using the Mapbox Light style.
        let lightStyleURL = MGLStyle.lightStyleURL(withVersion: 9)
        mapView = MGLMapView(frame: view.bounds, styleURL: lightStyleURL)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.tintColor = .darkGray
    
        // Set the map’s center coordinate and zoom level.
        // I suggest a value around the source you are going to show - Carlos Campos
        mapView.setCenter(CLLocationCoordinate2D(latitude: 43.037, longitude: -76.134), zoomLevel: 16, animated: false)
        
        mapView.delegate = self
        view.addSubview(mapView)    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Wait until the style is loaded before modifying the map style.
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        
        // "mapbox://codercampos.cj83r6ar100v42rrwjqvsq8eg-684g5" is the map ID referencing a tileset.
        // created from the GeoJSON data uploaded earlier.
        // Notes  - Carlos Campos
        //If you want to use your own tileset, you must retreve you mapid on the tileset sections. Example: mapbox://{your-mapid-here}
        //The identifier is a unique id you want to name your source. Name it like "ranks" or something
        let source = MGLVectorSource(identifier: "trees", configurationURL: URL(string: "mapbox://codercampos.cj840arsl044433qbhmn77vw0-9q7ts")!)
        
        // Notes  - Carlos Campos
        //This is the style attached to a source (mapid), this is created on MapBox Studio.
        //On the Tileset, you can create a style from that tileset and save it. The name of the style will be the identifer here
        let layer = MGLCircleStyleLayer(identifier: "Light-copy", source: source)
        
        
        // The source name from the source's TileJSON metadata: mapbox.com/api-documentation/#retrieve-tilejson-metadata
        // Notes  - Carlos Campos
        // Basically, the name of the DataSet
        
        // Notes  - Carlos Campos
        //This is a dictionary the library will take to draw the colors you want depending on a property attached to your source.
        //In my case, I added points with a property name Rank which are values from 1 to 5. I have assigned a color per value
        layer.sourceLayerIdentifier = "CAL1-0"
        let stops = [
            0: MGLStyleValue(rawValue: UIColor(red:0.22, green:0.53, blue:0.75, alpha:1.0)),
            10: MGLStyleValue(rawValue: UIColor(red:0.23, green:0.70, blue:0.82, alpha:1.0)),
            30: MGLStyleValue(rawValue: UIColor(red:0.34, green:0.72, blue:0.51, alpha:1.0)),
            45: MGLStyleValue(rawValue: UIColor(red:0.95, green:0.94, blue:0.46, alpha:1.0)),
            ]
        
        // Notes  - Carlos Campos
        // Style the circle layer color based on the above categorical stops
        //The attribute name will be the key value to compare with the "stops" source
        layer.circleColor = MGLStyleValue<UIColor>(interpolationMode: .interval,
                                                   sourceStops: stops,
                                                   attributeName: "Lux2 (459)",
                                                   options: nil)
        
        //I think if you want the circle bigger, add more value here
        layer.circleRadius = MGLStyleValue(rawValue: 4)
        
        style.addLayer(layer)
        
        style.addSource(source)
    }

}

