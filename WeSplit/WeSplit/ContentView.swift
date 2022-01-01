//
//  ContentView.swift
//  WeSplit
//
//  Created by David Lascelles on 12/12/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    let currencyCode = Locale.current.currencyCode ?? "USD"
    
    var body: some View {
        Form {
            Section {
                TextField("Amount", // <- Just placeholder text
                          // Two way bound property
                          // Using "value" instead of "text" since it is a number.
                          value: $checkAmount,
                          // Specify the kind of number is being provided
                          format: .currency(
                            // Locale struct contains all kinds of user localized preferences
                            code: Locale.current.currencyCode ?? "USD")
                ).keyboardType(.decimalPad)
            }
            Section {
                Text(checkAmount,
                     format: .currency(code: currencyCode)
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
