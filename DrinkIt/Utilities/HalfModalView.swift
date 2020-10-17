//
//  HalfModalView.swift
//  HalfModalView
//
//  Created by Christopher Guirguis on 3/11/20.
//  Copyright © 2020 Christopher Guirguis. All rights reserved.
//

import SwiftUI

struct HalfModalView<Content: View> : View {
    @GestureState private var dragState = DragState.inactive
    @Binding var isShown:Bool
    @EnvironmentObject var model:Model
    private func onDragEnded(drag: DragGesture.Value) {
        let dragThreshold = modalHeight * (2/3)
        if drag.predictedEndTranslation.height > dragThreshold || drag.translation.height > dragThreshold{
            isShown = false
        }
    }
    
    var modalHeight:CGFloat = 350
    
    
    var content: () -> Content
    var body: some View {
        let drag = DragGesture()
            .updating($dragState) { drag, state, transaction in
                state = .dragging(translation: drag.translation)
        }
        .onEnded(onDragEnded)
        return Group {
            ZStack {
                //Background
                Spacer()
                    .edgesIgnoringSafeArea(.all)
//                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                    .background(isShown ? Color.black.opacity( 0.5 * fraction_progress(lowerLimit: 0, upperLimit: Double(modalHeight), current: Double(dragState.translation.height), inverted: true)) : Color.clear)
                    .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                    .gesture(
                        TapGesture()
                            .onEnded { _ in
                                self.isShown = false
                        }
                )
                if isShown{
                    //Foreground
                    VStack{
                        Spacer()
                        ZStack{
                            Color("sheetColor").opacity(1.0)
                                .frame(width: UIScreen.main.bounds.size.width, height:modalHeight)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            self.content()
                                .padding()
                                .padding(.bottom, 65)
                                .frame(width: UIScreen.main.bounds.size.width, height:modalHeight)
                                .clipped()
                        }
                        .offset(y: (self.dragState.isDragging && dragState.translation.height >= 1) ?       dragState.translation.height : 0)
                        .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                        .gesture(drag)
                        
                        
                    }
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

enum DragState {
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}



func fraction_progress(lowerLimit: Double = 0, upperLimit:Double, current:Double, inverted:Bool = false) -> Double{
    var val:Double = 0
    if current >= upperLimit {
        val = 1
    } else if current <= lowerLimit {
        val = 0
    } else {
        val = (current - lowerLimit)/(upperLimit - lowerLimit)
    }
    
    if inverted {
        return (1 - val)
        
    } else {
        return val
    }
    
}


struct XButton : View {
    
    @Binding var isShown:Bool

    var body: some View{
        HStack{
            Button(action: {
                self.isShown = false
            }, label: {
                Image(systemName: "multiply")
                    .foregroundColor(.primary)
            })
            
            Spacer()
        }
    }
}

