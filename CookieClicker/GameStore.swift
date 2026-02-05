//
//  GameStore.swift
//  CookieClicker
//
//  Created by DaanSmit on 05/02/2026.
//

import SwiftUI

struct StoreItem: Identifiable {
    let id = UUID()
    let name: String
    let emoji: String
    let baseCost: Int
    let cps: Int
    var count: Int
}

final class GameStore: ObservableObject {
    @Published var items: [StoreItem] = [
        StoreItem(name: "Cursor", emoji: "🖱️", baseCost: 15, cps: 1, count: 0),
        StoreItem(name: "Grandma", emoji: "👵", baseCost: 100, cps: 5, count: 0),
        StoreItem(name: "Farm", emoji: "🌾", baseCost: 1100, cps: 20, count: 0),
        StoreItem(name: "Mine", emoji: "⛏️", baseCost: 12000, cps: 100, count: 0),
        StoreItem(name: "Factory", emoji: "🏭", baseCost: 130000, cps: 500, count: 0)
    ]

    var totalCPS: Int {
        items.reduce(0) { $0 + $1.cps * $1.count }
    }

    func currentCost(for item: StoreItem) -> Int {
        Int(Double(item.baseCost) * pow(1.15, Double(item.count)))
    }

    func buyItem(at index: Int, credits: inout Int) {
        let cost = currentCost(for: items[index])
        guard credits >= cost else { return }
        credits -= cost
        items[index].count += 1
    }
}
