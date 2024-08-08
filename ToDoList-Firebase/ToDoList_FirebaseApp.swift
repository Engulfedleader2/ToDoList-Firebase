//
//  ToDoList_FirebaseApp.swift
//  ToDoList-Firebase
//
//  Created by Israel on 8/8/24.
//

import SwiftUI
import Firebase

@main
struct ToDoList_FirebaseApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
