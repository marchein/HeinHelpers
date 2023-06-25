//
//  SKProduct+LocalizedPrice.swift
//  HeinHelpers
//
//  Created by Marc Hein on 20.11.18.
//  Copyright © 2023 Marc Hein. All rights reserved.
//

import Foundation
#if canImport(StoreKit)
import StoreKit

extension SKProduct {
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price)!
    }
}
#endif
