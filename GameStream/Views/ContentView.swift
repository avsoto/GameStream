//
//  ContentView.swift
//  GameStream
//
//  Created by ANA on 3/19/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            ZStack {
                
                Spacer()
                
                Color(red: 19/255, green: 30/255, blue: 53/255, opacity: 1.0).ignoresSafeArea()
                
                
                VStack{
                    Image("appLogo").resizable().aspectRatio(contentMode: .fit).frame(width: 250).padding(.bottom, 42)
                
                    LoginAndRegisterView()
                }.padding(.top, 30)
                
            }.navigationBarHidden(true)
        }
    }
}

struct LoginAndRegisterView:View {
    
    /*If it is equal to true, it is because we are at the login screen*/
    @State var loginType = true;
    
    var body: some View{
        
        VStack{
            
            HStack {
                
                Spacer()
                
                Button("LOGIN") {
                    
                    loginType = true
                    
                    //print("Login screen")
                }
                .foregroundColor(loginType ? .white : .gray)
                
                Spacer()
                
                Button("REGISTER") {
                    
                    loginType = false
                    //print("Register screen")
                }
                .foregroundColor(loginType ? .gray : .white)
                
                Spacer()
            }
            
            Spacer(minLength: 42)
            
            if loginType == true {
                
                loginView()
                
            } else {
                
                registerView()
            }
            
        }
        
    }
}

struct loginView:View{
    
    @State var email = ""
    @State var password = ""
    @State var isPasswordVisible = false;
    @State var isViewHomeActive = false;
    @State var ifNotUserFound = false
    
    
    var body: some View{
        
        ScrollView{
            
            VStack(alignment: .leading){
                
                /*email data entry*/
                
                Text("Email").foregroundColor(Color("darkCian")).frame(width:300, alignment: .leading)
                
                
                ZStack(alignment: .leading){
                    
                    if email.isEmpty{
                        Text("johndoe45@gmail.com").font(.caption).foregroundColor(Color("lightGray"))
                        
                    }
                    
                    
                    TextField("", text: $email)
                    
                }
                
                Divider().frame(height: 1).background(Color("darkCian")).padding(.bottom)
                
                /*password data entry*/
                
                Text("Password").foregroundColor(.white)
                
                
                ZStack(alignment: .leading){
                    
                    if password.isEmpty{
                        Text("Enter your password").font(.caption).foregroundColor(Color("lightGray"))
                        
                    }
                    
                    HStack{
                        if isPasswordVisible{
                            TextField("", text: $password).foregroundColor(.white)
                        } else {
                            SecureField("", text: $password).foregroundColor(.white)
                        }
                        
                        Button(action: {
                            isPasswordVisible.toggle()
                        }, label: {
                            if isPasswordVisible{
                                Image(systemName: "eye.fill").foregroundColor(Color("darkCian"))
                            } else{
                                Image(systemName: "eye.slash").foregroundColor(Color("darkCian"))
                            }
                        })
                    }
                }
                
                Divider().frame(height: 1).background(Color("darkCian")).padding(.bottom)
                
                /*Forgot password text*/
                
                Button("Forgot password?", action: {})
                    .font(.footnote).frame(maxWidth: .infinity, alignment: .trailing).foregroundColor(Color("darkCian")).padding(.bottom)
                
                /*Login button
                
                Button(action: logIn, label: {
                    Text("LOGIN").fontWeight(.bold).foregroundColor(.white).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke( Color("darkCian"), lineWidth: 1.0).shadow(color: .white, radius: 6))
                })*/
                
                /*Login button*/
                
                Button(action: {logIn()},
                                       label:
                                       {
                                            Text("LOGIN").fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                                .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                                                .overlay(RoundedRectangle(cornerRadius: 6.0)
                                                .stroke(Color("darkCian"), lineWidth: 1.0)
                                                .shadow(color: .white, radius: 6))
                                       }).alert(isPresented: $ifNotUserFound, content:
                                                    {
                                                        Alert(title: Text("Login Failed"), message: Text("An unexpected error ocurred. Please try loggin in again."), dismissButton: .default(Text("OK")))
                                                    }
                                                         )
                
                Text("Sign in with social networks").foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top, 80)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                HStack{
                    
                    Spacer()
                    
                    Button("Facebook"){
                        
                        //print("Method to send to fb")
                        
                    }.foregroundColor(.white)
                    .font(.caption)
                    .frame(maxWidth: 125, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(EdgeInsets(top: 9, leading: 15, bottom:9, trailing: 15))
                    .background(RoundedRectangle(cornerRadius: 4)
                                    .foregroundColor(Color("facebookColor"))
                    )
                    
                    Spacer()
                    
                    Button("Twitter"){
                        
                        //print("Method to send to tw")
                        
                    }.foregroundColor(.white)
                    .font(.caption)
                    .frame(maxWidth: 125, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(EdgeInsets(top: 9, leading: 15, bottom:9, trailing: 15))
                    .background(RoundedRectangle(cornerRadius: 4)
                                    .foregroundColor(Color("twitterColor"))
                    )
                    
                    Spacer()
                }.padding(.top, 20)
            }.padding(.horizontal, 77.0)
            
            NavigationLink(
                destination: Home(),
                isActive: $isViewHomeActive,
                label: {
                    EmptyView()
                })
        }
        
    }
    
    func logIn()
        {
            print("I am signing in.")
            // Start login
            
            // Instance creation. In this case the SaveData class
            let dataUpdaterObject = SaveData()
       
            let result = dataUpdaterObject.validate(email: self.email, password: self.password)
            
            if result == true
            {
                // The Home screen is activated
                ifNotUserFound = false
                isViewHomeActive = true
            }else
            {
                ifNotUserFound = true
            }
        }
}

struct registerView:View{
    
