import SwiftUI
import Foundation
import MapKit

struct LocationDetailView: View {
    @EnvironmentObject var vm : LocationViewModel
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                imageTabBar
                Spacer()
                titleSection
                mapSection
            }
        }
        .ignoresSafeArea()
    }
}

extension LocationDetailView {
    private var imageTabBar : some View{
        ZStack(alignment: .topTrailing){
            TabView{
                ForEach(vm.currentLocation.imageNames,id: \.self){
                    eachImage in
                    Image(eachImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width)
                        .clipped()
                }
            }
            .frame(height: 500)
            .tabViewStyle(PageTabViewStyle())
            .shadow(color: Color.black.opacity(0.2) ,radius: 10, y: 15)
            Button(action: {vm.showSheet = false}) {
                Image(systemName : "x.circle.fill")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 45)
                
            }
        }
        .padding(.bottom, 20)
    }
    
    private var titleSection : some View{
        VStack(alignment: .leading) {
            Text(vm.currentLocation.name)
                .font(.title)
                .fontWeight(.semibold)
            Text(vm.currentLocation.cityName)
                .foregroundColor(.secondary)
            Divider()
            Text(vm.currentLocation.description)
                .font(.body)
            if let url = URL(string: vm.currentLocation.link) {
                Link("Read more on Wikipedia", destination: url)
                    .foregroundColor(.blue)
            } else {
                Text("Invalid URL")
                    .foregroundColor(.red)
            }
            Divider()
        }.padding(.horizontal, 20)
    }
    
    private var mapSection : some View{
        HStack(alignment: .center){
            Spacer()
            Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations) { location in
                MapAnnotation(coordinate: location.coordinates) {
                    MapAnnotationView()
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.9,height: UIScreen.main.bounds.width * 0.9)
            .cornerRadius(10)
            Spacer()
        }
        .onAppear{
            superPrint("hello")
        }
        .padding(.top, 20)
        .padding(.bottom, 50)
    }
}

#Preview {
    LocationDetailView().environmentObject(LocationViewModel())
}
