//
//  SideMenu.swift
//  POC_SideMenu
//
//  Created by Theo Sementa on 04/02/2025.
//

import SwiftUI

struct SideMenu<T: View>: View {

    // builder
    @Binding var isShowing: Bool
    @ViewBuilder var content: T

    // MARK: -
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }

                content
                    .transition(.move(edge: .trailing))
                    .background(Color.clear)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    } // body
} // struct
