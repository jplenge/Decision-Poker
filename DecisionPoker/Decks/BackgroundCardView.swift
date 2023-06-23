//
//  SuitsView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 25.05.23.
//  Copyright © 2023 Jodi Szarko. All rights reserved.
//
import SwiftUI

struct BackgroundCardView: View {
#if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
#endif
    
    var cols = 20
    var rows = 20
    
    var body: some View {
        VStack {
            GeometryReader { gr in
                let width = gr.size.width / CGFloat(cols)
                let height = gr.size.height / CGFloat(rows)
                
                VStack(spacing:0) {
                    ForEach(0..<rows) { _ in
                        HStack(spacing:0) {
                            Group {
                                ForEach(0..<cols) { _ in
                                    SuitsView()
                                        .scaleEffect(0.25)
                                        .frame(width: width, height: height)
                                }
                            }
                        }
                    }
                }
            }
            .frame(width: 1600, height: 1600)
        }
        .background(theme.currentBackgroundColor)
        .opacity(0.4)
    }
}

struct SuitsView: View {
#if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
#endif
    
    var frameWidth: CGFloat = 60
    var frameHeight: CGFloat = 60
    
    var body: some View {
        VStack(spacing:60) {
            HStack(spacing:60) {
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 50))
                    path.addQuadCurve(to: CGPoint(x: 50, y: 0),
                                      control: CGPoint(x: 40, y: 40))
                    path.addQuadCurve(to: CGPoint(x: 100, y: 50),
                                      control: CGPoint(x: 60, y: 40))
                    path.addQuadCurve(to: CGPoint(x: 50, y: 100),
                                      control: CGPoint(x: 60, y: 60))
                    path.addQuadCurve(to: CGPoint(x: 0, y: 50),
                                      control: CGPoint(x: 40, y: 60))
                    path.closeSubpath()
                }
                .fill(Color.red)
                .frame(width: frameWidth, height: frameHeight)
                .scaleEffect(0.9)
                
                Path { path in
                    path.move(to: CGPoint(x: 50, y: 0))
                    path.addQuadCurve(to: CGPoint(x: 10, y: 43),
                                      control: CGPoint(x: 40, y: 30))
                    path.addArc(center: CGPoint(x: 20, y: 60),
                                radius: 20.0,
                                startAngle: Angle(degrees: -100),
                                endAngle: Angle(degrees: 50),
                                clockwise: true)
                    path.addLine(to: CGPoint(x: 40, y: 65))
                    path.addQuadCurve(to: CGPoint(x: 30, y: 90),
                                      control: CGPoint(x: 45, y: 80))
                    path.addQuadCurve(to: CGPoint(x: 30, y: 100),
                                      control: CGPoint(x: 20, y: 98))
                    path.addLine(to: CGPoint(x: 70, y: 100))
                    path.addQuadCurve(to: CGPoint(x: 70, y: 90),
                                      control: CGPoint(x: 80, y: 98))
                    path.addQuadCurve(to: CGPoint(x: 60, y: 65),
                                      control: CGPoint(x: 55, y: 80))
                    path.addArc(center: CGPoint(x: 80, y: 60),
                                radius: 20.0,
                                startAngle: Angle(degrees: 140),
                                endAngle: Angle(degrees: -70),
                                clockwise: true)
                    path.addQuadCurve(to: CGPoint(x: 50, y: 0),
                                      control: CGPoint(x: 60, y: 30))
                    path.addLine(to: CGPoint(x: 50, y: 0))
                    path.closeSubpath()
                }
                .fill(Color.black)
                .frame(width: frameWidth, height: frameHeight)
                .scaleEffect(0.9)
            }
            
            HStack(spacing:50) {
                Path { path in
                    path.move(to: CGPoint(x: 70, y: 30))
                    path.addCurve(to: CGPoint(x: 30, y: 30),
                                  control1: CGPoint(x: 100, y: -10),
                                  control2: CGPoint(x: 0, y: -10))
                    path.addLine(to: CGPoint(x: 45, y: 45))
                    path.addCurve(to: CGPoint(x: 45, y: 70),
                                  control1: CGPoint(x: -15, y: 0),
                                  control2: CGPoint(x: -15, y: 120))
                    
                    path.addLine(to: CGPoint(x: 45, y: 70))
                    path.addLine(to: CGPoint(x: 30, y: 100))
                    path.addLine(to: CGPoint(x: 70, y: 100))
                    path.addLine(to: CGPoint(x: 55, y: 70))
                    path.addLine(to: CGPoint(x: 55, y: 70))
                    
                    path.addCurve(to: CGPoint(x: 55, y: 45),
                                  control1: CGPoint(x: 115, y: 120),
                                  control2: CGPoint(x: 115, y: 0))
                    
                    path.addLine(to: CGPoint(x: 70, y: 30))
                    path.closeSubpath()
                }
                .fill(Color.black)
                .frame(width: frameWidth, height: frameHeight)
                .scaleEffect(0.9)
                
                Path { path in
                    path.move(to: CGPoint(x: 50, y: 25))
                    path.addCurve(to: CGPoint(x: 0, y: 25),
                                  control1: CGPoint(x: 50, y: -10),
                                  control2: CGPoint(x: 0, y: 0))
                    path.addCurve(to: CGPoint(x: 50, y: 100),
                                  control1: CGPoint(x: 0, y: 60),
                                  control2: CGPoint(x: 50, y: 80))
                    path.addCurve(to: CGPoint(x: 100, y: 25),
                                  control1: CGPoint(x: 50, y: 80),
                                  control2: CGPoint(x: 100, y: 60))
                    path.addCurve(to: CGPoint(x: 50, y: 25),
                                  control1: CGPoint(x: 100, y: 0),
                                  control2: CGPoint(x: 50, y: -10))
                }
                .fill(Color.red)
                .frame(width: frameWidth, height: frameHeight)
                .scaleEffect(0.9)
            }
            Spacer()
        }
    }
}
