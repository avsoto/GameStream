//
//  Home.swift
//  GameStream
//
//  Created by ANA on 3/20/22.
//

import SwiftUI
import AVKit

struct Home: View {
    
    @State var tabSelected:Int = 2
    
    var body: some View {
        
        TabView(selection: $tabSelected){
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }.tag(0)
            
            gamesView()
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Games")
                }.tag(1)
            
            homeView().tabItem {
                Image(systemName: "house")
                Text("Home")
                }.tag(2)
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }.tag(3)
            
        }.accentColor(.white)
    }
    
    init() {
        
        UITabBar.appearance().barTintColor = UIColor(Color("colorTab"))
        UITabBar.appearance().isTranslucent = true
        
        print("Starting HomeView")
        
    }
}

struct homeView:View {
    
    @State var searchText = ""
    
    var body: some View{
        
        ZStack{
            
            Color("background").ignoresSafeArea()
            
            VStack{
                
                Image("appLogo").resizable().aspectRatio(contentMode: .fit).frame(width: 250).padding(11.0)
                
                ScrollView(showsIndicators: false){
                    SubModuleHome()
                    
                }//.clipped()
                
            }.padding(.horizontal, 18)
        }.navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
//    func searchMethod(){
//        print("El usuario está buscando \(searchText)")
 //   }
}

struct SubModuleHome:View{
    
    @State var searchText = ""
    @State var isGameInfoEmpty = false
    
    @ObservedObject var gameFound = SearchGame()
    @State var isGameViewActive = false
    
    @State var url:String = ""
    @State var title:String = ""
    @State var study:String = ""
    @State var calification:String = ""
    @State var yearOfPublication:String = ""
    @State var description: String = ""
    @State var tags:[String] = [""]
    @State var imgsUrl:[String] = [""]
    
    var body: some View{
        
        VStack{
            
            HStack{
                Button(action: {
                    
                    watchGame(name: searchText)
                    
                }, label: {
                    Image(systemName: "magnifyingglass").foregroundColor(searchText.isEmpty ? Color(.yellow) : Color("darkCian")
                                                                         
                    )
                }).alert(isPresented: $isGameInfoEmpty){
                    
                    Alert(title: Text("Search failed"), message: Text("No game found."), dismissButton: .default(Text("OK")))
                }
                
                ZStack(alignment: .leading){
                    
                    if searchText.isEmpty{
                        Text("Search a video").foregroundColor(Color(red:174/255 , green: 177/255, blue: 185/255, opacity: 1.0))
                    }
                    
                    TextField("", text: $searchText).foregroundColor(.white)
                }
                
            }
            .padding([.top, .leading, .bottom], 11.0)
            .background(Color("colorTab"))
            .clipShape(Capsule())
            
            
            Text("THE MOST POPULAR")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .padding(.top)
            
            ZStack{
                
                Button(action: {
                  watchGame(name: "The Witcher 3")
                    
                }, label: {
                    
                    VStack(spacing: 0){
                        
                        Image("The Witcher 3").resizable().scaledToFill()
                        Text("The Witcher 3").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            .background(Color("colorTab"))
                    }
                })
                
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 42, height: 42)
                
            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
            .padding(.vertical)
            
            Text("SUGGESTED CATEGORIES FOR YOU")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            
            
            ScrollView(.horizontal, showsIndicators: false){
                
                HStack{
                    Button(action: {}, label: {
                        
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 8).fill(Color("colorTab"))
                                .frame(width: 160, height: 90)
                            Image("sniper")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42)
                        }
                    })
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 8).fill(Color("colorTab"))
                                .frame(width: 160, height: 90)
                            Image("sword")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42)
                        }
                    })
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 8).fill(Color("colorTab"))
                                .frame(width: 160, height: 90)
                            Image("world")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42)
                        }
                    })
                }
            }.padding(.bottom)
            
            
            Text("RECOMMENDED FOR YOU")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false){
                
                HStack{
                    Button(action: {
                        watchGame(name: "Abzu")
                    }, label: {
                        
                        Image("Abzu")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                        
                    })
                    
                    Button(action: {
                        watchGame(name: "Crash Bandicoot")
                    }, label: {
                        
                        Image("Crash Bandicoot")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                        
                    })
                    
                    Button(action: {
                        watchGame(name: "DEATH STRANDING")
                    }, label: {
                        
                        Image("DEATH STRANDING")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                        
                    })
                }
            }.padding(.bottom)
            
            Text("VIDEOS YOU MIGHT LIKE")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack  {
                    Button(action: {
                        watchGame(name: "Cuphead")
                    }){
                        Image("Cuphead")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                    
                    
                    Button(action: {
                        watchGame(name: "Grand Theft Auto V")
                    }) {
                        Image("Grand Theft Auto V")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                    
                    Button(action: {
                       watchGame(name: "Hades")
                    }){
                        Image("Hades")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                }
            }
            .padding(.bottom, 30)
        }
        
        NavigationLink(
            destination: GameView(url: url, title: title, study: study, calification: calification, yearOfPublication: yearOfPublication, description: description, tags: tags, imgsUrl: imgsUrl),
            isActive: $isGameViewActive,
            label: {
                EmptyView()
            })
        
    }
    
    func watchGame(name: String) {
      
        gameFound.search(gameName: name)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3){
            print("Quantity E:  \(gameFound.gameInfo.count)")
            
            if gameFound.gameInfo.count == 0{
                isGameInfoEmpty = true
            }
            else {
                url = gameFound.gameInfo[0].videosUrls.mobile
                title = gameFound.gameInfo[0].title
                study = gameFound.gameInfo[0].studio
                calification = gameFound.gameInfo[0].contentRaiting
                yearOfPublication = gameFound.gameInfo[0].publicationYear
                description = gameFound.gameInfo[0].description
                tags = gameFound.gameInfo[0].tags
                imgsUrl = gameFound.gameInfo[0].galleryImages
                
                isGameViewActive = true
            }
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
