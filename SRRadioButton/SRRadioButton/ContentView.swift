//
//  ContentView.swift
//  SRRadioButton
//
//  Created by Smin Rana on 3/27/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        SRadioButtonViewGroup(dataProvider: DataProvider(), selectedItem: getSelectedItemLabel)
        Text("Hello")
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
class DataProvider: RadioDataProviding {
    typealias RadioItem = RadioModel
    
    @Published var items: [RadioItem] = []
    
    init() {
        self.items = getItems()
    }
    
    func getItems() -> [RadioItem] {
        return [RadioItem(isChecked: true, label: "Radio 1"),
                RadioItem(isChecked: false, label: "Radio 2"),
                RadioItem(isChecked: false, label: "Radio 3")]
    }
    
    func toggle(id: UUID) {
        for item in self.items {
            if item.id == id {
                item.isChecked = true
            } else {
                item.isChecked = false
            }
        }
        
        self.objectWillChange.send()
    }
}

