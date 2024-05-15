import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            

                GeometryReader { geo in

                    
                    Image("Background")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    
                VStack{
                    Image("PracticeLogo")
                        .resizable()
                        .padding()
                        .scaledToFit()
                    
                    let color = Color(hex: "2F3338")
                    NavigationLink(destination: OneDeviceView()) {
                        Text("Table Match")
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(color))
                    }

                    NavigationLink(destination: HostJoinView()) {
                        Text("Stats")
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(color))
                    }
                    
                    NavigationLink(destination: SettingsView()) {
                        Text("Settings")
                            .foregroundColor(.white)
                            .font(.system(size: 40))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(color))
                    }
                }
            }
        }
    }
}

private extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


#Preview {
    HomeView()
}
