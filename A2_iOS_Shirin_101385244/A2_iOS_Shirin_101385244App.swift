//
//  A2_iOS_Shirin_101385244App.swift
//  A2_iOS_Shirin_101385244
//
//  Created by Shirin Ali on 2025-03-28.
//

import SwiftUI

@main
struct A2_iOS_Shirin_101385244App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
