//
//  CustomWheelPickerView.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 4/11/23.
//

import SwiftUI
import UIKit

struct CustomWheelPickerView: View {
    
    @State var selection: String? = HomeFirstStep.somewhatFulfilled.text
    let firstStepOptions: [String] = HomeFirstStep.allCases.map { $0.text }
    
    var body: some View {
        CustomPicker(selection: $selection, options: firstStepOptions)
    }
}

#Preview {
    ZStack {
        Color.darkBackgroundColor
        
        CustomWheelPickerView()
    }
}

struct CustomPicker: UIViewRepresentable {
    
    @Binding var selection: String?
    let options: [String]
    
    func makeCoordinator() -> Coordinator {
        return CustomPicker.Coordinator(parent1: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<CustomPicker>) -> UIPickerView {
        
        let picker = UIPickerView()
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIView(_ uiView: UIPickerView, context: UIViewRepresentableContext<CustomPicker>) {}
    
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        
        var parent: CustomPicker
        
        init(parent1: CustomPicker) {
            parent = parent1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            
            return parent.options.count//data.count
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            
            pickerView.subviews[1].backgroundColor = UIColor.clear
//            pickerView.
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 100, height: 60))
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
            
            if pickerView.selectedRow(inComponent: component) == row {
                label.font = .neuzeitBold(20)
            } else {
                label.font = .neuzeitBook(20)
            }
            label.text = parent.options[row] //data[row]
            label.textColor = .white
            label.textAlignment = .center
            
            view.addSubview(label)
//
            view.clipsToBounds = true
//            view.layer.cornerRadius = view.bounds.height / 2
            
            return view
        }
        
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return UIScreen.main.bounds.width - 100
        }
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 60
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            pickerView.reloadAllComponents()
        }
    }
}

//var data =  ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
