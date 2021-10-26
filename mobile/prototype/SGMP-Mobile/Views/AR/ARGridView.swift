//
//  ARGridView.swift
//  SGMP-Mobile
//
//  Created by fincher on 10/5/21.
//

import SwiftUI

struct ARGridView: View {
    @State var expandDebugView = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
//                UIViewController1Representable()
                ARGridViewControllerRepresentable()
                    .ignoresSafeArea()
                ARDebugView()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                    .frame(maxWidth: proxy.size.width * 1.0, maxHeight: proxy.size.height * 0.28, alignment: .bottom)
                    .padding()
            }
            .animation(.easeInOut)
        }
    }
}

struct ARGridView_Previews: PreviewProvider {
    static var previews: some View {
        ARGridView()
    }
}
