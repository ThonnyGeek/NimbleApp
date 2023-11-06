//
//  KeyChainPropertyWrapper.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 5/11/23.
//

import SwiftUI

@propertyWrapper
struct KeyChain: DynamicProperty {
    
    @State var data: Data?
    
    var wrappedValue: Data? {
        get{KeyChainHelper.shared.read(key: key, account: account)}
        nonmutating set{
            
            guard let newData = newValue else {
                data = nil
                KeyChainHelper.shared.delete(key: key, account: account)
                return
            }
            
            KeyChainHelper.shared.save(data: newData, key: key, account: account)
            
            data = newValue
        }
    }
    
    var key: String
    var account: String
    
    init(key: String, account: String) {
        self.key = key
        self.account = account
        
        _data = State(wrappedValue: KeyChainHelper.shared.read(key: key, account: account))
    }
}
