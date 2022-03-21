//
//  SaveData.swift
//  GameStream
//
//  Created by ANA on 3/20/22.
//

import Foundation

class SaveData {
    
    var email:String = ""
    var password:String = ""
    var name:String = ""
     
    func saveData(email:String,password:String,name:String) -> Bool {
        
        print("Inside the Save Data function I got: \(email) + \(password) + \(name)")
        UserDefaults.standard.set([email,password,name], forKey: "userData")
        
        return true
    }
    
    func recoverData() -> [String] {
        
        let userData:[String] = UserDefaults.standard.stringArray(forKey: "userData")!
        
        print("I am in method recover data and recover: \(userData)")
        
        return userData
    }
    
    
    func validate(email:String,password:String) -> Bool {
        
        var saveEmail = ""
        var savePassword = ""
        
        print("Checking if I have data in user defaults with mail: \(email) and password: \(password)")
        
        if UserDefaults.standard.object(forKey: "userData") != nil {
            
            saveEmail = UserDefaults.standard.stringArray(forKey: "userData")![0]
            
            savePassword = UserDefaults.standard.stringArray(forKey: "userData")![1]
            
            print("The saved email is: \(saveEmail) and the saved password is: \(savePassword)")
            
            if (email == saveEmail && password == savePassword){
                return true
            }else{
                return false
            }
              
        }else{
            
            print("There is no user data written to the global object of userdefaults.")
            return false
        }
        
    }
    
}
