//
//  RadioButtonGroup.swift
//  SRRadioButton
//
//  Created by Smin Rana on 3/30/21.
//

import SwiftUI

protocol RadioModelable {
    var id: UUID {get set}
    var isChecked: Bool {get set}
    var label: String {get set}
}

protocol RadioDataProviding {
    associatedtype RadioItem
    var items: [RadioItem] {get set}
    func getItems() -> [RadioItem]
}

protocol RadioViewable {
    associatedtype DataProvider
    var dataProvider: DataProvider {get set}
}

struct SRadioButtonViewGroup: View, RadioViewable {
    typealias DataProvider = RadioDataProvider
    @ObservedObject var dataProvider: DataProvider
    
    let selectedItem: (RadioModel) -> Void
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5) {
            ForEach(dataProvider.items) { item in
                SRadioButtonView(model: item, onChange: _onChange)
            }
        }
    }
    
    private func toggle(id: UUID) {
        for item in self.dataProvider.items {
            if item.id == id {
                item.isChecked = true
            } else {
                item.isChecked = false
            }
        }
        
        self.dataProvider.objectWillChange.send()
    }
    
    private func _onChange(isChecked: Bool, id: UUID) {
        self.toggle(id: id)
        
        let item = self.dataProvider.items.first(where: {$0.id == id})
        selectedItem(item!)
    }
}

struct SRadioButtonView: View {
    @State var model: RadioModel
    
    let onChange: (_ isChecked: Bool, _ id: UUID) -> Void
    
    var body: some View {
        HStack {
            if !self.model.isChecked {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(Color.red)
            } else {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(Color.red)
            }
            
            Text(self.model.label)
        }
        .onTapGesture(count: 1, perform: {
            // Not necessary when RadioButtonView in a group
            self.model.isChecked.toggle()
            
            self.onChange(self.model.isChecked, self.model.id)
        })
    }
}
