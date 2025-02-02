//
//  BannerManager.swift
//  Essential
//
//  Created by KaayZenn on 11/03/2024.
//

import Foundation

@Observable
final class BannerManager {
    static let shared = BannerManager()

    var banner: Banner?
}
