//
//  CollisionCategory.swift
//  ARHitBalls
//
//  Created by Swift Learning on 22.09.2022.
//

struct CollisionCategory: OptionSet {
    let rawValue: Int
    
    static let missleCategory = CollisionCategory(rawValue: 1 << 0)
    static let targetCategory = CollisionCategory(rawValue: 1 << 1)
}
