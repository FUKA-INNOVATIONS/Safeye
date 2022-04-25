//
//  AddSafePlaceView.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

import SwiftUI
import MapKit


struct AddSafePlaceView: View {
    @Binding var isShowing: Bool
    @State var selectedLocation: MKMapItem?
    @StateObject private var result = SearchResultModel()
    @EnvironmentObject var SafePlaceVM: SafePlaceViewModel
    
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
                Color(UIColor.systemBackground)
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
            .background(Color(UIColor.systemBackground))
            .gesture(dragGesture)
            VStack {
                
                NavigationView {
                    
                    VStack {
                        Text("Found \(result.locations.count) places")
                            .frame(width: 100, height: 20)
                        List(result.locations, id: \.self) { place in
                            HStack {
                                Text(place.name!)
                                Spacer()
                                Button("Save") {
                                    print("Safe place: saving")
                                    print("Safe place: Selected place name: \(place)")
                                    let didSave = SafePlaceVM.createSafePlace(place)
                                    print("Safe place: didSave?: \(didSave)")
                                    isShowing = false
                                }
                            }
                        }
                    }
                    .navigationTitle("Enter address here")
                    .searchable(text: $result.searchText)
                    
                }
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
                .foregroundColor(Color(UIColor.systemBackground))
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
