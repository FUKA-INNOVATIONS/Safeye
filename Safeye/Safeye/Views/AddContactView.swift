//
//  AddContactView.swift
//  Safeye
//
//  Created by gintare on 9.4.2022.
//

import SwiftUI

struct AddContactView: View {
    @Binding var isShowing: Bool
    @State var searchInput: String
    @EnvironmentObject var AddContactVM: AddContactViewModel
        
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
            
            ZStack {
                VStack {
                    
                    //  Search for contact with a code
                    SearchFieldComponent(searchInput: $searchInput)
                        .onChange(of: searchInput) {_ in
                            AddContactVM.findProfile(searchCode: searchInput)
                        }
                    // Button(action: { isShowing = false}, label: {Text("Close")})
                    Spacer()
                    //  If searched code matches an existing profile, display avatar, full name and 'add' button
                    if AddContactVM.profileFound {
                        AvatarComponent(size: 100)
                        Text("\(AddContactVM.trustedContactDetails?.fullName ?? "No name")")
                        BasicButtonComponent(label: "Add", action: { AddContactVM.addTrustedContact()})
                    } else {
                        Text("User not found.")
                    }
                    
                    
                    Spacer()
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



struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(isShowing: .constant(true), searchInput: "123")
    }
}
