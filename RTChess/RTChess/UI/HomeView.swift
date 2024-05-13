//
//  HomeView.swift
//  RTChess
//
//  Created by Camden Studdert on 4/29/24.
//

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
                    
                    
                    NavigationLink(destination: HostJoinView()) {
                        Text("Host/Join")
                            .foregroundColor(.black)
                            .font(.system(size: 40))
                            .padding()
                            .border(.black, width: 4)
                            .padding()
                    }
                    NavigationLink(destination: OneDeviceView()) {
                        Text("Table Match")
                            .foregroundColor(.black)
                            .font(.system(size: 40))
                            .padding()
                            .border(.black, width: 4)
                            .padding()
                    }
                    NavigationLink(destination: SettingsView()) {
                        Text("Settings")
                            .foregroundColor(.black)
                            .font(.system(size: 40))
                            .padding()
                            .border(.black, width: 4)
                            .padding()
                    }
                }
            }
        }
    }
}


#Preview {
    HomeView()
}
