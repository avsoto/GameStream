//
//  EditProfileView.swift
//  GameStream
//
//  Created by ANA on 3/20/22.
//

import SwiftUI

struct EditProfileView: View {
    @State var profilePicture: Image? = Image("profile")
    @State var isCameraActive = false
    
    var body: some View {
        ZStack {
            
            Color("background").ignoresSafeArea()
            
            ScrollView{
                  
                    VStack(alignment: .center){
                        
                        
                        Text("Edit profile")
                            .fontWeight(.bold)
                            .foregroundColor(Color.white).padding(.top, 20)
                       
                        Button(action: {isCameraActive = true}, label: {
                            ZStack{
                                
                                profilePicture!.resizable().aspectRatio(contentMode: .fill)
                                    .frame(width: 118.0, height: 118.0)
                                    .clipShape(Circle())
                                    .sheet(isPresented: $isCameraActive, content: {
                                        SUImagePickerView(sourceType: .photoLibrary , image: self.$profilePicture, isPresented: $isCameraActive)
                                })
                                
                                Image(systemName: "camera").foregroundColor(.white)
                            }
                        })
                        
                        Text("Choose a profile picture")
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                        
                    }.padding(.bottom, 18.0)
                    
                ModuleEdit()
            }
        }
    }
}

struct ModuleEdit:View {
    
    @State var email:String = ""
    @State var password:String = ""
    @State var name:String = ""
   
    var body: some View{
        
        VStack(alignment: .leading){
            
            Text("Email")
                .foregroundColor(Color(red: 63/255, green: 202/255, blue: 160/255, opacity: 1.0))
            
            ZStack(alignment: .leading){
                if email.isEmpty { Text("ejemplo@gmail.com").font(.caption).foregroundColor(Color(red: 174/255, green: 177/255, blue: 185/255, opacity: 1.0)) }
                
                TextField("", text: $email).foregroundColor(.white)
            }
            
            Divider()
                .frame(height: 1)
                .background(Color("darkCian")).padding(.bottom)
            
            Text("Password").foregroundColor(.white)
            
            ZStack(alignment: .leading){
                if password.isEmpty { Text("Enter your new password").font(.caption).foregroundColor(Color(red: 174/255, green: 177/255, blue: 185/255, opacity: 1.0)) }
                
                SecureField("", text: $password).foregroundColor(.white)
                
            }
            
            Divider()
                .frame(height: 1)
                .background(Color("darkCian")).padding(.bottom)
            
            Text("Name").foregroundColor(.white)
            
            ZStack(alignment: .leading){
                if name.isEmpty { Text("Enter your username").font(.caption).foregroundColor(Color(red: 174/255, green: 177/255, blue: 185/255, opacity: 1.0)) }
                
                TextField("", text: $name).foregroundColor(.white)
                
            }
            
            Divider()
                .frame(height: 1)
                .background(Color("darkCian")).padding(.bottom,32)
            
            Button(action: updateData, label: {
                                ZStack{
                                    Spacer().frame(maxWidth: .infinity, minHeight: 20, maxHeight: 20, alignment: .center)
                                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color("darkCian"), lineWidth: 2).shadow(color: .white, radius: 6))
                                    
                                    Text(String("Update data").uppercased())
                                        .fontWeight(.bold)
                                        .foregroundColor(.white).frame(maxWidth: .infinity, minHeight: 20, maxHeight: 20, alignment: .center)
                                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18)).background(Color("background")).cornerRadius(12)
                                }
                            })
        }.padding(.horizontal, 42.0)
    }
    
    func updateData()  {
        let dataUpdaterObject = SaveData()
        
        let result = dataUpdaterObject.saveData(email: email, password: password, name: name)
        
        print("Was the data saved successfully?: \(result)")
        
        print("To update")
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
