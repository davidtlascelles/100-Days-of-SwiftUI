//
//  ContentView.swift
//  UnitConverter123
//
//  Created by David Lascelles on 1/1/22.
//

import SwiftUI

protocol MeasurementType: CaseIterable {}

enum Temperature: String, CaseIterable, MeasurementType {
    case celcius = "°C"
    case fahrenheit = "°F"
    case kelvin = "°K"
}

enum Distance: String, CaseIterable, MeasurementType{
    case meters
    case feet
    case yards
    case miles
}

enum Time: String, CaseIterable, MeasurementType {
    case seconds
    case minutes
    case hours
    case days
    case weeks
    case months
    case years
}

enum Volume: String, CaseIterable, MeasurementType {
    case liters
    case cups
    case pints
    case quarts
    case gallons
}

struct ContentView: View {
    private let initUnitString = "Initial Unit"
    private let resultUnitString = "Result Unit"
    //@State private var selectedUnitCategory: Unit.Category = .temperature
    @State private var selectedInitialUnit: Temperature = .celcius
    @State private var selectedResultUnit: Temperature = .fahrenheit
    @State private var inputValue = 0.0
    @FocusState private var inputIsFocused: Bool
    
    var toCelcius: Double {
        let temp = inputValue
        switch selectedInitialUnit {
        case .celcius:
            return temp
        case .kelvin:
            return temp - 273.15
        case .fahrenheit:
            return temp - 32 * 5 / 9
        }
    }
    
    var toKelvin: Double {
        let temp = inputValue
        switch selectedInitialUnit {
        case .celcius:
            return temp + 273.15
        case .kelvin:
            return temp
        case .fahrenheit:
            return temp - 32 * 5 / 9 + 273.15
        }
    }
    
    var toFahrenheit: Double {
        let temp = inputValue
        switch selectedInitialUnit {
        case .celcius:
            return temp * 9 / 5 + 32
        case .kelvin:
            return temp - 273.15 * 9 / 5 + 32
        case .fahrenheit:
            return temp
        }
    }
    
    var outputValue: Double {
        switch selectedResultUnit {
        case .celcius:
            return toCelcius
        case .fahrenheit:
            return toFahrenheit
        case .kelvin:
            return toKelvin
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("\(outputValue.formatted())\(selectedResultUnit.rawValue)" )
                            .font(.custom("biggerTitle", size: 75, relativeTo: .largeTitle))
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                }
                Section {
                    Text("Initial Unit").listRowSeparator(.hidden)
                    Picker(initUnitString, selection: $selectedInitialUnit){
                        ForEach(Temperature.allCases, id: \.self) { Text("\($0.rawValue)") }
                    }.pickerStyle(.segmented)
                    Text("Result Unit")
                    Picker(initUnitString, selection: $selectedResultUnit){
                        ForEach(Temperature.allCases, id: \.self) { Text("\($0.rawValue)") }
                    }.pickerStyle(.segmented).listRowSeparator(.hidden)
                }

                Section {
                    HStack {
                        TextField("Input", value: $inputValue, format: .number)
                            .font(.body)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                            .focused($inputIsFocused)
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                }
            }.navigationTitle("Unit Converter")
             .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
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
