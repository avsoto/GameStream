//
//  SearchGame.swift
//  GameStream
//
//  Created by ANA on 3/20/22.
//

import Foundation


class SearchGame: ObservableObject {

    @Published var gameInfo = [Game]()
    
    func search(gameName:String)  {
        
        /*Remove previous searches*/
        gameInfo.removeAll()
        
        let gameNameSpaces = gameName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let url = URL(string:"https://gamestream-api.herokuapp.com/api/games/search?contains=\(gameNameSpaces ?? "cuphead")")!
        
            var request = URLRequest(url: url)
        
            request.httpMethod = "GET"
      
            URLSession.shared.dataTask(with: request) { data, response, error in
        
                do{
                    if let jsonData = data {
        
                        print("Json size: \(jsonData)")
        
                        let decodeData = try
                            JSONDecoder().decode(Results.self, from: jsonData)
        
                        DispatchQueue.main.async {
        
                            self.gameInfo.append(contentsOf:decodeData.results)
        
                        }
                    }
                }
                
                catch{
                    
                   print("Error: \(error)")
                    
                }
            }.resume()
    }
}
