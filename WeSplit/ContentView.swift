//
//  ContentView.swift
//  WeSplit
//
//  Created by Lexi Oliveira on 19/08/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    // One of the great things about the @State property wrapper is that it automatically watches
    // for changes, and when something happens it will automatically re-invoke the body property.
    // That’s a fancy way of saying it will reload your UI to reflect the changed state, and it’s
    // a fundamental feature of the way SwiftUI works.
    
    let currency = Locale.current.currency?.identifier ?? "USD"
    // Locale is a massive struct built into iOS that is responsible for storing all the user’s
    // region settings – what calendar they use, how they separate thousands digits in numbers,
    // whether they use the metric system, and more.
    
    @FocusState private var amountIsFocused: Bool
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }
    
    var totalPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = totalAmount / peopleCount

        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currency))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    // We can pass our Double to TextField and ask it to treat the input as a currency.
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Total amount") {
                    Text(totalAmount, format: .currency(code: currency))
                }
                
                Section("Amount per person") {
                    Text(totalPerson, format: .currency(code: currency))
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
