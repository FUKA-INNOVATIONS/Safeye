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
        
    @State private var curHeight: CGFloat = 500
    let minHeight: CGFloat = 500
    let maxHeight: CGFloat = 600
    
    let startOpacity: Double = 0.8
    let endOpacity: Double = 0.9
    
    var dragPercentage: Double {
        let res = Double((curHeight - minHeight) / (maxHeight - minHeight))
        return max(0, min(1, res))
    }
    
    
    
    ///////////
    @EnvironmentObject var ConnectionVM: ConnectionViewModel
    @EnvironmentObject var ProfileVM: ProfileViewModel
    @EnvironmentObject var appState: Store
    @State var error = ""
    
    
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
                    VStack {
                        SearchFieldComponent(searchInput: $searchInput)
                        Button(action: {
                            if searchInput == appState.profile?.connectionCode {
                                print("You can not add your self as trusted contact")
                                error = "You can not add your self as trusted contact"
                                return
                            }
                            
                            ProfileVM.getProfileByConnectionCode(withCode: searchInput)
                        }, label: {Text("Search")})
                    }

                    Spacer()
                    //  If searched code matches an existing profile, display avatar, full name and 'add' button
                    if appState.profileSearch != nil {
                        AvatarComponent(size: 100)
                        Text("\(appState.profileSearch?.fullName ?? "No name")")
                        BasicButtonComponent(label: "Add", action: {
                            // AddContactVM.addTrustedContact()
                            if appState.profileSearch != nil {
                                ConnectionVM.addConnection()
                            }
                            searchInput = ""
                            appState.profileSearch = nil
                        })
                    } else {
                        Text("Nothing to display.")
                        Text(self.error)
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
                if curHeight > maxHeight {
                    curHeight -= dragAmount / 6
                } else if curHeight < minHeight {
                    isShowing = false
                } else {
                    curHeight -= dragAmount
                }
                
                prevDragTransition = val.translation
            }
//            .onEnded { val in
//                prevDragTransition = .zero
//            }
    }
}



struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(isShowing: .constant(true), searchInput: "")
    }
}
