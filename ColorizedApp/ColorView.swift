//
//  ColorView.swift
//  ColorizedApp
//
//  Created by Vladimir Dmitriev on 21.04.24.
//

import SwiftUI

struct ColorView: View {
    let redValue: Double
    let greenValue: Double
    let blueValue: Double
    
    var body: some View {
        Color.init(red: redValue/255, green: greenValue/255, blue: blueValue/255)
            .frame(height: 120)
            .clipShape(.rect(cornerRadius: 15))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.white, lineWidth: 4)
            )
    }
}

#Preview {
    ColorView(redValue: 100, greenValue: 100, blueValue: 100)
}
