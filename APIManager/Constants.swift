//
//  Constants.swift
//  CFSCApp
//
//  Created by ashish on 08/03/20.
//  Copyright © 2020 CFSC. All rights reserved.
//

import Foundation


struct API {
    //static let MAINURL = "http://stage-api.testimonialstream.com/"
    
    static let MAINURL = "https://api.voiptella.com/"
   
    //USER
    static let authentication = MAINURL+"authentication"
    static let signUp = MAINURL+"m/users/signup"
    static let verifyOTP = MAINURL+"m/users/otp"
    
    //Pending
    static let forgotPassword = MAINURL+"m/users/forgotpass"
     static let changePassword = MAINURL+"m/users/changepass"
    
    //Locations
    static let getStoreLocations = MAINURL+"m/locations/get"
    
  
   
    
    //Customer
    static let getTransaction = MAINURL+"m/customers/transactions"
    static let getPoints = MAINURL+"m/customers/points"
    static let applyTellerRating = MAINURL+"m/customers/tellerrating"
    static let getAvailaleOffers = MAINURL+"m/customers/availableoffers"
    
    //Favorite
    static let addToFavorite = MAINURL+"m/customers/store/add"
    static let removeFromFavorite = MAINURL+"m/customers/store/remove"
    
    
   
    
}

struct AppConstant {
    static let WEBPAGE = "https://www.cfsc.com/"
    static let APPNAME = "CFSC"
    static let ISTEST = true
    static let DEVIDE_TOKEN = "deivceToken"
    static let DEVICE_TYPE = "IOS"
    static let UserDefaults = Foundation.UserDefaults.standard
    static let OTP_LEMGHT = 6
    static let PASSWORD_LEMGHT = 8
    static let PHONE_LEMGHT = 10
    static let ACCESS_TOKEM = "token"
    static let AppColor = UIColor.init(red: 215.0/255.0, green: 0, blue: 0, alpha: 1)
    static let BlueColor = UIColor.init(red: 157.0/255.0, green: 176.0/255.0, blue: 253.0/255.0, alpha: 1)
    
}
                
