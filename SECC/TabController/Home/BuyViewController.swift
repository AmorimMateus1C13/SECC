//
//  BuyViewController.swift
//  SECC
//
//  Created by Mateus Amorim on 09/12/22.
//

import UIKit
import FSCalendar
import SnapKit

class BuyViewController: UIViewController {
    
    var indexFOrDateSelect: Int = 0
    lazy var dateSelect: [String] = []
    
    var calendar = FSCalendar()
    
    var displabel: UILabel = {
        let label = UILabel()
        label.text = "Disponibilidade"
        label.font = UIFont.boldSystemFont(ofSize: 21)
        
        label.textAlignment = .center
        
        return label
    }()
    
    var stackLeft: UIStackView = {
        var stack = UIStackView()
        stack.backgroundColor = .clear
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        stack.layer.masksToBounds = true
        stack.layer.cornerRadius = 15
        return stack
    }()
    
    var stackRight: UIStackView = {
        var stack = UIStackView()
        stack.backgroundColor = .clear
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        stack.layer.masksToBounds = true
        stack.layer.cornerRadius = 15
        return stack
    }()
    
    var whithdrawLabel: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Retirada:"
        label.backgroundColor = .clear
        
        return label
    }()
    
    var devolutionLabel: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Devolução:"
        label.backgroundColor = .clear
        
        return label
    }()
    
    var datePicker: UIDatePicker = {
        let date = UIDatePicker()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        date.backgroundColor = .clear
        date.datePickerMode = .time
        date.addTarget(self, action: #selector(datePickerTest(sender:)), for: UIControl.Event.valueChanged)
        let altere = dateFormatter.date(from: "9:00")
        date.date = altere ?? date.date
        
        date.backgroundColor = .white
        date.layer.borderWidth = 3
        date.layer.borderColor = Colors.borderButtons
        
        
        return date
    }()
    
    var devolutionDatePicker: UIDatePicker = {
        let date = UIDatePicker()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        date.datePickerMode = .time
        date.addTarget(self, action: #selector(datePickerTest(sender:)), for: UIControl.Event.valueChanged)
        let altere = dateFormatter.date(from: "17:00")
        date.date = altere ?? date.date
        date.layer.masksToBounds = true
        date.layer.cornerRadius = 5
        date.setValue(UIColor.clear, forKey: "backgroundColor")
        date.backgroundColor = .white
        date.layer.borderWidth = 3
        date.layer.borderColor = Colors.borderButtons
        
        return date
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addInView()
        makeConstrants()
        calendarConfig()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.LoginView.backgroundView
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        calendar.delegate = self
    }
    
    
    @objc func datePickerTest(sender: UIDatePicker) {
        print("works!")
    }
}

extension BuyViewController {
    func addInView() {
        view.addSubview(displabel)
        view.addSubview(calendar)
        view.addSubview(stackLeft)
        stackLeft.addArrangedSubview(whithdrawLabel)
        stackLeft.addArrangedSubview(datePicker)
        view.addSubview(stackRight)
        stackRight.addArrangedSubview(devolutionLabel)
        stackRight.addArrangedSubview(devolutionDatePicker)
    }
    
    func makeConstrants() {
        
        displabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.leading.equalToSuperview()
        }
        
        calendar.snp.makeConstraints { make in
            make.top.equalTo(displabel.snp.bottom).offset(8)
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(220)
        }
        
        stackLeft.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(8)
            make.width.equalTo(view.frame.size.width/2 - 12)
        }
        
        stackRight.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.width.equalTo(view.frame.size.width/2 - 12)
        }
    }
    
    func calendarConfig() {
        calendar.backgroundColor = .white
        calendar.layer.cornerRadius = 15
        calendar.scrollDirection = .horizontal
        calendar.appearance.weekdayTextColor = .systemPink
        calendar.appearance.headerTitleColor = .systemBlue
        
        calendar.allowsMultipleSelection = true
    }
}

extension BuyViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE dd-MM-YYYY"
        let dateString = formatter.string(from: date)
        
        let hour = Calendar.current.component(.hour, from: Date())
        let minutes = Calendar.current.component(.minute, from: Date())
        let seconds = Calendar.current.component(.second, from: Date())
        
        dateSelect.append(dateString)
        indexFOrDateSelect += 1
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE dd-MM-YYYY"
        let dateString = formatter.string(from: date)
        
        var dateRemove: [String] = []
        dateRemove.append(dateString)
        
        dateSelect = dateSelect.filter { $0 != dateString }
    }
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        if date.compare(Date()) == .orderedAscending {
            return false
        }
        else {
            return true
        }
    }
}
