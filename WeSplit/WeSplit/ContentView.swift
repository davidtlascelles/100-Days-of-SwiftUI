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
    @FocusState private var amountIsFocused: Bool
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let total = checkAmount + tipValue
        
        return total
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    let localizedCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount,
                              format: localizedCurrency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Enter check amount")
                }
                Section {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(.menu)
                } header: {
                    Text("Number of people")
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.wheel)
                     .frame(height: 95)
                } header: {
                    Text("Tip amount")
                }
                Section {
                    Text(totalPerPerson,
                         format: localizedCurrency
                    )
                } header: {
                    Text("Ammount per person")
                }
                Section {
                    Text(grandTotal, format: localizedCurrency)
                } header: {
                    Text("Check total")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }.navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
