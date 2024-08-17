//
//  LongPressToActionButton.swift
//  Thready AI
//
//  Created by Apple on 16/08/24.
//

import Foundation
import SwiftUI


struct LongPressToActionButton: View {
    @State private var state: ActionState = .preStart
    @ObservedObject var vm: AskMeAnyThingViewModel
    let activeTime = 5.0
    @State var timeRemaining: CGFloat = .infinity
    @Binding var askMeInput: String

    var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    private let ringSize: CGFloat = 40
    private let lineWidth: CGFloat = 4
    @GestureState var isPressing = false


    var body: some View {
        ZStack {
            Image(systemName: state == .finish ? "checkmark" : "mic.circle")
                .padding()
                .foregroundStyle(Color.white)
                .font(.system(size: 20, weight: .bold))
                .opacity(state == .pressing ? 0.6 : 1)
                .gesture(LongPressGesture(minimumDuration: 0.01)
                            .sequenced(before: LongPressGesture(minimumDuration: .infinity))
                            .updating($isPressing) { value, states, transaction in
                                switch value {
                                case .second(true, nil):
                                    states = true
                                    vm.startRecording()


                                default:
                                    break
                                }
                            })
                        .onChange(of: isPressing) { value in
                            if timeRemaining < 0 {
                                if state == .pressing {
                                    state = .loading
                                }
                                return
                            }
         
                            if isPressing {
                                state = .pressing
                            } else {
                                state = .preStart
                                withAnimation {
                                    timeRemaining = activeTime
                                }
                            }
                            
                            if value == false {
                                performAction()

                            }
                    }
            
//                .onLongPressGesture(minimumDuration: 2.0, perform: {
//                    // guard state == .loading else {return}
//
//                     Task {
//                         state = .loading
//                         await performAction()
//                         DispatchQueue.main.async {
//                             do {
//                                 state = .finish
//                             }catch {
//                                 state = .finish
//
//                             }
//
//                         }
//                     }
//                 }, onPressingChanged: { isPressing in
//
//                 })

            IndicatorView(progress: (activeTime - timeRemaining) / activeTime, ringSize: ringSize, lineWidth: lineWidth, shouldSpin: state == .loading)
        }
        .onReceive(timer, perform: { _ in
            if state == .pressing {
                if timeRemaining > 0 {
                    withAnimation {
                        timeRemaining = timeRemaining - 1
                    }
                }
            }
        })
        .onAppear {
            timeRemaining = activeTime
        }
    }
    
    func performAction()  {
        Task {
            state = .loading
            try? await vm.stopRecording()
            askMeInput = vm.speechText
            state = .finish
        }
    }
}

private enum ActionState {
    case preStart
    case pressing
    case loading
    case finish
}





struct IndicatorView: View {

    var progress: CGFloat
    
    let ringSize: CGFloat
    let lineWidth: CGFloat
    
    @State private var rotationAngle = -90.0
    var shouldSpin: Bool = false


    var body: some View {
        ZStack {

            // progress
            if !shouldSpin {
                // background
                Circle()
                    .stroke(
                        Color.white.opacity(0.3),
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                       
                    )
                    .frame(width: ringSize, height: ringSize)

                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        Color.white,
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                       
                    )
                    .frame(width: ringSize, height: ringSize)
                
            } else {
                Circle()
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [Color.white, Color.white.opacity(0.3)]),
                            center: .center,
                            startAngle: .degrees(0),
                            endAngle: .degrees(360)
                        ),
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                       
                    )
                    .frame(width: ringSize, height: ringSize)

                
                // round cap
                Circle()
                    .frame(width: lineWidth, height: lineWidth)
                    .foregroundColor(Color.white)
                    .offset(x: ringSize/2)
            
            }
        }
        .rotationEffect(.degrees(rotationAngle))
        .onChange(of: shouldSpin){
            if (shouldSpin) {
                rotationAngle = 0
                withAnimation(.linear(duration: 2)
                        .repeatForever(autoreverses: false)) {
                    rotationAngle = 360.0
                }
            } else {
                rotationAngle = -90
            }
        }
    }
    
}
