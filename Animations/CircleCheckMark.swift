//
//  ContentView.swift
//  AnimationsPractice
//
//  Created by Vincent DeAugustine on 7/25/22.
//

import SwiftUI


struct ContentView: View {
    @State private var pct: Double = 0.0
    let duration: Double = 3
    var animation: Animation {
        return .linear(duration: duration).repeatForever(autoreverses: false)
    }
    @State private var trimEnd: CGFloat = 0
    @State private var rotate: Bool = false

    var body: some View {
        coolCheckMark()
            .trim(from: 0, to: trimEnd)
            .stroke(lineWidth: 4)
            .frame(width: 300, height: 300)
//            .rotationEffect(.degrees(45))
            .animation(animation, value: rotate)
            .onAppear() {
                withAnimation(animation, {
                    trimEnd = 1
                })
                rotate.toggle()
            }
                
    }
}

struct coolCheckMark: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        var radius: CGFloat {
            rect.width / 2
        }
        var angle: CGFloat { -35 }
        var x: CGFloat {
            .init(radius * cos(angle))
        }
        var y: CGFloat {
            .init(radius * sin(angle))
        }
        var endOfCheckMark: CGPoint {
            .init(x: x, y: y)
        }
        var center: CGPoint {
            .init(x: rect.midX, y: rect.midY)
        }
        p.move(to: .init(x: rect.width / 4, y: rect.maxY * 0.75))
        p.addLine(to: .init(x: rect.midX, y: rect.maxY))
        p.addArc(center: center, radius: radius, startAngle: .degrees(angle), endAngle: .degrees(angle + 0.0000000000001), clockwise: true)
        
        return p
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
