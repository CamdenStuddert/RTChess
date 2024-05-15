import SwiftUI

struct HostJoinView: View {
    var body: some View {
        
        GeometryReader { geo in
            
            Image("Background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            VStack {
                VStack{
                    Text("Table Matches")
                    HStack{
                        Text("Black Wins: \("")")
                        Text("White Wins: \("")")
                    }
                }
                //            VStack{
                //                Text("Multiplayer Matches")
                //                HStack{
                //                    Text("Wins: \("")")
                //                    Text("Losses: \("")")
                //                }
                //            }
            }
        }
    }
}

#Preview {
    HostJoinView()
}
