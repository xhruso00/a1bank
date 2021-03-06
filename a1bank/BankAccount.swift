//
// Created by Panagiotis Papastamatis on 21/03/2016.
// Copyright (c) 2016 Panagiotis Papastamatis. All rights reserved.
//

import Foundation

class BankAccount: Hashable {
    var id: CUnsignedLong

    var balance: Double

    var friendlyName: String
    
    var accountType: String

    //The id of the user that owns this account
    var owner: CUnsignedLong

    init(id: CUnsignedLong, balance: Double, ownerId: CUnsignedLong, friendName: String) {
        self.id = id
        self.balance = balance
        self.owner = ownerId
        self.friendlyName = friendName
        self.accountType = "Savings"
    }
    
    init(id: CUnsignedLong, balance: Double, ownerId: CUnsignedLong, friendName: String, accountType: String){
        self.id = id
        self.balance = balance
        self.owner = ownerId
        self.friendlyName = friendName
        self.accountType = accountType
        
    }


    var hashValue: Int {
        get {
            return self.id.hashValue
        }
    }
}


func ==(lhs: BankAccount, rhs: BankAccount) -> Bool {
    return lhs.id == rhs.id
}