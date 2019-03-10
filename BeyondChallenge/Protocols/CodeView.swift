//
//  CodeView.swift
//  BeyondChallenge
//
//  Created by Günter Hertz on 07/03/19.
//  Copyright © 2019 Günter Hertz. All rights reserved.
//

protocol CodeView {
    func viewHierarchy()
    func viewConstraints()
    func viewAdditionalConfiguration()
    func viewSetup()
}

extension CodeView {
    func viewSetup() {
        viewHierarchy()
        viewConstraints()
        viewAdditionalConfiguration()
    }
}
