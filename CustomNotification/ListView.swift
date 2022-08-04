//
//  ListView.swift
//  CustomNotification
//
//  Created by Phi Van Tuan on 02/08/2022.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        HStack {
            VStack {
                ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                }
            }.background(Color.green)
            Button("Show details") {
                print("--- deubg ---")
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .background(Color.red)
            .frame(width: 300, height: 300, alignment: .center)
    }
}
