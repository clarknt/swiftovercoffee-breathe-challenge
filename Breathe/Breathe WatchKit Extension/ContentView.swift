//
//  ContentView.swift
//  Breathe WatchKit Extension
//
//  Created by clarknt on 2020-03-05.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var angle: Double = 0
    @State var scale: CGFloat = 0.1

    let opacity = 0.6

    let circles = 6
    let circlesSpacing = 360.0 / 6.0

    let duration = 4.0

    let angleRange = 120.0
    let scaleRange: CGFloat = 0.5

    let baseOffset: CGFloat = -57
    var currentOffset: CGFloat {
        baseOffset * scale / scaleRange
    }

    let redColor: Double = 100/256
    let greenColor: Double = 220/256
    let blueColor: Double = 225/256

    var body: some View {
        ZStack {
            ForEach(0..<circles, id: \.self) { i in
                Circle()
                    .foregroundColor(self.color(for: i))
                    .opacity(self.opacity)
                    // colorDodge works better in preview but shows nothing in simulator
                    .blendMode(.hardLight)
                    .offset(x: self.currentOffset, y: self.currentOffset)
                    .rotationEffect(Angle(degrees: self.angle + Double(i) * self.circlesSpacing))
                    .scaleEffect(self.scale)
                    .onAppear {
                        withAnimation(
                            Animation.easeInOut(duration: self.duration)
                                .repeatForever(autoreverses: true)
                        ) {
                            self.scale = self.scaleRange
                            self.angle = self.angleRange
                        }
                }
            }
        }
    }

    func color(for index: Int) -> Color {
        Color(red: redColor,
              green: greenColor + Double(index) * 3 / 256,
              blue: blueColor - Double(index) * 3 / 256)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
