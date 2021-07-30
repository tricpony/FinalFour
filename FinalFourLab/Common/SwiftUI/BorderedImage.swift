//
//  BorderedImage.swift
//  FinalFourLab
//
//  Created by aarthur on 7/30/21.
//

import SwiftUI

enum Shape {
    case rectangle
    case circle
}

struct BorderedImage: View {
    let imageData: Data
    var shape = Shape.circle

    init(imageData: Data) {
        self.imageData = imageData
    }
    
    var body: some View {
        borderedImage.shadow(radius: 7)
    }
    
    var shapedImage: some View {
        switch shape {
        case .rectangle:
            return AnyView(RectangleView(shape: shape, imageData: imageData))
        case .circle:
            return AnyView(CircleView(shape: shape, imageData: imageData))
        }
    }

    var borderedImage: some View {
        switch shape {
        case .rectangle:
            return AnyView(shapedImage.overlay(Rectangle().stroke(Color.white, lineWidth: 4)))
        case .circle:
            return AnyView(shapedImage.overlay(Circle().stroke(Color.white, lineWidth: 4)))
        }
    }
}

struct RectangleView: View {
    let imageData: Data
    var shape: Shape

    init(shape: Shape, imageData: Data) {
        self.shape = shape
        self.imageData = imageData
    }

    var body: some View {
        let image = Image(uiImage: UIImage(data: imageData) ?? UIImage())
        image.resizable().aspectRatio(contentMode: .fit).clipShape(Rectangle())
    }
}

struct CircleView: View {
    let imageData: Data
    var shape: Shape

    init(shape: Shape, imageData: Data) {
        self.shape = shape
        self.imageData = imageData
    }

    var body: some View {
        let image = Image(uiImage: UIImage(data: imageData) ?? UIImage())
        image.resizable().aspectRatio(contentMode: .fit).clipShape(Circle())
    }
}

struct BorderImage_Previews: PreviewProvider {
    static var previews: some View {
        BorderedImage(imageData: UIImage(named: "Fallback")?.pngData() ?? Data())
    }
}
