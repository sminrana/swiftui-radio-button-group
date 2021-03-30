//
//  ContentView.swift
//  SRRadioButton
//
//  Created by Smin Rana on 3/27/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        SRadioButtonViewGroup(dataProvider: RadioDataProvider(), selectedItem: getSelectedItemLabel)
    }
    
    func getSelectedItemLabel<T>(item: T) {
        print("selected item : \((item as! RadioModel).label)")
    }
}

/// Create your model
class RadioModel: Identifiable, RadioModelable {
    var id = UUID()
    var isChecked: Bool
    var label: String
    
    init(isChecked: Bool, label: String) {
        self.isChecked = isChecked
        self.label = label
    }
}

/// Create your data provider
class RadioDataProvider: ObservableObject, RadioDataProviding {
    typealias Item = RadioModel
    
    @Published var items: [Item] = []
    
    init() {
        self.items = getItems()
    }
    
    func getItems() -> [Item] {
        return [Item(isChecked: true, label: "Radio 1"),
                Item(isChecked: false, label: "Radio 2"),
                Item(isChecked: false, label: "Radio 3")]
    }
}

