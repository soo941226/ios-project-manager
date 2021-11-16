//
//  StateChanger.swift
//  ProjectManager
//
//  Created by kjs on 2021/11/16.
//

import SwiftUI

struct StateChangerBackground<ItemView: View>: View {
    @ViewBuilder let builder: () -> ItemView
    let fixedSize = CGSize(width: 200, height: 40)
    let horizontalInset: CGFloat = 30.0
    let verticalInset: CGFloat = 8.0

    var body: some View {
        VStack {
            builder()
                .frame(
                    width: fixedSize.width,
                    height: fixedSize.height,
                    alignment: .center
                )
                .border(.gray)
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
        .padding(UIStyle.minInsetAmount)
    }
}

struct StateChanger_Previews: PreviewProvider {
    static var previews: some View {
        StateChangerBackground {
            ForEach(0..<9) { int in
                Text(int.description)
            }
        }
    }
}
