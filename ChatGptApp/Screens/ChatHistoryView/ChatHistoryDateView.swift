//
//  ChatHistoryDateView.swift
//  Thready AI
//
//  Created by Ankush Dhawan on 30/01/24.
//

import Foundation
import SwiftUI

struct ChatHistoryDateView: View {
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) var viewContext
    
    // MARK: user typed keyword
    @State var isSheetPresented: Bool = false
    @FetchRequest(sortDescriptors: []) private var dateHistory: FetchedResults<ChatHistory>
    @ObservedObject var chatDateViewModel = ChatHistoryDateVIewModel()
    
        var body: some View {
            NavigationView {
            ZStack{
                Color.BGCOLOR
                    .ignoresSafeArea()
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    List {
                        ForEach(Array(chatDateViewModel.chatDates.keys.enumerated()), id:\.element) { value, key in
                            NavigationLink(destination: ChatHistoryDetailView(chatList: chatDateViewModel.chatDates[key] ?? []).navigationBarBackButtonHidden(true)) {
                                HStack(alignment: .center) {
                                    VStack(alignment: .leading) {
                                        Text(key)
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                    }
                                    Spacer()
                                    //StatusIndicator(status: todo.status == "completed" ? .completed : .pending)
                                }
                            }
                            .navigationBarBackButtonHidden(true)
                            .foregroundColor(Color.white)
                            .listRowSeparatorTint(.white)
                        }
                        .onDelete(perform: delete)
                        .listRowBackground(Color.black)

                    }
                    .listStyle(.inset)
                    .scrollContentBackground(.hidden)     // << here !!
                    .padding()
                
                    // MARK: Add searchable modifier
                    //.searchable(text: $searchKeyword)
                    //.onChange(of: searchKeyword) { newValue in
                    //self.todos.nsPredicate = newValue.isEmpty ? nil : NSPredicate(format: "title CONTAINS %@", newValue)
                    //}
                    .sheet(isPresented: $isSheetPresented, content: {
                        //TodoInputForm(isPresented: $isSheetPresented)
                    })
                    
            }.onAppear {
                chatDateViewModel.filterArray(dateHistory: dateHistory)
            }
            }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let todo = dateHistory[index]
            self.viewContext.delete(todo)
            do {
                try viewContext.save()
                //print("perform delete")
            } catch {
                // handle the Core Data error
            }
        }
    }
}
