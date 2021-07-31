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
    let titleBackgroundColor = ColorKit.detailTitleBackground.kitColor ?? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

    init(product: T) {
        self.product = product
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(product.title).padding(.top, 22)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .frame(width: geometry.size.width - (edgePadding * 2), height: geometry.size.height / 2.7, alignment: .top)
                    .background(Rectangle()
                        .strokeBorder(Color.black, lineWidth: 0.5).background(Rectangle().fill(Color(titleBackgroundColor))))

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
        ForEach(ColorScheme.allCases, id: \.self) {
            DetailContent(product: MockProduct(title: "Title")).preferredColorScheme($0)
        }
    }
}
