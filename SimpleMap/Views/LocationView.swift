import SwiftUI
import MapKit

struct LocationView : View {
    @EnvironmentObject private var vm : LocationViewModel
    var body: some View {
        ZStack{
            if #available(iOS 17, *){
                ios17Map
            } else {
                lowerIOSVersionMap
            }
            VStack{
                header.padding()
                Spacer()
                locationPreview
            }
        }.fullScreenCover(isPresented: $vm.showSheet, content: {
            LocationDetailView()
        })
        
    }
}

extension LocationView {
    private var locationPreview : some View{
        ZStack{
            ForEach(vm.locations){location in
                if(location == vm.currentLocation){
                    LocationOverview(location: location)
                        .shadow(color: Color.black.opacity(0.25),radius: 10)
                        .padding()
                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                }
            }
        }
    }
    
    private var header : some View{
        VStack{
            Button(action: vm.toggleLocationList){
                Text("\(vm.currentLocation.name), \(vm.currentLocation.cityName)")
                    .foregroundStyle(Color.primary)
                    .fontWeight(.semibold)
                    .frame(height: 60)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .animation(.none, value: vm.currentLocation)
                    .overlay(alignment: .leading){
                        Image(systemName: "arrow.down")
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationList ? -180 : 0))
                    }
            }
            if vm.showLocationList {
                LocationListView()
            }
        }.background(.thickMaterial)
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.4), radius: 10,x: 0,y: 5)
    }
    
    private var ios17Map : some View {
        Map(coordinateRegion: $vm.mapRegion,annotationItems: vm.locations, annotationContent: {
            location in
            MapAnnotation(coordinate: location.coordinates){
                MapAnnotationView()
                    .scaleEffect(vm.currentLocation == location ? 1 : 0.7)
                    .onTapGesture {
                    vm.selectLocation(location: location)
                }
            }
        })
        .mapStyle(.standard(elevation: .realistic))
            .ignoresSafeArea()
    }
    
    
    private var lowerIOSVersionMap: some View {
        Map(coordinateRegion: $vm.mapRegion,annotationItems: vm.locations, annotationContent: {
            location in
            MapAnnotation(coordinate: location.coordinates){
                MapAnnotationView()
                    .scaleEffect(vm.currentLocation == location ? 1 : 0.8)
                    .onTapGesture {
                    vm.selectLocation(location: location)
                }
            }
        })
            .ignoresSafeArea()
    }
}


#Preview {
    LocationView().environmentObject(LocationViewModel())
}
