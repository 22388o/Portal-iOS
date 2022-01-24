//
//  Portal_MacOSApp.swift
//  Portal-MacOS
//
//  Created by Farid on 22.03.2021.
//  Copyright © 2021 Tides Network. All rights reserved.
//

import SwiftUI

@main
struct Portal_MacOSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
