//
//  gamesView.swift
//  GameStream
//
//  Created by ANA on 3/20/22.
//

import SwiftUI
import Kingfisher

struct gamesView: View {
    
    /*The view communicates with the viewmodel*/
    @ObservedObject var allGames = ViewModel()
    
    @State var gameViewIsActive: Bool = false
    @State var url:String = ""
    @State var title:String = ""
    @State var study:String = ""
    @State var calification:String = ""
    @State var yearOfPublication:String = ""
    @State var description: String = ""
    @State var tags:[String] = [""]
    @State var imgsUrl:[String] = [""]
    
    
    let formaGrid = [
        
        GridItem(.flexible()),
        
        GridItem(.flexible())
        
    ]
    
    var body: some View {
        
        ZStack{
        
            Color("background").ignoresSafeArea()
            
            VStack{
                
                Text("Games")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 64, trailing: 0))
                
                ScrollView{
                    
                    LazyVGrid(columns:formaGrid, spacing:8){
                        ForEach(allGames.gamesInfo, id: \.self){
                            
                            game in 
                            
                            Button(action:{
                             
                                url = game.videosUrls.mobile
                                title = game.title
                                study = game.studio
                                calification = game.contentRaiting
                                yearOfPublication = game.publicationYear
                                description = game.description
                                tags = game.tags
                                imgsUrl = game.galleryImages
                                
                            // print("Press game \(title)")
                                
                                gameViewIsActive = true
                                
                            }, label: {
                                
                                KFImage(URL(string: game.galleryImages[0])!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit).clipShape(RoundedRectangle.init(cornerRadius: 4))
                                    .padding(.bottom, 12)
                            })
                        }
                }
                
            }.padding(.horizontal, 6)
                
                //The data of the selected game is passed
                
                NavigationLink( destination: GameView(url: url, title: title, study: study, calification: calification, yearOfPublication: yearOfPublication, description:description , tags: tags, imgsUrl: imgsUrl),
                    isActive: $gameViewIsActive,
                    label: {
                        EmptyView()
                    })
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear(
                perform: {
                    print("First element of the json \(allGames.gamesInfo[0])")
                    
                    print("Title of the first game of the json \(allGames.gamesInfo[0].title)")
                }
            )
    }
}

struct gamesView_Previews: PreviewProvider {
    static var previews: some View {
        gamesView()
    }
}

}
