//
//  RadioButtonGroup.swift
//  SRRadioButton
//
//  Created by Smin Rana on 3/30/21.
//

import SwiftUI

protocol RadioModelable {
    var id: Int {get set}
    var isChecked: Bool {get set}
    var label: String {get set}
    
    init(id: Int, isChecked: Bool, label: String)
}

protocol RadioDataProviding: ObservableObject {
    associatedtype RItem: RadioModelable
    var items: [RItem] {get set}
    func getItems() -> [RItem]
    func toggle(id: Int)
}

struct SRadioButtonViewGroup<DataProvider>: View where DataProvider: RadioDataProviding {
    @ObservedObject var dataProvider: DataProvider
    
    let selectedItem: (RadioModelable) -> Void
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5) {
            ForEach(dataProvider.items, id: \.label) { item in
                SRadioButtonView(model: item, onChange: _onChange)
            }
        }
    }
    
    private func _onChange(isChecked: Bool, id: Int) {
        self.dataProvider.toggle(id: id)
        
        let item = self.dataProvider.items.first(where: {$0.id == id})
        selectedItem(item!)
    }
}

struct SRadioButtonView<Item>: View where Item: RadioModelable {
    @State var model: Item
    
    let onChange: (_ isChecked: Bool, _ id: Int) -> Void
    
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
