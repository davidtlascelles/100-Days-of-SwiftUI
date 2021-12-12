//
//  ContentView.swift
//  WeSplit
//
//  Created by David Lascelles on 12/12/21.
//

import SwiftUI

struct ContentView: View {
    let students = ["Harry", "Hermione", "Ron"]
    
    // Properties that store state should be @State wrapped.
    // If the property is only associated with this view, it should be private
    @State private var selectedStudent = "Harry"

    var body: some View {
        NavigationView {
            Form {
                Picker("Select your student", selection:
                    // $ character is for two-way binding. This reads and writes the state to the selectedStudent property
                    $selectedStudent) {
                    // \.self is a weird thing that basically says the way to distinguish between strings is the string itself. Not sure what the \. is about.
                    ForEach(students, id: \.self) {
                        // This is fancy closure syntax to just mean "Show the text view of the (only) paramter"
                        Text($0)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
