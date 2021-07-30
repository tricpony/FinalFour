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
            VStack (alignment: .center) {
                Text(product.title)
                    .foregroundColor(.primary)
                    .background(Rectangle().stroke(Color.black, lineWidth: 1))
                    .frame(width: geometry.size.width - (edgePadding * 2), height: geometry.size.height / 2, alignment: .center)
                
                BorderedImage(imageData: product.imageData ?? Data())
                    .offset(y: -130)
                    .padding(.bottom, -130)

            }
            Divider()

            VStack(alignment: .leading) {
                Text(product.productLabel)
                    .font(.title)

                HStack {
                    Text("Author")
                        .font(.subheadline)
                }
            }
            .padding()
        }
        .padding(.leading, edgePadding)

    }
}

struct DetailContent_Previews: PreviewProvider {
    static var previews: some View {
        DetailContent(product: MockProduct(title: "Title"))
    }
}
