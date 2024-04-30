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


#Preview {
    HomeView()
}