//
//  StateChanger.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/16.
//

import SwiftUI

struct StateChanger: View {
    let stateList: [String]
    let fixedSize = CGSize(width: 200, height: 40)
    let horizontalInset: CGFloat = 30.0
    let verticalInset: CGFloat = 8.0

    var body: some View {
        VStack {
            ForEach(stateList, id: \.self) { state in
                Button {
                    print(state)
                } label: {
                    Text("Move to \(state.uppercased())")
                }
            }
            .frame(
                width: fixedSize.width,
                height: fixedSize.height,
                alignment: .center
            )
            .padding(EdgeInsets(
                top: verticalInset,
                leading: horizontalInset,
                bottom: verticalInset,
                trailing: horizontalInset
            ))
            .background(Color.white)
            .foregroundColor(.blue)
            .font(.title3)
        }
        .padding()
    }
}

struct StateChanger_Previews: PreviewProvider {
    static var previews: some View {
        StateChanger(stateList: ["DONE", "DOING"])
    }
}
