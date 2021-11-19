//
//  PersistenceControllerDelegate.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/20.
//

import Foundation

protocol PersistenceControllerDelegate: AnyObject {
    func loadFailed(_ error: NSError)
}
