//
//  ContentView.swift
//  YouAreAwesome
//
//  Created by Jimmy Lin on 6/14/25.
//

import SwiftUI

struct ContentView: View {
    @State private var message = "I Am A Programmer!"
    private var messageHi = "bello"
    var body: some View {
        
        VStack {
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.orange)
            Text(message)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.red)
            Button("Click Me!") {
                message = "Awesome!"
            }
        }
        .padding()
        
    }
}

#Preview {
    ContentView()
}
