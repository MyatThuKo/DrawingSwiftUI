//
//  ContentView.swift
//  Drawing
//
//  Created by Myat Thu Ko on 6/5/20.
//  Copyright © 2020 Myat Thu Ko. All rights reserved.
//

import SwiftUI

struct MyRectangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        
        return path
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct ColorCyclingRectangle: View {
    
    var amount = 0.0
    var steps = 400
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .fill(self.color(for: value, brightness: 1))
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
    
}

struct ContentView: View {
    
    @State private var rotationDegree: Double = 0
    @State private var lineWidth: CGFloat = 5
    @State private var showGradient = false
    @State private var colorCycle = 0.0
    
    var body: some View {
        NavigationView {
            ZStack {
                if showGradient {
                    ColorCyclingRectangle(amount: self.colorCycle)
                        .edgesIgnoringSafeArea(.all)
                } else {
                    LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                }
                VStack {
                    Spacer()
                    ZStack {
                        Triangle()
                            .stroke(Color.white, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                            .frame(width: 45, height: 50)
                        MyRectangle()
                            .stroke(Color.white, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                            .frame(width: 20, height: 100)
                            .offset(y: 75)
                    }
                    .rotationEffect(.degrees(rotationDegree))
                    .animation(.spring())
                    .offset(x: 0, y: -250)
                    
                    Group {
                        Text("Degree: \(self.rotationDegree, specifier: "%g")")
                        Slider(value: $rotationDegree, in: -360...360, step: 1)
                            .padding(.horizontal)
                        
                        Text("Line Width: \(self.lineWidth, specifier: "%g")")
                        Slider(value: $lineWidth, in: 1...15, step: 1)
                            .padding(.horizontal)
                        
                        Text("Gradient Controller:")
                        Slider(value: $colorCycle)
                            .padding(.horizontal)
                        
                    }
                }
            }
            .navigationBarItems(trailing: Toggle(isOn: $showGradient) {
                Text("Show Gradient")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
