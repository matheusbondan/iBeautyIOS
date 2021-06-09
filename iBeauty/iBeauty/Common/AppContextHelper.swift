//
//  AppContextHelper.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 19/11/20.
//

import Foundation

public class AppContextHelper{
    
    public static let share = AppContextHelper()
    private let userDefaults = UserDefaults.standard
    
    public var currentUser:UserModel?
    
    public var rememberMe:Bool? {
        get{
            return userDefaults.bool(forKey: "remember-me-key")
        }
        set{
            userDefaults.set(newValue, forKey: "remember-me-key")
        }
    }
    
    public var userID:String? {
        get{
            return userDefaults.string(forKey: "user-ID-key")
        }
        set{
            userDefaults.set(newValue, forKey: "user-ID-key")
        }
    }
    
    public var email:String? {
        get{
            return userDefaults.string(forKey: "email-key")
        }
        set{
            userDefaults.set(newValue, forKey: "email-key")
        }
    }
    
    public var isLogged:Bool? {
        get{
            return userDefaults.bool(forKey: "logged-key")
        }
        set{
            userDefaults.set(newValue, forKey: "logged-key")
        }
    }
}
