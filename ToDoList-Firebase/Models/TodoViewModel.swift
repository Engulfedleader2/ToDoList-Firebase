//
//  TodoViewModel.swift
//  ToDoList-Firebase
//
//  Created by Israel on 8/8/24.
//

import Foundation
import FirebaseFirestore

class TodoViewModel: ObservableObject{
    @Published var items: [TodoItem] = []
    private var db = Firestore.firestore()
    
    init(){
        fetchItems()
    }
    
    func addItem(title: String){
        let newItem = TodoItem(title: title, isCompleted: false)
        do{
            _ = try db.collection("todos").addDocument(from: newItem)
        } catch{
            print("Error adding document: \(error)")
        }
    }
    func toggleCompletion(item: TodoItem){
        guard let id = item.id else {return}
        db.collection("todos").document(id).updateData(["isCompleted": !item.isCompleted]){ error in
            if let error = error {
                print("Error updating document: \(error)")
            }
        }
    }
    func removeItem(item: TodoItem){
        guard let id = item.id else {return}
        db.collection("todos").document(id).delete() { error in
            if let erorr = error {
                print("Error removing document: \(erorr)")
            }
        }
    }
    func fetchItems() {
        db.collection("todos").addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            
            print("Received \(documents.count) documents")
            
            self.items = documents.compactMap { queryDocumentSnapshot -> TodoItem? in
                let todoItem = try? queryDocumentSnapshot.data(as: TodoItem.self)
                print("Fetched item: \(String(describing: todoItem))")
                return todoItem
            }
        }
    }


    
}
