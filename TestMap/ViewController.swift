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
        mapView.setCenter(CLLocationCoordinate2D(latitude: 38.897, longitude: -77.039), zoomLevel: 10.5, animated: false)
        
        mapView.delegate = self
        view.addSubview(mapView)    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Wait until the style is loaded before modifying the map style.
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        
        
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
        
        // "mapbox://examples.2uf7qges" is the map ID referencing a tileset
        // created from the GeoJSON data uploaded earlier.
        let source = MGLVectorSource(identifier: "trees", configurationURL: URL(string: "mapbox://examples.2uf7qges")!)
        
        let layer = MGLCircleStyleLayer(identifier: "tree-style", source: source)
        
        // The source name from the source's TileJSON metadata: mapbox.com/api-documentation/#retrieve-tilejson-metadata
        layer.sourceLayerIdentifier = "yoshino-trees-a0puw5"
        
        
        let stops = [
            0: MGLStyleValue(rawValue: UIColor(red:1.00, green:0.72, blue:0.85, alpha:1.0)),
            2: MGLStyleValue(rawValue: UIColor(red:0.69, green:0.48, blue:0.73, alpha:1.0)),
            4: MGLStyleValue(rawValue: UIColor(red:0.61, green:0.31, blue:0.47, alpha:1.0)),
            7: MGLStyleValue(rawValue: UIColor(red:0.43, green:0.20, blue:0.38, alpha:1.0)),
            16: MGLStyleValue(rawValue: UIColor(red:0.33, green:0.17, blue:0.25, alpha:1.0))
        ]
        
        // Style the circle layer color based on the above categorical stops
        layer.circleColor = MGLStyleValue<UIColor>(interpolationMode: .interval,
                                                   sourceStops: stops,
                                                   attributeName: "AGE",
                                                   options: nil)
        
        layer.circleRadius = MGLStyleValue(rawValue: 3)
        
        style.addLayer(layer)
        
        style.addSource(source)
    }
    
    


}

