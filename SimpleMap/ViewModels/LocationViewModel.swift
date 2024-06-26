import SwiftUI
import _MapKit_SwiftUI
import MapKit

class LocationViewModel : ObservableObject {
    
    // All Locations
    @Published var locations : [Location]
    // Current location on Map
    @Published var currentLocation : Location {
        didSet {
            updateMapRegion(location: currentLocation)
        }
    }
    
    @Published var mapRegion : MKCoordinateRegion = MKCoordinateRegion() {
        didSet {
            updateMapPosition(mapRegion: mapRegion)
        }
    }
    
    @Published var showLocationList : Bool = false
    
    @Published var mapPosition : MapCameraPosition?
    
    let mapSpan : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.currentLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
        self.updateMapPosition(mapRegion: MKCoordinateRegion(center: locations.first!.coordinates, span: mapSpan))
    }
    
    
    private func updateMapRegion(location : Location){
        self.mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
    }
    
    private func updateMapPosition(mapRegion : MKCoordinateRegion){
        self.mapPosition = MapCameraPosition.region(mapRegion)
    }
    
    func toggleLocationList(){
        withAnimation(.linear(duration: 0.2)){
            showLocationList.toggle()
        }
    }
    
    func selectLocation(location : Location){
        withAnimation(.easeInOut(duration: 0.2)){
            currentLocation = location
            showLocationList = false 
        }
    }
}
