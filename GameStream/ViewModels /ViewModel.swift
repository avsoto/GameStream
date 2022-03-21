//
//  ViewModel.swift
//  GameStream
//
//  Created by ANA on 3/20/22.
//

import Foundation


class ViewModel:ObservableObject {
    
    @Published var gamesInfo = [Game]()
    
    init() {
        let url = URL(string: "https://gamestream-api.herokuapp.com/api/games")!
        
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            do{
                if let jsonData = data{
                    print ("Json size \(jsonData)")
            
                    let decodeData = try
                        JSONDecoder().decode([Game].self, from: jsonData)
                    
                    /*Asynchronously add the data you decoded*/
                    DispatchQueue.main.async {
                        
                        self.gamesInfo.append(contentsOf: decodeData)
                    }
                }
            
            } catch{
            
                print("Error: \(error)")
            }
            
        }.resume()
    }

}
