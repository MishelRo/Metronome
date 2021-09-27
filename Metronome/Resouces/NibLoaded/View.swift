//
//  View.swift
//  OlivenetCabinet
//
//  Created by Sergei Rosliakov on 27.11.2020.
//  Copyright © 2020 Olivenet. All rights reserved.
//

import UIKit

/// Базовая вью.
open class View: UIView {
    
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    /// Настройка после инициализации.
    open func commonInit() {}
}

/// Basic control
open class Control: UIControl {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    /// Настройка после инициализации.
    open func commonInit() {}
}
