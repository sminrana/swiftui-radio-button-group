//
//  ContentView.swift
//  SRRadioButton
//
//  Created by Smin Rana on 3/27/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        SRadioButtonViewGroup(dataProvider: DataProvider<RadioModel>(), selectedItem: getSelectedItemLabel)
    }
    
    func getSelectedItemLabel<T>(item: T) {
        print("selected item : \((item as! RadioModel).label)")
    }
}

/// Create your model
class RadioModel: RadioModelable {
    var id: Int
    var isChecked: Bool
    var label: String
    
    required init(id: Int, isChecked: Bool, label: String) {
        self.id = id
        self.isChecked = isChecked
        self.label = label
    }
}

/// Create your data provider
class DataProvider<T>: RadioDataProviding where T: RadioModelable {
    @Published var items: [RItem] = []
    
    init() {
        
        self.items = getItems()
    }
    
    func getItems() -> [T] {
        return [T(id: 1, isChecked: true, label: "Radio 1"),
                T(id: 2, isChecked: false, label: "Radio 2"),
                T(id: 3, isChecked: false, label: "Radio 3")]
    }
    
    func toggle(id: Int) {
        for var item in self.items {
            if item.id == id {
                item.isChecked = true
            } else {
                item.isChecked = false
            }
        }
        
        self.objectWillChange.send()
    }
}
