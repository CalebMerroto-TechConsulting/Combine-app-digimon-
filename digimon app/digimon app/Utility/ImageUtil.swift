//
//  ImageUtil.swift
//  SwiftUI-API-call-Practice
//
//  Created by Caleb Merroto on 2/24/25.
//

import SwiftUI

func placeholderImage(_ color: UIColor, _ w: CGFloat = 100, _ h: CGFloat = -1) -> UIImage {
    let width = w
    let height = h > 0 ? h : width
    let size = CGSize(width: width, height: height)
    let renderer = UIGraphicsImageRenderer(size: size)
    return renderer.image { context in
        color.setFill()
        context.fill(CGRect(origin: .zero, size: size))
    }
}

