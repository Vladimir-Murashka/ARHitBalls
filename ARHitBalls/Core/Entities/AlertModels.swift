//
//  AlertModels.swift
//  ARHitBalls
//
//  Created by Swift Learning on 26.08.2022.
//

import UIKit

struct AlertModel {
    let title: String?
    let message: String?
    let preferredStyle: UIAlertController.Style
    let actions: [ActionModel]
}

struct ActionModel {
    let title: String?
    let style: UIAlertAction.Style
    let actionBlock: (() -> Void)?
}
