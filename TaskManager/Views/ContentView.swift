//
//  ContentView.swift
//  TaskManager
//
//  Created by Данил ОТК on 25.06.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var goToAddTaskPage = false
    @State private var goToBacklogPage = false
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            NavigationView {
                
                VStack {
                    NavigationLink(destination: BacklogView(), isActive: $goToBacklogPage) {
                        Button(action: {
                            goToBacklogPage = true
                        }) {
                            HStack {
                                Image(systemName: "pencil")
                                    .font(.title)
                                Text("Backlog")
                                    .fontWeight(.semibold)
                                    .font(.title)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(40)
                            
                        }
                    }
                    
                    NavigationLink(destination: AddTaskView(), isActive: $goToAddTaskPage) {
                        Button(action: {
                            goToAddTaskPage = true
                        }) {
                            HStack {
                                Image(systemName: "pencil")
                                    .font(.title)
                                Text("Add task")
                                    .fontWeight(.semibold)
                                    .font(.title)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(40)
                            
                        }
                    }
                }
            }
        }
        .background(Color.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
