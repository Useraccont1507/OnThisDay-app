//
//  FeaturesViewController.swift
//  OnThisDay
//
//  Created by Illia Verezei on 14.02.2025.
//

import UIKit

class FavoritesViewController: UIViewController {
  
  private let viewModel: FavoritesViewModel
  private let tableView = UITableView()
  
  init(viewModel: FavoritesViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewController()
    setupTableView(tableView)
    bindTableView()
  }
  
  private func setupViewController() {
    view.backgroundColor = .systemBackground
    self.title = "Favorites"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.largeTitleDisplayMode = .automatic
  }
  
  private func setupTableView(_ table: UITableView) {
    table.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "cell")
    table.dataSource = self
    table.delegate = self
    table.estimatedRowHeight = 44
    table.rowHeight = UITableView.automaticDimension
    table.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(table)
    
    NSLayoutConstraint.activate([
      table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      table.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
  private func bindTableView() {
    viewModel.events.bind { [weak self ]_ in
      guard let self = self else { return }
      self.tableView.reloadData()
    }
  }
}

extension FavoritesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.events.value.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FavoritesTableViewCell
    cell.selectionStyle = .none
    let event = viewModel.events.value[indexPath.row]
    cell.configureCell(title: event.title, descriprion: event.description, year: event.year, type: event.type)
    return cell
  }
}

extension FavoritesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
      self.viewModel.deleteEvent(index: indexPath.row)
      completion(true)
    }
    return UISwipeActionsConfiguration(actions: [deleteAction])
  }
}
