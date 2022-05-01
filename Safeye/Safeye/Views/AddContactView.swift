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
        
    @State private var curHeight: CGFloat = 600
    let minHeight: CGFloat = 500
    let maxHeight: CGFloat = 700
    
    let startOpacity: Double = 0.8
    let endOpacity: Double = 0.9
    
    var dragPercentage: Double {
        let res = Double((curHeight - minHeight) / (maxHeight - minHeight))
        return max(0, min(1, res))
    }
    

    @EnvironmentObject var ConnectionVM: ConnectionViewModel
    @EnvironmentObject var ProfileVM: ProfileViewModel
    @EnvironmentObject var FileVM: FileViewModel
    @EnvironmentObject var appState: Store
    var translationManager = TranslationService.shared
    @State var error = "To search, enter a valid connection code."
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                Color(UIColor.systemBackground)
                    .opacity(startOpacity + (endOpacity - startOpacity) * dragPercentage)
                    .ignoresSafeArea()
                    .onTapGesture { withAnimation { isShowing = false } }
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
            
            ZStack {
                VStack {
                    
                    //  Search for contact with a code
                    VStack {
                        SearchFieldComponent(searchInput: $searchInput)
                        Button(action: {
                            ProfileVM.getProfileByConnectionCode(withCode: searchInput)
                        }, label: {Text(translationManager.searchBtn)})
                            .foregroundColor(.blue)
                            .buttonStyle(BorderlessButtonStyle())
                    }

                    Spacer()
                    //  If searched code matches an existing profile, display avatar, full name and 'add' button
                    if appState.profileSearch != nil {
                        
                        if appState.searchResultPhoto != nil {
                            ProfileImageComponent(size: 150, avatarImage: appState.searchResultPhoto!)
                                .padding(.bottom, 20)
                        } else {
                            ProgressView()
                                .onAppear {
                                    FileVM.fetchPhoto(avatarUrlFetched: appState.profileSearch?.avatar, isSearchResultPhoto: true, isTrustedContactPhoto: false)
                                }
                        }
                        
                        Text("\(appState.profileSearch?.fullName ?? "No name")")
                            .font(.title)
                            .padding(.bottom)
                        Button(action: {
                            DispatchQueue.main.async {
                                if appState.profileSearch != nil {
                                    let message = ConnectionVM.addConnection()
                                    if message != nil {
                                        self.error = message!
                                    }
                                }
                                searchInput = ""
                                appState.profileSearch = nil
                            }
                        }, label: {Text(translationManager.addBtn)})
                            .foregroundColor(.blue)
                            .buttonStyle(BorderlessButtonStyle())
                    } else {
                        VStack {
                            AnimationLottieView(lottieJson: "no-data")
                            //Text(self.error)
                        }
                        .frame(width: 150, height: 150, alignment: .center)
                        Text(self.error)
                            .frame(alignment: .center)
                            .padding()
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
                .foregroundColor(Color(UIColor.systemBackground))
        )
        .onDisappear {
            curHeight = 600
            searchInput = ""
            self.error = "To search, enter a valid connection code."
            appState.searchResultPhoto = nil
            appState.profileSearch = nil
        }
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
            .onEnded { val in
                prevDragTransition = .zero
            }
    }
}



struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(isShowing: .constant(true), searchInput: "")
    }
}
