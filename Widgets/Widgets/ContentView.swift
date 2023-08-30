//
//  ContentView.swift
//  Widgets
//
//  Created by Sofia Sartori on 28/08/23.
//

import SwiftUI
import CoreLocation
import CoreMotion

struct ContentView: View {

    @State var progress: CGFloat = 0.2
    @State var startAnimation: CGFloat = 0
    var body: some View {

        GeometryReader { proxy in
            
            ZStack {
                Rectangle()
                    .frame(width: 320, height: 720)
                    .foregroundColor(.gray)
                    .opacity(0.3)
                    .cornerRadius(10)
                WaterWave(progress: progress, waveHeight: 0.015, offset: startAnimation)
                    .fill(.blue)
                    .mask {
                        Rectangle()
                            .frame(width: 300, height: 700)
                        
                    }
                    .overlay(alignment: .bottom ,content: {
                        Button {
                            progress += 0.05
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.blue)
                                .shadow(radius: 2)
                                .padding(25)
                                .background(.white, in: Circle())
                        }

                    })
                
            }.onAppear {
                withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                    startAnimation = proxy.size.width - 70
                }
            }
            //.frame(width: 300)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