    @State var name = "";
    @State var email = "";
    @State var password = "";
    @State var isPasswordVisible = false;
    @State var confirmPassword = "";
    @State var isViewHomeActive = false;
    @State var passwordIsNotConfirm = false;

    var body: some View{
        
        ScrollView{
            
            VStack(alignment: .center){
                
                Text("Choose a profile photo").fontWeight(.bold)
                    .foregroundColor(.white)
                Text("You can change or choose later").font(.footnote).foregroundColor(.white).fontWeight(.light).padding(.bottom)
                
                Button(action: takePhoto, label: {
                    
                    ZStack{
                        Image("profile").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
                        
                        Image(systemName: "camera").foregroundColor(.white)
                    }
                }).padding(.bottom, 10)
            }
            
           VStack{
                
            
            VStack(alignment: .leading){
                
                /*email data entry*/
                
                Text("Email*").foregroundColor(Color("darkCian")).frame(width:300, alignment: .leading)
                
                
                ZStack(alignment: .leading){
                    
                    if email.isEmpty{
                        Text("johndoe45@gmail.com").font(.caption).foregroundColor(Color("lightGray"))
                    }
                    
                    TextField("", text: $email)
                    
                }
                
                Divider().frame(height: 1).background(Color("darkCian")).padding(.bottom)
            
                /*password data entry*/
                
                Text("Password").foregroundColor(.white)
                
                ZStack(alignment: .leading){
                    
                    if password.isEmpty{
                        Text("Enter your password").font(.caption).foregroundColor(Color("lightGray"))
                        
                    }
                    
                    HStack{
                        if isPasswordVisible{
                            TextField("", text: $password).foregroundColor(.white)
                        } else {
                            SecureField("", text: $password).foregroundColor(.white)
                        }
                        
                        Button(action: {
                            isPasswordVisible.toggle()
                        }, label: {
                            if isPasswordVisible{
                                Image(systemName: "eye.fill").foregroundColor(Color("darkCian"))
                            } else{
                                Image(systemName: "eye.slash").foregroundColor(Color("darkCian"))
                            }
                        })
                    }
                }
                
                Divider().frame(height: 1).background(Color("darkCian")).padding(.bottom)
                
                /*confirm password entry*/
                
                Text("Confirm password*").foregroundColor(.white)
                
                ZStack(alignment: .leading){
                    
                    if password.isEmpty{
                        Text("Retype your password").font(.caption).foregroundColor(Color("lightGray"))
                    }
                    
                    HStack{
                        if isPasswordVisible{
                            TextField("", text: $confirmPassword).foregroundColor(.white)
                        } else {
                            SecureField("", text: $confirmPassword).foregroundColor(.white)
                        }
                        
                        Button(action: {
                            isPasswordVisible.toggle()
                        }, label: {
                            if isPasswordVisible{
                                Image(systemName: "eye.fill").foregroundColor(Color("darkCian"))
                            } else{
                                Image(systemName: "eye.slash").foregroundColor(Color("darkCian"))
                            }
                        })
                    }
                    
                }
                
                Divider().frame(height: 1).background(Color("darkCian")).padding(.bottom)
                
                /*Forgot password text*/
                
                Button("Forgot password?", action: {})
                    .font(.footnote).frame(maxWidth: .infinity, alignment: .trailing).foregroundColor(Color("darkCian")).padding(.bottom)
           }

            /*Login button
            
            Button(action: register, label: {
                Text("REGISTER").fontWeight(.bold).foregroundColor(.white).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke( Color("darkCian"), lineWidth: 1.0).shadow(color: .white, radius: 6))
            })*/
            
            /*Login button*/
            
            Button(action: {register()},
                                   label:
                                   {
                                        Text("REGISTER").fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                            .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                                            .overlay(RoundedRectangle(cornerRadius: 6.0)
                                            .stroke(Color("darkCian"), lineWidth: 1.0)
                                            .shadow(color: .white, radius: 6))
                                   }).alert(isPresented: $passwordIsNotConfirm, content:
                                                {
                                                    Alert(title: Text("Register Failed"), message: Text("An unexpected error occurred. Please, try loggin in again."), dismissButton: .default(Text("OK")))
                                                }
                                                     )


                //Navigate to the HomeView
                    NavigationLink(destination: Home(), isActive: $isViewHomeActive, label: {EmptyView()})

                //Buttons of login in with social networks
                
                Text("Sign in with social networks").foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                HStack{
                    
                    Button("Facebook"){
                        
                        // print("Method to send to fb")
                        
                    } .font(.caption)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(EdgeInsets(top: 9, leading: 15, bottom:9, trailing: 15))
                    .background(RoundedRectangle(cornerRadius: 4)
                                    .foregroundColor(Color("facebookColor"))
                    )
                    
                    Button("Twitter"){
                        
                        // print("Method to send to tw")
                        
                    }.foregroundColor(.white)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(EdgeInsets(top: 9, leading: 15, bottom:9, trailing: 15))
                    .background(RoundedRectangle(cornerRadius: 4)
                                    .foregroundColor(Color("twitterColor"))
                    )
                    Spacer()
                }.padding(.top, 20)
            }.padding(.horizontal, 77.0)
           
        }
    }
    
    func register()
    {
        
            print("I register with the mail \(email), password \(password) and password confirmation \(confirmPassword)")
        
        
            // Confirm that the password has been typed correctly
            if password != confirmPassword
            {
                passwordIsNotConfirm = true
            }else
            {
                // Confirmed password. The alert is not displayed.
                passwordIsNotConfirm = false
                
                // Object of the SaveData class.
                let dataUpdaterObject = SaveData()
                // Registro que no requiere nombre.
                let result = dataUpdaterObject.validate(email: self.email, password: self.password)
                
                // Activate the HomeView
                isViewHomeActive = true
                print("Se guardaron los datos con exito?: \(result)")
            }
        
        if password == confirmPassword{
          
            let dataUpdaterObject = SaveData()
            
            let result = dataUpdaterObject.saveData(email: email, password: password, name: "")
            
            print("Was the data saved successfully?: \(result)")
            
        }else{
            
            print("Different passwords, please try again.")
        }
    }
}

func takePhoto(){
    
   //print("Method to take photo")
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}


