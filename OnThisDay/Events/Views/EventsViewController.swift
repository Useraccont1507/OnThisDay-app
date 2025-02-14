//
//  EventsViewController.swift
//  OnThisDay
//
//  Created by Illia Verezei on 13.02.2025.
//

import UIKit

class EventsViewController: UIViewController {
  
  private let viewModel: EventsViewModel
  private let eventsTableView = UITableView()
  
  init(viewModel: EventsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupTableView(eventsTableView)
    bindTableView()
  }
  
  private func setupView() {
    self.title = viewModel.eventType.rawValue.capitalized
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.largeTitleDisplayMode = .automatic
  }
  
  private func setupTableView(_ table: UITableView) {
    table.register(EventTableViewCell.self, forCellReuseIdentifier: "cell")
    table.estimatedRowHeight = 44
    table.rowHeight = UITableView.automaticDimension
    table.dataSource = self
    table.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(table)
    
    NSLayoutConstraint.activate([
      table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  
  private func bindTableView() {
    viewModel.events.bind(listener: { [weak self] value in
      guard let self = self else { return }
      self.eventsTableView.reloadData()
    })
  }
}

extension EventsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.events.value.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EventTableViewCell
    let event = viewModel.events.value[indexPath.row]
    let isSelected = viewModel.selectedRows.contains(indexPath.row)
    cell.delegate = self
    cell.configureCell(title: event.title, descriprion: event.description, year: event.year, index: indexPath.row, isSelected: isSelected)
    cell.selectionStyle = .none
    return cell
  }
}

extension EventsViewController: SelectedRowDelegate {
  func addToFavorites(index: Int) {
    viewModel.selectedRows.append(index)
    viewModel.saveEvent(index: index)
    eventsTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
  }
}
