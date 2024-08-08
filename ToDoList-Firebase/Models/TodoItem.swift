//
//  TodoItem.swift
//  ToDoList-Firebase
//
//  Created by Israel on 8/8/24.
//
import Foundation
import FirebaseFirestore

struct TodoItem: Identifiable, Codable{
    @DocumentID var id: String? = UUID().uuidString
    var title: String
    var isCompleted: Bool
    
    func toDictonary() -> [String: Any]{
        return ["title": title, "isCompleted": isCompleted]
       // return ["titel": title]
    }
}
