//
//  AddSafePlaceView.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

import SwiftUI

struct AddSafePlaceView: View {
    @Binding var isShowing: Bool
    var isFound: Bool = true
    
    @State var street = ""
    @State var city = ""
    @State var zip = ""

    
    @State private var curHeight: CGFloat = 500
    let minHeight: CGFloat = 500
    let maxHeight: CGFloat = 600
    
    let startOpacity: Double = 0.4
    let endOpacity: Double = 0.9
    
    var dragPercentage: Double {
        let res = Double((curHeight - minHeight) / (maxHeight - minHeight))
        return max(0, min(1, res))
    }
    var body: some View {
        
        ZStack(alignment: .bottom) {
            if isShowing {
                Color.black
                    .opacity(startOpacity + (endOpacity - startOpacity) * dragPercentage)
                    .ignoresSafeArea()
                    .onTapGesture { isShowing = false}
                
                mainView
                    .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
    }
    
        var mainView: some View {
            VStack {
                ZStack {
                    Capsule()
                        .frame(width: 40, height: 6)
                }
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.00001))
                .gesture(dragGesture)
        VStack {
            VStack{
                TextField("Street", text: $street) .padding()
                TextField("City", text: $city).padding()
                TextField("Zip", text: $zip).padding()
                    
            }
            .textFieldStyle(.roundedBorder)
         
         
            BasicButtonComponent(label: "Add", action: { print("Added")})
            Spacer()
              
                }
        .frame(maxHeight: .infinity)
            .padding(.bottom, 35)
            }
           
                .frame(height: curHeight)
                .frame(maxWidth: .infinity)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                        Rectangle()
                            .frame(height: curHeight / 2)
                    }
                        .foregroundColor(.white)
                )
                .onDisappear { curHeight = minHeight}
            
        }
    
    @State private var prevDragTransition = CGSize.zero

    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { val in
                let dragAmount = val.translation.height - prevDragTransition.height
                if curHeight > maxHeight || curHeight < minHeight {
                    curHeight -= dragAmount / 6
                } else {
                    curHeight -= dragAmount
                }
                
                prevDragTransition = val.translation
            }
            .onEnded { val in
                prevDragTransition = .zero
            }
    }
    }


struct AddSafePlaceView_Previews: PreviewProvider {
    static var previews: some View {
        AddSafePlaceView(isShowing: .constant(true))
    }
}
