# Radio Buttons group in SwiftUI

## Installation
* Add RadioButtonGroup.swift in your SwiftUI project.

   
## Usages
* Create model class, must conform to RadioModelable protocol
```swift
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
```

* Create data provider class, must conform to RadioDataProviding protocol
  
```swift
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
```

* Finally add in your view

```swift
struct ContentView: View {
    var body: some View {
        SRadioButtonViewGroup(dataProvider: DataProvider<RadioModel>(), selectedItem: getSelectedItemLabel)
    }
    
    func getSelectedItemLabel<T>(item: T) {
        print("selected item : \((item as! RadioModel).label)")
    }
}
```

![Alt Text](https://github.com/sminrana/swiftui-radio-button-group/blob/main/preview.gif)

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://github.com/sminrana/swiftui-radio-button-group/blob/main/LICENSE)