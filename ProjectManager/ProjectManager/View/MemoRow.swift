//
//  MemoRow.swift
//  ProjectManager
//
//  Created by kjs on 2021/10/26.
//

import SwiftUI

typealias MemoRowViewModelable = ObservableObject &
                                MemoExpressionableViewModel &
                                MemoStateChangableViewModel

struct MemoRow<MemoRowViewModel: MemoRowViewModelable>: View {
    @ObservedObject var viewModel: MemoRowViewModel

    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)

            VStack(alignment: .leading, spacing: 1) {
                Text(viewModel.memo.title)
                    .font(.title3)
                    .lineLimit(1)
                    .padding(UIStyle.minInsetAmount)

                Text(viewModel.memo.body)
                    .font(.body)
                    .lineLimit(3)
                    .padding(UIStyle.minInsetAmount)

                Text(viewModel.yyyyMMdd(from: viewModel.memo.date))
                    .font(.callout)
                    .foregroundColor(viewModel.color(about: viewModel.memo))
                    .padding(UIStyle.minInsetAmount)
            }
        }
        .popover(
            isPresented: viewModel.isLongPressed,
            attachmentAnchor: .point(.center),
            arrowEdge: .top
        ) {
            StateChangerBackground {
                ForEach(viewModel.changableState, id: \.self) { state in
                    Button {
                        withAnimation {
                            viewModel.updateState(with: state)
                            viewModel.hidePopover()
                        }
                    } label: {
                        Text("Move to \(state.description)")
                    }
                }
            }
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        MemoRow(
            viewModel: MemoRowViewModel(
                memo: Memo(
                    id: UUID(),
                    title: "title",
                    body: "body",
                    date: Date(),
                    state: .todo
                ),
                delegate: MemoListViewModel()
            )
        )
            .previewLayout(
                .fixed(width: 200, height: 200)
            )
    }
}
