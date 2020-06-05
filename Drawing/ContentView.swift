//
//  ContentView.swift
//  Drawing
//
//  Created by Myat Thu Ko on 6/5/20.
//  Copyright © 2020 Myat Thu Ko. All rights reserved.
//

import SwiftUI

struct Rectangle: Shape {
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

struct ContentView: View {
    
    @State private var rotationDegree: Double = 0
    @State private var lineWidth: CGFloat = 10
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                Spacer()
                ZStack {
                    Triangle()
                        .stroke(Color.red, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                        .frame(width: 90, height: 100)
                    Rectangle()
                        .stroke(Color.red, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                        .frame(width: 30, height: 200)
                        .offset(y: 150)
                }
                .rotationEffect(.degrees(rotationDegree))
                .animation(.spring())
                .offset(x: 0, y: -300)
                
                Group {
                    Text("Degree: \(self.rotationDegree, specifier: "%g")")
                    Slider(value: $rotationDegree, in: 0...360, step: 1)
                        .padding([.horizontal, .bottom])
                    
                    Text("Line Width: \(self.lineWidth, specifier: "%g")")
                    Slider(value: $lineWidth, in: 0...25, step: 1)
                        .padding([.horizontal, .bottom])
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
