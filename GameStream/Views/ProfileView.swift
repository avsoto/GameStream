//
//  ProfileView.swift
//  GameStream
//
//  Created by ANA on 3/20/22.
//

import SwiftUI

struct ProfileView: View {
    
    @State var userName:String = "Nicolás Delgado"
    @State var imageProfile: UIImage = UIImage(named: "profile")!
    
    var body: some View {
        
            ZStack {
                
                Color("background").ignoresSafeArea().navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                
                VStack{
                        
                    Text("Profile").foregroundColor(.white)
                        .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, alignment: .center)
                        .padding()
                      
                        VStack{

                            Image(uiImage: imageProfile).resizable().aspectRatio(contentMode: .fill)
                                        .frame(width: 118.0, height: 118.0)
                                        .clipShape(Circle())
                   
                           Text(userName)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)

                        }.padding(EdgeInsets(top: 16, leading: 0, bottom: 32, trailing: 0))
                    
                        Text("Settings")
                            .fontWeight(.bold)
                            .foregroundColor(Color.white).frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity,  alignment: .leading).padding(.leading,18)
                    SettingsModule()
                    Spacer()
                }
            }.onAppear(
                
                perform: {
                    
                    //Image recovery method
                    
                    if returnUiImage(named: "profile") != nil {
                        
                        imageProfile = returnUiImage(named: "profile")!
                        
                    } else{
                        
                        print("I did not find a profile picture saved on the device.")
                    }
                    
                   print("Checking if I have data in user defaults.")
                    
                    if UserDefaults.standard.object(forKey: "userData") != nil {
                        
                        userName = UserDefaults.standard.stringArray(forKey: "userData")![2]
                        print("I found username \(userName)")
                    }else{
                        
                        print("I did not find username saved in global object of userdefaults.")
                    }
                }
            )
    }
    
    func returnUiImage(named: String) -> UIImage? {
        
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false){
            
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        
        return nil
    }
}

struct SettingsModule:View {
    
    @State var isToggleOn = true
    @State var isEditProfileViewActive = false
    
    var body: some View{
            
            VStack{
                     
                Button(action: {}, label: {
                        HStack {
                            
                            Text("Account")
                            .foregroundColor(Color.white)
                            Spacer()
                                Image(systemName: "chevron.right")
                        .foregroundColor(Color.white)}.padding()
                    
                }).background(Color("colorTab"))
                .clipShape(RoundedRectangle(cornerRadius: 1.0)).padding(.horizontal, 8.0)
                
                Button(action: {}, label: {
                        HStack {
                            
                        Text("Notifications")
                        .foregroundColor(Color.white)
                        
                            Spacer()
                        
                            Toggle("", isOn: $isToggleOn)
                        
                        }.padding()
                }) .background(Color("colorTab"))
                .clipShape(RoundedRectangle(cornerRadius: 1.0)).padding(.horizontal, 8.0)
                
                Button(action: {isEditProfileViewActive = true}, label: {
                        HStack {
                            
                        Text("Edit profile")
                        .foregroundColor(Color.white)
                        Spacer()
                        
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.white)}.padding()
                    
                }).background(Color("colorTab"))
                .clipShape(RoundedRectangle(cornerRadius: 1.0)).padding(.horizontal, 8.0)
                
               
                Button(action: {}, label: {
                        HStack {
                            
                        Text("Rate this app")
                        .foregroundColor(Color.white)
                        
                        Spacer()
                            
                            Image(systemName: "chevron.right")
                            .foregroundColor(Color.white)}.padding()
                    
                }) .background(Color("colorTab"))
                .clipShape(RoundedRectangle(cornerRadius: 1.0)).padding(.horizontal, 8.0)
                    
                NavigationLink(
                    destination: EditProfileView()
                    ,
                    isActive: $isEditProfileViewActive,
                    label: {
                        EmptyView()
                    })
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
