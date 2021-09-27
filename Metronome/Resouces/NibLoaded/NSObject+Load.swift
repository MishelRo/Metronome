//
//  NSObject+Load.swift
//  OlivenetCabinet
//
//  Created by Sergei Rosliakov on 27.11.2020.
//  Copyright © 2020 Olivenet. All rights reserved.
//

import Foundation

public extension NSObject {
    
    var className: String {
        String(describing: type(of: self))
    }
    
    static var className: String {
        String(describing: self)
    }
    
}
