import SwiftUI

struct LocationOverview: View {
    let location : Location
    let cornerRadius : Double = 5
    @EnvironmentObject var vm : LocationViewModel
    var body: some View {
        HStack(alignment: .bottom,spacing : 0){
            VStack(alignment: .leading){
                imageSection
                titleSection
            }
            Spacer()
            VStack{
                learnMoreButton
                nextButton
            }
        }
        .padding(20)
        .background(RoundedRectangle(cornerRadius: cornerRadius)
            .fill(.ultraThinMaterial)
            .offset(y : 65)
            .cornerRadius(cornerRadius))
    }
}

extension LocationOverview {
    private var titleSection : some View{
        VStack(alignment: .leading){
            Text(location.name)
                .font(.title)
                .fontWeight(.bold)
            Text(location.cityName)
        }
    }
    
    private var imageSection : some View {
        Image(location.imageNames.last!)
            .resizable()
            .frame(width: 100, height: 100)
            .scaledToFill()
            .cornerRadius(cornerRadius)
            .padding(.all,5)
            .background(Color.white)
            .cornerRadius(cornerRadius)
    }
    
    private var learnMoreButton : some View{
        Button{
            vm.showSheet = true
        } label: {
            Text("Learn more")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
        .tint(.red)
    }
    
    private var nextButton : some View{
        Button{
            vm.onTapNext()
        } label: {
            Text("Next")
                .font(.headline)
                .foregroundColor(.red)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
        .tint(.secondary)
    }
}

#Preview {
    ZStack{
        Color.pink.opacity(0.5).ignoresSafeArea()
        LocationOverview(location: LocationsDataService.locations.first!).environmentObject(LocationViewModel())
    }
}
