//
//  CalendarViewController.swift
//  OnThisDay
//
//  Created by Illia Verezei on 12.02.2025.
//

import UIKit

class CalendarViewController: UIViewController {
  
  private let toolBar = UIToolbar()
  private let datePicker = UIDatePicker()
  
  
  private let viewModel: CalendarViewModel
  
  init(viewModel: CalendarViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setupToolBar(toolBar)
    setupCalendarView(datePicker)
  }
  
  private func setupToolBar(_ bar: UIToolbar) {
    bar.barTintColor = .systemBackground
    bar.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(bar)
    
    NSLayoutConstraint.activate([
      bar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      bar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      bar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    
    let doneItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAction))
    
    toolBar.items = [
      UIBarButtonItem(systemItem: .flexibleSpace),
      doneItem
    ]
  }
  
  private func setupCalendarView(_ picker: UIDatePicker) {
    picker.date = viewModel.selectedDate
    picker.datePickerMode = .date
    picker.preferredDatePickerStyle = .inline
    picker.calendar = .autoupdatingCurrent
    picker.locale = .autoupdatingCurrent
    picker.timeZone = .autoupdatingCurrent
    picker.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(picker)
    
    NSLayoutConstraint.activate([
      picker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      picker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      picker.topAnchor.constraint(equalTo: toolBar.bottomAnchor),
      picker.heightAnchor.constraint(equalTo: picker.widthAnchor)
    ])
  }
  
  @objc
  private func doneAction() {
    viewModel.updateDate(date: datePicker.date, vc: self)
  }
}
