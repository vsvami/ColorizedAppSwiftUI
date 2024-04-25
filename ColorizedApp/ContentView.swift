//
//  ContentView.swift
//  ColorizedApp
//
//  Created by Vladimir Dmitriev on 21.04.24.
//

import SwiftUI

struct ContentView: View {
    @State private var red = Double.random(in: 0...255).rounded()
    @State private var green = Double.random(in: 0...255).rounded()
    @State private var blue = Double.random(in: 0...255).rounded()
    
    @FocusState private var focusedField: FocusField?
    
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                ColorView(redValue: red, greenValue: green, blueValue: blue)
                
                VStack {
                    ColorSliderView(value: $red, color: .red)
                        .focused($focusedField, equals: .red)
                    ColorSliderView(value: $green, color: .green)
                        .focused($focusedField, equals: .green)
                    ColorSliderView(value: $blue, color: .blue)
                        .focused($focusedField, equals: .blue)
                }
                .frame(height: 150)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button(action: previousField) {
                            Image(systemName: "chevron.up")
                        }
                        Button(action: nextField) {
                            Image(systemName: "chevron.down")
                        }
                        Spacer()
                        Button("Done") {
                            focusedField = nil
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .background(.backgroundBlue)
            .onTapGesture {
                focusedField = nil
            }
        }
    }
}

extension ContentView {
    enum FocusField {
        case red, green, blue
    }
    
    private func nextField() {
        switch focusedField {
        case .red:
            focusedField = .green
        case .green:
            focusedField = .blue
        case .blue:
            focusedField = .red
        case .none:
            focusedField = nil
        }
    }
    
    private func previousField() {
        switch focusedField {
        case .red:
            focusedField = .blue
        case .green:
            focusedField = .red
        case .blue:
            focusedField = .green
        case .none:
            focusedField = nil
        }
    }
}

#Preview {
    ContentView()
}
