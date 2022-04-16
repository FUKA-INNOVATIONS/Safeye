//
//  AddSafePlaceView.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

import SwiftUI
import CoreLocation
import MapKit

struct AddSafePlaceView: View {
    
    var isFound: Bool = true
    
    @ObservedObject var mapData = AddSafePlaceViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    @State var locationManager = CLLocationManager()
    @State var name = ""
    
    
    var body: some View {
        
        
        
        ZStack {
            //Map View...
            SecondMapView()
            //using it as enviorment object so it can be used as a sub view...
                .environmentObject(mapData)
                .ignoresSafeArea(.all, edges: .all)
            
            
            VStack{
                
                VStack(spacing: 0) {
                    HStack{
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                        TextField("Search", text: $mapData.searchTxt)
                            .colorScheme(.light)
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(Color.white)
                }
                
                // Dispalying Results...
                
                if !mapData.places.isEmpty && mapData.searchTxt
                    != ""{
                    ScrollView{
                        VStack(spacing: 15){
                            ForEach(mapData.places){place in
                                Text(place.place.name ?? "")
                                    .foregroundColor(.mint)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading)
                                    .onTapGesture {
                                        mapData.selectPlace(place: place)
                                    }
                                
                                Divider()
                            }
                        }
                        .padding(.top)
                    }
                    .background(Color.white)
                }
                
                Spacer()
                
            }
            
            .padding()
            
            
            
            VStack{
                Spacer()
                Button(action: mapData.focusLocation, label: {
                    Image(systemName: "location.fill")
                        .font(.title2)
                        .padding(10)
                        .background(Color.primary)
                        .clipShape(Circle())
                })
                Button(action: mapData.updateMapType, label: {
                    Image(systemName: mapData.mapType ==
                            .standard ? "network" : "map")
                        .font(.title2)
                        .padding(10)
                        .background(Color.primary)
                        .clipShape(Circle())
                })
                
            }
            
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
            
            VStack{
                Spacer()

                BasicButtonComponent(label: "Cancel", action: {  self.dismiss()
                
                })
                    .padding()
            }
        }
        
        
        .onAppear(perform: {
            
            // Setting Delegate...
            locationManager.delegate = mapData
            locationManager.requestWhenInUseAuthorization()
        })
        .alert(isPresented: $mapData.permissionDenied, content: {
            Alert(title: Text("Permission Denied"), message:
                    Text("Please Enable Permission From Settings"),
                  dismissButton: .default(Text("Go To Settings"),
                                          action:{
                //Redirect user to settings...
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
        })
        .onChange(of: mapData.searchTxt, perform: { value in
            // searching places...
            
            let delay = 0.3
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay)
            {
                
                if value == mapData.searchTxt{
                    // search...
                    self.mapData.searchQuery()
                }
            }
        })
        
        
        
    }
    
    struct AddSafePlaceView_Previews: PreviewProvider {
        static var previews: some View {
            AddSafePlaceView()
        }
    }
    
}
