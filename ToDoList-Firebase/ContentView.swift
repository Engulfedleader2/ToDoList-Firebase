//
//  ContentView.swift
//  ToDoList-Firebase
//
//  Created by Israel on 8/8/24.
//

import SwiftUI
import FirebaseFirestore



struct ContentView: View {
    
    @State private var newItemTitle = ""
    @ObservedObject private var viewModel = TodoViewModel()

    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    TextField("Enter new item", text: $newItemTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        if !newItemTitle.isEmpty {
                            viewModel.addItem(title: newItemTitle)
                        newItemTitle = ""
                        }
                    }){
                        Text("Add")
                    }
                }
                .padding()
                
                List{
                    ForEach(viewModel.items) { item in
                        HStack{
                            Text(item.title)
                            Spacer()
                            Button(action: {
                                viewModel.toggleCompletion(item: item)
                            }){
                                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(item.isCompleted ? .green : .gray)
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .navigationTitle("To-Do List")
            }
        }
    }
//    func addItem(title: String){
//        //TODO:
//        let newItem = TodoItem(title: title, isCompleted: false)
//        items.append(newItem)
//    }
//    func toggleCompletion(item: TodoItem){
//        //TODO:
//        if let index = items.firstIndex(where: {$0.id == item.id}){
//            items[index].isCompleted.toggle()
//        }
//    }
    func deleteItems(at offsets: IndexSet){
        //TODO:
        offsets.forEach { index in
            viewModel.removeItem(item: viewModel.items[index])
        }
       
    }
}

#Preview {
    ContentView()
}
