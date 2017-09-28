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
        mapView.setCenter(CLLocationCoordinate2D(latitude: 13.6914782, longitude: -89.2146939), zoomLevel: 7, animated: false)
        
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
        let source = MGLVectorSource(identifier: "trees", configurationURL: URL(string: "mapbox://codercampos.cj83r6ar100v42rrwjqvsq8eg-684g5")!)
        
        // Notes  - Carlos Campos
        //This is the style attached to a source (mapid), this is created on MapBox Studio.
        //On the Tileset, you can create a style from that tileset and save it. The name of the style will be the identifer here
        let layer = MGLCircleStyleLayer(identifier: "Light-copy", source: source)
        
        
        // The source name from the source's TileJSON metadata: mapbox.com/api-documentation/#retrieve-tilejson-metadata
        // Notes  - Carlos Campos
        // Basically, the name of the DataSet
        layer.sourceLayerIdentifier = "ExampleCarlos"
        
        // Notes  - Carlos Campos
        //This is a dictionary the library will take to draw the colors you want depending on a property attached to your source.
        //In my case, I added points with a property name Rank which are values from 1 to 5. I have assigned a color per value
        let stops = [
            1: MGLStyleValue(rawValue: UIColor(red:1.00, green:0.72, blue:0.85, alpha:1.0)),
            2: MGLStyleValue(rawValue: UIColor(red:0.69, green:0.48, blue:0.73, alpha:1.0)),
            3: MGLStyleValue(rawValue: UIColor(red:0.61, green:0.31, blue:0.47, alpha:1.0)),
            4: MGLStyleValue(rawValue: UIColor(red:0.43, green:0.20, blue:0.38, alpha:1.0)),
            5: MGLStyleValue(rawValue: UIColor(red:0.33, green:0.17, blue:0.25, alpha:1.0))
        ]
        
        // Notes  - Carlos Campos
        // Style the circle layer color based on the above categorical stops
        //The attribute name will be the key value to compare with the "stops" source
        layer.circleColor = MGLStyleValue<UIColor>(interpolationMode: .interval,
                                                   sourceStops: stops,
                                                   attributeName: "Rank",
                                                   options: nil)
        
        //I think if you want the circle bigger, add more value here
        layer.circleRadius = MGLStyleValue(rawValue: 3)
        
        style.addLayer(layer)
        
        style.addSource(source)
    }
    
    


}

