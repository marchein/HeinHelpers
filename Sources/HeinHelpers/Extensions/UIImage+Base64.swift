//
//  UIImage+Base64.swift
//  HeinHelpers
//
//  Created by Marc Hein on 16.08.20.
//  Copyright © 2023 Marc Hein. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}
#endif
