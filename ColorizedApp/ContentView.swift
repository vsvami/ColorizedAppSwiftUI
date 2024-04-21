//
//  ContentView.swift
//  ColorizedApp
//
//  Created by Vladimir Dmitriev on 21.04.24.
//

import SwiftUI

enum FocusField {
    case redTF, greenTF, blueTF
}

struct ContentView: View {
    @State private var redValue = Double.random(in: 0...255)
    @State private var greenValue = Double.random(in: 0...255)
    @State private var blueValue = Double.random(in: 0...255)
    
    @State private var redTextFieldValue = ""
    @State private var greenTextFieldValue = ""
    @State private var blueTextFieldValue = ""
    
    @State private var isPresented = false
    
    @FocusState private var isTextFieldFocused: FocusField?
    
    var body: some View {
        ZStack {
            Color.backgroundBlue
                .ignoresSafeArea()
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    setValue()
                }
            
            VStack {
                ColorView(
                    redValue: redValue,
                    greenValue: greenValue,
                    blueValue: blueValue
                )
                .padding(.bottom, 30)
                
                colorSliderView(
                    value: $redValue,
                    textFieldValue: $redTextFieldValue,
                    isTextFieldFocused: _isTextFieldFocused, tintColor: .red,
                    field: .redTF
                )
                
                colorSliderView(
                    value: $greenValue,
                    textFieldValue: $greenTextFieldValue,
                    isTextFieldFocused: _isTextFieldFocused, tintColor: .green,
                    field: .greenTF
                )
                
                colorSliderView(
                    value: $blueValue,
                    textFieldValue: $blueTextFieldValue,
                    isTextFieldFocused: _isTextFieldFocused, tintColor: .blue,
                    field: .blueTF
                )
         
                Spacer()
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button("Done") {
                        setValue()
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    .alert("Wrong format", isPresented: $isPresented, actions: {}) {
                        Text("Please enter value from 0 to 255")
                    }
                }
            }
        }
    }
    
    private func checkValue(_ textFieldValue: String) -> Double {
        if let value = Double(textFieldValue), value >= 0, value <= 255  {
            return value
        } else {
            isPresented.toggle()
            return 0
        }
    }
    
    private func setValue() {
        switch isTextFieldFocused {
        case .redTF:
            redValue = checkValue(redTextFieldValue)
            redTextFieldValue = ""
        case .greenTF:
            greenValue = checkValue(greenTextFieldValue)
            greenTextFieldValue = ""
        case .blueTF:
            blueValue = checkValue(blueTextFieldValue)
            blueTextFieldValue = ""
        case nil:
            break
        }
    }
}

#Preview {
    ContentView()
}

struct colorSliderView: View {
    @Binding var value: Double
    @Binding var textFieldValue: String
    
    @FocusState var isTextFieldFocused: FocusField?
    
    let tintColor: Color
    let field: FocusField

    var body: some View {
        HStack {
            Text(lround(value).formatted())
                .frame(width: 40)
                .foregroundStyle(.white)
            Slider(value: $value, in: 0...255, step: 1)
                .tint(tintColor)
            TextField(lround(value).formatted(), text: $textFieldValue)
                .textFieldStyle(.roundedBorder)
                .frame(width: 45)
                .multilineTextAlignment(.trailing)
                .keyboardType(.numberPad)
                .focused($isTextFieldFocused, equals: field)
        }
    }
}
