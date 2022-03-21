//
//  GameView.swift
//  GameStream
//
//  Created by ANA on 3/20/22.
//

import SwiftUI
import AVKit
import Kingfisher

struct GameView: View {
    
    var url:String
    var title:String
    var study:String
    var calification: String
    var yearOfPublication: String
    var description:String
    var tags:[String]
    var imgsUrl: [String]
    
    var body: some View {
        
        ZStack{
            
            Color("background").ignoresSafeArea()
            
            VStack {
                video(url: url).frame(height:300)
                
                
                ScrollView {
                
                   //Video information
                   
                    videoInfo(title:title,study:study,calification:calification,yearOfPublication:yearOfPublication,description:description,tags:tags)
                        .padding(.bottom)
                    
                    Gallery(imgsUrl:imgsUrl)
                
                }.frame( maxWidth: .infinity)
            }
        }
    }
}

struct video:View {
    
    var url:String
    
    var body: some View{
        
        VideoPlayer(player: AVPlayer(url: URL(string: url)!)).ignoresSafeArea()
    }
}

struct videoInfo:View {
    
    var title:String
    var study:String
    var calification:String
    var yearOfPublication:String
    var description:String
    var tags:[String]
    
    var body: some View{
        
        VStack(alignment:.leading ){
            
          Text("\(title)")
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding(.leading)
            
            HStack{
                
                
                Text("\(study)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top,5)
                    .padding(.leading)
                
                Text("\(calification)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top,5)
                
                Text("\(yearOfPublication)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top,5)
                
            }
            
           Text("\(description)")
                .foregroundColor(.white)
                .font(.subheadline)
                .padding(.top,5)
                .padding(.leading)
            
            HStack{
                
                ForEach(tags, id:\.self){
                    
                    tag in
                    
                    Text("#\(tag)")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding(.top,4)
                        .padding(.leading)
                }
            }
        }.frame( maxWidth: .infinity,  alignment: .leading)
    }
}

struct Gallery:View {
    
    var imgsUrl:[String]
    
    let formaGrid = [
    
        GridItem(.flexible())
    
    ]
    
    var body: some View{
        
        VStack(alignment:.leading ){
           
           Text("GALERRY")
            .foregroundColor(.white)
            .font(.title)
            .padding(.leading)
            
            ScrollView(.horizontal){
              
                LazyHGrid(rows:formaGrid,spacing:8){
                    
                    
                    ForEach(imgsUrl,id: \.self){
                        
                       imgUrl in
                        
                       //Deploy images from server via url
                        
                        KFImage(URL(string: imgUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                    }
                }
                
            }.frame( height: 180)
            
            videoComments()
  
        }.frame( maxWidth: .infinity, alignment: .leading)
     
    }
}

struct videoComments: View {
    let screenWidth = UIScreen.main.bounds.width
    var text1 = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five (...)"
    var text2 = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    @State var textToShow = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five (...)"
    var buttonShowMoreText1 = "See more"
    var buttonShowMoreText2 = "See less"
    @State var buttonShowMoreText = "See more"
    
    @State var textCompleteIsActive : Bool = false
    
    @State var isShowMyCommentIsActive : Bool = true
    
    
    var body: some View {
        VStack (alignment:.leading){
            HStack{
                Text("COMMENTS").font(.title3).foregroundColor(.white).fontWeight(.bold).frame(minWidth: 0, maxWidth: .infinity, alignment: .leading).padding(.leading)//.padding(.top).padding(.bottom, -15)
//                Button(action: {isMostrarMiComentarioActive = true}, label: {
//                    Image(systemName: "plus.bubble").foregroundColor(.white)
//                })
                Button(action: {isShowMyCommentIsActive = true}, label: {
                    Image(systemName: "square.and.pencil").foregroundColor(.white)
                }).padding(.trailing)
                
            }.padding(.top, 30)
            
            if(isShowMyCommentIsActive){
                VStack{
                    HStack{
                        Image("profile").resizable().aspectRatio( contentMode: .fit).frame(width: 50, height: 50, alignment: .center)
                        VStack{
                            Text("Alvy Baack").fontWeight(.bold).foregroundColor(Color("")).font(.subheadline)//.padding(.top, 5).padding(.leading)
                            Spacer().frame(height: 10)
                            Text("Two days ago").foregroundColor(.white).font(.subheadline)//.padding(.top, 5)
                        }.padding(.leading, 10)
                        
                        Spacer()
                        Button(action: {}, label: {
                            Image(systemName: "pencil").foregroundColor(.white).padding()
                        })
                        Button(action: {isShowMyCommentIsActive.toggle()}, label: {
                            Image(systemName: "trash").foregroundColor(.white)
                        })
                        
                        
                    }.frame(maxWidth: .infinity, alignment: .leading).padding().padding(.bottom,-15).padding(.leading,-5)
                    Text("I have seen that on average it has a great rating, and I completely agree. It is the best game I have ever played without a doubt, it combines a good plot with a great free-play experience thanks to its huge map and activities.").foregroundColor(.white).font(.subheadline).padding().padding(.top,-15).padding(.leading,-5)
                }.background(Color("colorTab")).cornerRadius(8.0).frame(width: (screenWidth-30), alignment: .center).padding()
            }
            
            VStack{
                HStack{
                    Image("profile").resizable().aspectRatio( contentMode: .fit).frame(width: 50, height: 50, alignment: .center)
                    VStack{
                        Text("Geoff Atto").fontWeight(.bold).foregroundColor(.white).font(.subheadline)//.padding(.top, 5).padding(.leading)
                        Spacer().frame(height: 10)
                        Text("Six days ago").foregroundColor(.white).font(.subheadline)//.padding(.top, 5)
                    }.padding(.leading, 10)
                    
                }.frame(maxWidth: .infinity, alignment: .leading).padding().padding(.bottom,-15).padding(.leading,-5)
                Text(textToShow).foregroundColor(.white).font(.subheadline).padding().padding(.top,-15).padding(.leading,-5)
                
                ////IF text > n =>
                Button(action:{
                    textCompleteIsActive.toggle()
                    if !textCompleteIsActive{
                        textToShow = text1
                        buttonShowMoreText = buttonShowMoreText2
                    }else{
                        textToShow = text2
                        buttonShowMoreText = buttonShowMoreText2
                    }
                    
                } , label: {
                    Text(buttonShowMoreText)
                        .foregroundColor(.white)
                        .frame(maxWidth: 100, alignment: .center)
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                }).background(Color("colorTab")).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/).padding().padding(.top, -30)
                
            }.background(Color("colorTab")).cornerRadius(8.0).frame(width: (screenWidth-30), alignment: .center).padding()
            
            
        }.frame(maxWidth: .infinity, alignment: .leading)
        
        Button(action:{} , label: {
            Text("Load more comments")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
        }).background(Color("colorTab")).cornerRadius(8.0).padding()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(url: "ejemplo",title:"Sonic The Hedgehog",
                 study: "Sega",
                 calification: "E+",
                 yearOfPublication: "1991",
                 description: "Sega Genesis game released in 1991 with over 40 million copies currently sold",
                 tags:["plataformas","mascota"],
                 imgsUrl: [ "https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg","https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg","https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg"
             ])
    }
}

