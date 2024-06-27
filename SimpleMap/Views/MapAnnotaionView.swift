import SwiftUI

struct MapAnnotationView: View {
    let accentColor = Color("AccentColor")
    var imageName: String?
    
    var body: some View {
        if let imageName = imageName {
            VStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 45, height: 45)
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.red, lineWidth: 4)
                    )
                    .padding(6)
                Image(systemName: "triangle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .rotationEffect(.degrees(180))
                    .offset(y: -18)
                    .foregroundColor(.red)
            }
        } else {
            VStack {
                Image(systemName: "map.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.red)
                    .cornerRadius(36)
                
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .rotationEffect(.degrees(180))
                .offset(y: -15)
                .foregroundColor(.red)
                
            }
            .padding(.bottom, 25)
        }
    }
}

#Preview {
    MapAnnotationView()
}
