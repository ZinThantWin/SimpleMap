import SwiftUI

struct LocationListView : View {
    @EnvironmentObject private var vm : LocationViewModel
    var body: some View {
        List{
            ForEach(vm.locations){
                location in
                eachList(location: location)
                    .listRowBackground(Color.clear)
            }
        }.listStyle(.plain)
    }
}

extension LocationListView {
    
    private func eachList(location : Location) -> some View {
        HStack{
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .cornerRadius(5)
            }
            VStack(alignment: .leading){
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onTapGesture {
            vm.selectLocation(location: location)
        }
    }
}

#Preview {
    LocationListView().environmentObject(LocationViewModel())
}
