//
//  ContentView.swift
//  ProjectManager
//
//  Created by kjs on 2021/10/26.
//

import SwiftUI

struct ContentView: View {
    @State var isEdited = false

    var body: some View {
        NavigationView {
            HStack(
                alignment: .center,
                spacing: UIStyle.minInsetAmount
            ) {
                MemoList(title: "TODO")
                    .backgroundColor(.basic)
                MemoList(title: "DOING")
                    .backgroundColor(.basic)
                MemoList(title: "DONE")
                    .backgroundColor(.basic)
            }
            .backgroundColor(
                .myGray
            )
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isEdited.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .sheet(
            isPresented: $isEdited,
            onDismiss: {
                print("!")
            },
            content: {
                MemoView()
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
