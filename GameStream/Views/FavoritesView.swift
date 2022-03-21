//
//  FavoritesView.swift
//  GameStream
//
//  Created by ANA on 3/20/22.
//

import SwiftUI
import AVKit

struct FavoritesView: View {
   
    @ObservedObject var allGames = ViewModel()
    
    var body: some View {

    //    @State var isGameViewActive:Bool = false
    //    @State var url:String = ""
    //    @State var titulo:String = ""
    //    @State var studio:String = ""
    //    @State var calificacion:String = ""
    //    @State var anoPublicacion:String = ""
    //    @State var descripcion:String = ""
    //    @State var tags:[String] = [""]
    //    @State var imgsUrl:[String] = [""]
            
            ZStack{
                
                Color("background").ignoresSafeArea()
                
                VStack() {
                    
                    Text("FAVORITES")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 9.0)
                    
                    ScrollView{
                        
                            ForEach(allGames.gamesInfo, id: \.self) { game in
                                
                                VStack(spacing: 0){
                                    
                                    //Bug with Video Player prevents hiding navigation bar
                                    VideoPlayer(player: AVPlayer(url: URL(string:  game.videosUrls.mobile)!)).frame( height: 300)
                                        
                                        Text("\(game.title)").foregroundColor(Color.white)
                                            .padding()
                                            .frame( maxWidth: .infinity,alignment: .leading)
                                            .background(Color("colorTab"))
                                            .clipShape(RoundedRectangle(cornerRadius: 3.0))
                                }
                            }
                    }.padding(.bottom,8)
                }.padding(.horizontal,6)
            }.navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
