//
//  CarsSwiftUIApp.swift
//  CarsSwiftUI
//
//  Created by Дмитрий Геращенко on 13.06.2021.
//

import SwiftUI

@main
struct CarsSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
