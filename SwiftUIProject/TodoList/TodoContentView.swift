//
//  TodoContentView.swift
//  SwiftUIProject
//
//  Created by Emmanuel Nollase on 6/18/22.
// source: 

import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    let name: String
    var isComplete: Bool = false
}

enum Sections: String, CaseIterable {
    case pending = "Pending"
    case completed = "Completed"
}

struct TodoContentView: View {
    
    @State private var tasks = [Task(name: "Complete flask test", isComplete: true),Task(name: "Bring home the bacon"),Task(name: "Learn SwiftUI")]
    var pendingTask: [Binding<Task>] {
        $tasks.filter { !$0.isComplete.wrappedValue }
    }
    
    var completedTask: [Binding<Task>] {
        $tasks.filter { $0.isComplete.wrappedValue }
    }
    
    var body: some View {
        List  {
            ForEach(Sections.allCases, id: \.self){ section in
                Section {
                    let filteredTask = section == .pending ? pendingTask : completedTask
                    if filteredTask.isEmpty {
                        Text("No task available")
                    }
                    ForEach(filteredTask){ $task in
                        TaskViewCell(task: $task)
                    }.onDelete { indexSet in
                        indexSet.forEach { index in
                            let toDelete = filteredTask[index]
                            tasks = tasks.filter { $0.id != toDelete.id }
                        }
                    }

                } header: {
                    Text(section.rawValue)
                }
            }
        }
    }
}

struct TaskViewCell: View {

    @Binding var task: Task
    
    var body: some View {
        HStack {
            Image(systemName:  task.isComplete ? "checkmark.circle" : "square").onTapGesture {
                task.isComplete.toggle()
            }
            Text(task.name)
        }
    }
}

struct TodoContentView_Previews: PreviewProvider {
    static var previews: some View {
        TodoContentView()
    }
}
