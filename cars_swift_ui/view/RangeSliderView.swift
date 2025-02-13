//
//  RangeSliderView.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 13.02.25.
//
// inspired by https://medium.com/@eastism/two-value-slider-of-swiftui-0585cc87bbf2
//

import SwiftUI

typealias TwoCGFloatAction = (CGFloat, CGFloat) -> Void

struct RangeSliderView: View {
    @Binding var start: Int
    @Binding var end: Int
    @State var startSpace: CGFloat = 0
    @State var endSpace: CGFloat = 0
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none  // Ensure no decimal formatting is applied
        return formatter
    }()
    
    let diamete: CGFloat = 10
    let color: Color = .black
    let bounds: ClosedRange<Int>
    
    init(start: Binding<Int>, end: Binding<Int>, bounds: ClosedRange<Int>) {
        self._start = start
        self._end = end
        self.bounds = bounds
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            VStack(spacing: 12) {
                HStack {
                    ZStack {
                        Line()
                            .opacity(0.2)
                        
                        HStack(spacing: 0) {
                            Color.clear
                                .frame(width: startSpace)
                            Control(width: Int(geometry.size.width - diamete))
                            Color.clear
                                .frame(width: endSpace)
                        }
                        
                    }.frame(height: 5)
                        .padding(.horizontal)
                }
                
                Text("\(numberFormatter.string(from: NSNumber(value: start)) ?? "") - \(numberFormatter.string(from: NSNumber(value: end)) ?? "")")
            }
            .onAppear() {
                initStartAndEndSpace(geometry.size.width)
            }
        }).frame(height: 50)
    }
    
    func Line() -> some View {
        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
            .fill(color)
            .frame(height: 5)
    }
    
    func Point(width: Int, gestureChange: @escaping TwoCGFloatAction) -> some View {
        Circle()
            .fill(color)
            .frame(height: 15)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        gestureChange(CGFloat(width), value.translation.width)
                    })
            )
    }
    
    func Control(width: Int) -> some View {
        ZStack {
            Line()
            HStack {
                Point(width: width, gestureChange: changeStart)
                Spacer()
                Point(width: width, gestureChange: changeEnd)
            }
        }
    }
    
    func initStartAndEndSpace(_ width: CGFloat) {
        endSpace = CGFloat(bounds.upperBound - end) / CGFloat(bounds.count) * width
        startSpace = CGFloat(start - bounds.lowerBound) / CGFloat(bounds.count) * width
    }

    func changeStart(_ width: CGFloat, _ move: CGFloat) {
        DispatchQueue.main.async {
            startSpace = changeStartSpace(width, move)
            start = Int((startSpace/width) * CGFloat(bounds.count)) + bounds.lowerBound
        }
    }

    func changeStartSpace(_ width: CGFloat, _ move: CGFloat) -> CGFloat {
        let v = startSpace + move
        if v < 0 {
            return 0
        }
        let over = width - endSpace - diamete * 2
        if v > over {
            return over
        }
        return v
    }

    func changeEnd(_ width: CGFloat, _ move: CGFloat) {
        DispatchQueue.main.async {
            endSpace = changeEndSpace(width, move)
            end = bounds.upperBound - Int((endSpace/width) * CGFloat(bounds.count))
        }
    }

    func changeEndSpace(_ width: CGFloat, _ move: CGFloat) -> CGFloat {
        let v = endSpace - move
        if v < 0 {
            return 0
        }

        let over = width - startSpace - diamete * 2
        if v > over {
            return over
        }
        return v
    }
}


#Preview {
    RangeSliderView(start: .constant(1), end: .constant(3), bounds: 1...10)
}
