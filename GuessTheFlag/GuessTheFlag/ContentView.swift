//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by David Lascelles on 1/15/22.
//

import SwiftUI

struct UniformStyle: ViewModifier {
    var font: Font
    var color: Color
    func body(content: Content) -> some View {
        content
            .font(font.bold())
            .foregroundColor(color)
    }
}

extension View {
    func uniformText(font: Font = .largeTitle, color: Color = .white) -> some View {
        modifier(UniformStyle(font: font, color: color))
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var gameOver = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    @State private var round = 1
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    struct FlagImage: View {
        var country: String
        
        var body: some View {
            Image(country)
                .renderingMode(.original)
                .shadow(radius: 5)
        }
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(
                    red: 0.1,
                    green: 0.2,
                    blue: 0.5
                ), location: 0.3),
                .init(color: Color(
                    red: 1,
                    green: 0.1,
                    blue: 0.2
                ), location: 0.3)
            ], center: .top, startRadius: 300, endRadius: 700).ignoresSafeArea()
            LinearGradient(gradient: Gradient(
                colors: [Color(
                    red: 1,
                    green: 1,
                    blue: 1,
                    opacity: 0.01
                ), Color(
                    red: 0,
                    green: 0,
                    blue: 0,
                    opacity: 0.9
                )]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .uniformText()
                Text("Round: \(round)/8")
                    .uniformText(font: .title3)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(country: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .uniformText(font: .title)
                Spacer()
            }
            .padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
        .alert("Game Over!", isPresented: $gameOver) {
            Button("New Game", action: reset)
        } message: {
            Text("You scored \(score) out of 8.\nWould you like to start a new game?")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            scoreMessage = "Your score is \(score)"
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "That is the flag of \(countries[number])\nYour score is \(score)"
        }
        if round == 8 {
            gameOver = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        round += 1
    }
    
    func reset() {
        round = 1
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
