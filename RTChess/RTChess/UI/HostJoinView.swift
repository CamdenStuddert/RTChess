import SwiftUI
import SwiftData

struct HostJoinView: View {
    @Query var query: [UserData]

    var userData: UserData {
        if(query.isEmpty) {
            return UserData()
        } else {
            return query[0]
        }
    }
    
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
                        Text("Black Wins: \(userData.tableMatches.blackWins)")
                        Text("White Wins: \(userData.tableMatches.whiteWins)")
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
