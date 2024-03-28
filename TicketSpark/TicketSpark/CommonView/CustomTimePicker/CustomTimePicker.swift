//
//  CustomTimePicker.swift
//  TicketSpark
//
//  Created by Apple on 27/03/24.
//

import UIKit

class CustomTimePicker: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var timePicker: UIPickerView!
    
    // MARK: - Properties
    private var hours: [String] = []
    private var minutes: [String] = []
    private var amPm: [String] = ["AM", "PM"]
    private var selectedHour: Int = 0
    private var selectedMinute: Int = 0
    private var selectedAmPm: Int = 0
    let nibName = "CustomTimePicker"
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        setupPicker()
    }
    
    private func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    // MARK: - Setup
    
    private func setupPicker() {
        timePicker.delegate = self
        timePicker.dataSource = self
        // Populate hours array with 1-12 (12-hour format)
        hours = Array(1...12).map { String($0) }
        
        // Populate minutes array with 0-59
        minutes = Array(0..<60).map { String(format: "%02d", $0) }
        
        // Set default selected time to current time
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: Date())
        selectedHour = components.hour ?? 0
        selectedMinute = components.minute ?? 0
        selectedAmPm = components.hour ?? 0 >= 12 ? 1 : 0
        
        // Scroll to the current time
        timePicker.selectRow(selectedHour - 1, inComponent: 0, animated: false)
        timePicker.selectRow(selectedMinute, inComponent: 1, animated: false)
        timePicker.selectRow(selectedAmPm, inComponent: 2, animated: false)
    }
    
    // MARK: - UIPickerViewDataSource methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return hours.count
        case 1:
            return minutes.count
        case 2:
            return amPm.count
        default:
            return 0
        }
    }
    
    // MARK: - UIPickerViewDelegate methods
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return hours[row]
        case 1:
            return minutes[row]
        case 2:
            return amPm[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedHour = row + 1
        case 1:
            selectedMinute = row
        case 2:
            selectedAmPm = row
        default:
            break
        }
    }
    
    // MARK: - Public methods
    func getSelectedTime() -> String {
        return String(format: "%02d:%02d %@", selectedHour, selectedMinute, amPm[selectedAmPm])
    }
}
