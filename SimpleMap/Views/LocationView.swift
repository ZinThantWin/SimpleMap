import SwiftUI
import MapKit

struct LocationView : View {
    @EnvironmentObject private var vm : LocationViewModel
    var body: some View {
        ZStack{
            Map(position: Binding(
                get: { vm.mapPosition ?? MapCameraPosition.region(vm.mapRegion) },
                set: { newValue in vm.mapPosition = newValue }
            )){
                UserAnnotation()
            }
            VStack{
                header.padding()
                Spacer()
            }
        }
        
    }
}

extension LocationView {
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
}


#Preview {
    LocationView().environmentObject(LocationViewModel())
}
