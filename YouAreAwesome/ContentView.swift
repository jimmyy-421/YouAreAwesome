//
//  ContentView.swift
//  YouAreAwesome
//
//  Created by Jimmy Lin on 6/14/25.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var message = ""
    @State private var imageName = ""
    @State private var lastMessageNumber = -1 // lastMessageNumber will never be -1
    @State private var lastImageNumber = -1
    @State private var audioPlayer: AVAudioPlayer!
    @State private var lastSoundNumber = -1
    @State private var soundIsOn = true
    let numberOfSounds = 5
    let numberOfImages = 9 // images labeled image0 - image9
    
    var body: some View {
        
        VStack {
            Text(message)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.red)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .frame(height: 100)
                .animation(.easeInOut(duration: 0.15), value: message)
            
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(radius: 30)
                .animation(.default, value: imageName)
            
            Spacer()
            
            HStack {
                Text("Sound On:")
                Toggle("", isOn: $soundIsOn)
                    .labelsHidden()
                    .onChange(of: soundIsOn) {
                        if audioPlayer != nil && audioPlayer.isPlaying {
                            audioPlayer.stop()
                        }
                    }
                
                Spacer()
                
                Button("Show Message") {
                    let messages = ["You Are Awesome!",
                                    "When the Genius Bar Needs Help, They Call You!",
                                    "You Are Great!",
                                    "You Are Fantastic!",
                                    "Fabulous? That's You!",
                                    "You Make Me Smile!",
                                    "When the Genius Bar Needs Help, They Call You!"]
                    
                    lastMessageNumber = nonRepeatingRandom(lastNumber: lastMessageNumber, upperBound: messages.count - 1)
                    message = messages[lastMessageNumber]
                    
                    lastImageNumber = nonRepeatingRandom(lastNumber: lastImageNumber, upperBound: numberOfImages - 1)
                    imageName = "image\(lastImageNumber)"
                    
                    lastSoundNumber = nonRepeatingRandom(lastNumber: lastSoundNumber, upperBound: numberOfSounds - 1)
                    if soundIsOn {
                        playSound(soundName: "sound\(lastSoundNumber)")
                    }
                }
                .buttonStyle(.borderedProminent)
                .font(.title2)
            }
            .tint(.accentColor)
        }
        .padding()
        
    }
    
    func playSound(soundName: String) {
        if audioPlayer != nil && audioPlayer.isPlaying {
            audioPlayer.stop()
        }
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("😡 Could not read file named \(soundName)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("😡 ERROR: \(error.localizedDescription) creating audioPlayer")
        }
    }
    
    func nonRepeatingRandom(lastNumber: Int, upperBound: Int) -> Int {
        var randomInt: Int
        repeat {
            randomInt = Int.random(in: 0...upperBound)
        } while randomInt == lastNumber
        return randomInt
    }
}


#Preview("Light Mode") {
    ContentView()
        .preferredColorScheme(.light)
}
#Preview("Dark Mode") {
    ContentView()
        .preferredColorScheme(.dark)
}
