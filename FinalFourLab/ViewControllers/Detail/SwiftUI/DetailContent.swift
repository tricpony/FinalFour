//
//  DetailContent.swift
//  FinalFourLab
//
//  Created by aarthur on 7/30/21.
//

import SwiftUI

struct DetailContent<T: Model>: View {
    let edgePadding: CGFloat = 4
    var product: T

    init(product: T) {
        self.product = product
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(product.title).padding(.top, 22)
                .foregroundColor(.primary)
                .frame(width: geometry.size.width - (edgePadding * 2), height: geometry.size.height / 2.7, alignment: .top)
                .background(Rectangle()
                        .strokeBorder(Color.black, lineWidth: 0.5).background(Rectangle().fill(Color.gray.opacity(0.1))))

                BorderedImage(imageData: product.imageData ?? Data())
                    .offset(y: -180)
                    .padding(.bottom, -180)
                    .frame(width: 288, height: 288, alignment: .center)

                Spacer()
                Divider()

                VStack(alignment: .leading) {
                    Text(product.productLabel)
                        .font(.title)
                }
                .padding()
            }
        }
    }
}

struct DetailContent_Previews: PreviewProvider {
    static var previews: some View {
        DetailContent(product: MockProduct(title: "Title"))
    }
}
