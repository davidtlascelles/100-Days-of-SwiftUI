//
//  ContentView.swift
//  UnitConverter123
//
//  Created by David Lascelles on 1/1/22.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedUnitCategory: UnitCategory = .temperature
    @State private var selectedInitialUnit: Temperature = .celcius
    @State private var selectedResultUnit: Temperature = .fahrenheit
    
    enum UnitCategory: String, Equatable, CaseIterable {
        case temperature = "Temp"
        case distance = "Distance"
        case time = "Time"
        case volume = "Volume"
    }
    
    enum Temperature: String, Equatable, CaseIterable {
        case celcius = "°C"
        case fahrenheit = "°F"
        case kelvin = "°K"
    }
    
    enum Distance {
        case meters
        case feet
        case yards
        case miles
    }
    
    enum Time {
        case seconds
        case minutes
        case hours
        case days
        case weeks
        case months
        case years
    }
    
    enum Volume {
        case liters
        case cups
        case pints
        case quarts
        case gallons
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Unit Category", selection: $selectedUnitCategory) {
                        ForEach(UnitCategory.allCases, id: \.self) {
                            Text("\($0.rawValue)")
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Unit Category")
                }
                Section {
                    Picker("Initial Unit", selection: $selectedInitialUnit) {
                        ForEach(Temperature.allCases, id: \.self) {
                            Text("\($0.rawValue)")
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Initial Unit")
                }
                Section {
                    Picker("Result Unit", selection: $selectedResultUnit) {
                        ForEach(Temperature.allCases, id: \.self) {
                            Text("\($0.rawValue)")
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Result Unit")
                }
            }.navigationTitle("Unit Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
