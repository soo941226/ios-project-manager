//
//  PersistenceController.swift
//  ProjectManager
//
//  Created by kjs on 2021/10/26.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    private let container = NSPersistentContainer(name: "ProjectManager")

    weak var delegate: PersistenceControllerDelegate?

    private init() {
        container.loadPersistentStores { [self] _, error in
            if let error = error as NSError? {
                self.delegate?.loadFailed(error)
            }
        }
    }
}
