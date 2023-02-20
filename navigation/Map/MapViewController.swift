
import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        
        return locationManager
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.mapType = .standard
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsUserLocation = true
        
        if #available(iOS 16, *) {
            let configuration = MKStandardMapConfiguration()
            configuration .emphasisStyle = .muted
            configuration.elevationStyle = .realistic
            mapView.preferredConfiguration = configuration
        }
        
        let longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotation))
        longPressGR.minimumPressDuration = 1.5
        mapView.addGestureRecognizer(longPressGR)
        
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(mapView)
        setupConstraints()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    
    @objc private func addAnnotation(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.recognized {
            let point = gestureRecognizer.location(in: mapView)
            let coordinates = mapView.convert(point, toCoordinateFrom: mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            mapView.addAnnotation(annotation)
            
            guard let myCoordinates = locationManager.location?.coordinate else {return}
            buildRouteOnMap(myLocation: myCoordinates, destination: coordinates)

        }
        
    }
    
    private func buildRouteOnMap(myLocation: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: myLocation))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .automobile
        
        let derictions = MKDirections(request: request)
        derictions.calculate {response, error in
            guard let result = response else {return}
            if let route = result.routes.first {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setCenter(myLocation, animated: true)
            }
        }
    }
    
    private func setupConstraints() {
        let safeArie = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeArie.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: safeArie.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: safeArie.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeArie.bottomAnchor)
        ])
    }
    

}

//MARK: Location manager delegate

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.setCenter(location.coordinate, animated: true)
            
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
            mapView.setRegion(region, animated: true)
            
            let currentLocationAnnotation = MKPointAnnotation()
            currentLocationAnnotation.coordinate = location.coordinate
            currentLocationAnnotation.title = "Вы сдесь"
            mapView.addAnnotation(currentLocationAnnotation)
     

        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    
    
}


//MARK: MapView delegate

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 10
        renderer.strokeColor = .blue
        
        
        return renderer
    }
    
}
