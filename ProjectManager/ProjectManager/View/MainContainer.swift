//
//  MainContainer.swift
//  ProjectManager
//
//  Created by kjs on 2021/10/26.
//

import SwiftUI

struct MainContainer: View {
    @StateObject private var viewModel = MemoListViewModel()
    @State var isEdited = false

    var body: some View {
        NavigationView {
            HStack(
                alignment: .center,
                spacing: UIStyle.minInsetAmount
            ) {
                ForEach(Memo.State.allCases, id: \.self) { state in
                    memoListView(about: state)
                }
            }
            .background(Color.myGray)
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isEdited.toggle()
                        viewModel.joinToCreateMemo()
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
                viewModel.afterEdit()
            },
            content: {
                MemoView(memoEditorViewModel: viewModel, isShow: $isEdited)
            }
        )
    }
}

// MARK: - View components
extension MainContainer {
    private func memoListView(about state: Memo.State) -> some View {
        let memoList = viewModel.list(about: state)
        
        return MemoList(title: state.description, itemCount: memoList.count) {
            ForEach(memoList, id: \.self) { memo in
                let rowViewModel = MemoRowViewModel(memo: memo, delegate: viewModel)

                MemoRow(viewModel: rowViewModel)
                    .padding(.bottom, UIStyle.minInsetAmount)
                    .accessibilityElement()
                    .accessibilityLabel(rowViewModel.memo.title)
                    .accessibilityValue(rowViewModel.memo.body)
                    .onTapGesture {
                        viewModel.joinToUpdate(memo)
                        isEdited.toggle()
                    }
                    .onLongPressGesture {
                        rowViewModel.showPopover()
                    }
                    .onSwipeToDelete {
                        guard let index = memoList.firstIndex(of: memo) else {
                            return
                        }

                        viewModel.delete(at: index, from: state)
                    }
            }
        }
        .background(Color.basic)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContainer()
    }
}
