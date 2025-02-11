//
//  MainViewController.swift
//  OnThisDay
//
//  Created by Illia Verezei on 10.02.2025.
//

import UIKit

class MainViewController: UIViewController {
  
  private let searchTitle = UILabel()
  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLayout())
  private let largeButtonStack = UIStackView()
  private let dateNowButton = UIButton()
  private let chooseDateButton = UIButton()
  private let searchButton = UIButton()
  private let orLabel = UILabel()
  private let showFavorites = UIButton()
  
  private var viewModel: MainViewModel
  
  init(viewModel: MainViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.backItem?.setHidesBackButton(true, animated: true)
    navigationController?.navigationBar.prefersLargeTitles = true
    self.title = "On this day"
    setupSearchTitle(searchTitle)
    setupCollectionView(collectionView)
    setupLargeButtonStackView(largeButtonStack)
    setupDateNowButton(dateNowButton)
    setupChooseDateButton(chooseDateButton)
    setupSearchButton(searchButton)
    setupOrLabel(orLabel)
    setupShowFavoritesButton(showFavorites)
    bindButtons()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    calculateLargeButtonCorenerRadius(button: dateNowButton)
    calculateLargeButtonCorenerRadius(button: chooseDateButton)
    calculateSearchButtonCorenerRadius(button: searchButton)
  }
  
  private func setupSearchTitle(_ title: UILabel) {
    title.text = "Search for: "
    title.font = .systemFont(ofSize: 21, weight: .semibold)
    title.textColor = UIColor(named: "AdaptiveTextColor")
    title.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(title)
    
    NSLayoutConstraint.activate([
      title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4)
    ])
  }
  
  private func setupCollectionView(_ collection: UICollectionView) {
    collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    collection.dataSource = self
    collection.delegate = self
    collection.showsHorizontalScrollIndicator = false
    collection.bounces = false
    collection.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(collection)
    
    NSLayoutConstraint.activate([
      collection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collection.topAnchor.constraint(equalTo: searchTitle.bottomAnchor, constant: 16),
      collection.heightAnchor.constraint(equalToConstant: 59)
    ])
  }
  
  private func setupLargeButtonStackView(_ stack: UIStackView) {
    stack.axis = .horizontal
    stack.spacing = 16
    stack.distribution = .fillEqually
    stack.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(stack)
    
    NSLayoutConstraint.activate([
      stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      stack.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
      stack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
    ])
  }
  
  private func setupDateNowButton(_ button: UIButton) {
    button.layer.borderWidth = 3
    button.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
    var config = UIButton.Configuration.plain()
    config.image = UIImage(systemName: "clock")
    config.title = "Now"
    config.imagePlacement = .top
    config.imagePadding = 8
    button.configuration = config
    button.tintColor = UIColor(named: "AdaptiveTextColor")
    button.addTarget(self, action: #selector(selectDateNow), for: .touchUpInside)
    largeButtonStack.addArrangedSubview(button)
  }
  
  private func setupChooseDateButton(_ button: UIButton) {
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor.gray.cgColor
    var config = UIButton.Configuration.plain()
    config.image = UIImage(systemName: "calendar")
    config.title = "Choose date"
    config.imagePlacement = .top
    config.imagePadding = 8
    button.configuration = config
    button.tintColor = UIColor(named: "AdaptiveTextColor")
    button.addTarget(self, action: #selector(chooseDate), for: .touchUpInside)
    largeButtonStack.addArrangedSubview(button)
  }
  
  private func setupSearchButton(_ button: UIButton) {
    button.setTitle("search".uppercased(), for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = UIColor(named: "AccentColor")
    button.addTarget(self, action: #selector(moveToSearch), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)
    
    NSLayoutConstraint.activate([
      button.topAnchor.constraint(equalTo: largeButtonStack.bottomAnchor, constant: 16),
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
      button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08)
    ])
  }
  
  private func setupOrLabel(_ label: UILabel) {
    label.text = "or"
    label.font = .systemFont(ofSize: 17, weight: .regular)
    label.textColor = UIColor(named: "AdaptiveTextColor")
    label.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(label)
    
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      label.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 8)
    ])
  }
  
  private func setupShowFavoritesButton(_ button: UIButton) {
    button.setTitle("show favorites", for: .normal)
    button.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
    button.addTarget(self, action: #selector(moveToFavorites), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)
    
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.topAnchor.constraint(equalTo: orLabel.bottomAnchor),
      button.widthAnchor.constraint(equalToConstant: 110),
      button.widthAnchor.constraint(equalTo: searchButton.widthAnchor, multiplier: 0.8)
    ])
  }
  
  @objc
  private func selectDateNow() {
    viewModel.selectDateNow()
  }
  
  @objc
  private func chooseDate() {
    viewModel.chooseDate(from: self)
  }
  
  @objc
  private func moveToSearch() {
    
  }
  
  @objc
  private func moveToFavorites() {
    
  }
  
  private func bindButtons() {
    viewModel.dateType.bind { dateType in
      if dateType == .custom {
        self.dateNowButton.layer.borderColor = UIColor.gray.cgColor
        self.dateNowButton.layer.borderWidth = 1
        self.chooseDateButton.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        self.chooseDateButton.layer.borderWidth = 3
      } else {
        self.chooseDateButton.layer.borderColor = UIColor.gray.cgColor
        self.chooseDateButton.layer.borderWidth = 1
        self.dateNowButton.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        self.dateNowButton.layer.borderWidth = 3
      }
    }
  }
  
  private func calculateLargeButtonCorenerRadius(button: UIButton) {
    button.layer.cornerRadius = largeButtonStack.bounds.height / 5
  }
  
  private func calculateSearchButtonCorenerRadius(button: UIButton) {
    button.layer.cornerRadius = button.bounds.height / 2
  }
}

class CollectionViewLayout: UICollectionViewFlowLayout {
  override init() {
    super.init()
    scrollDirection = .horizontal
    itemSize = CGSize(width: 100, height: 50)
    minimumLineSpacing = 16
  
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MainViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    var configuration = UIListContentConfiguration.cell()
    configuration.text = "test"
    configuration.textProperties.alignment = .center
    configuration.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    cell.contentConfiguration = configuration
    cell.layer.cornerRadius = cell.bounds.height / 2
    cell.layer.borderColor = UIColor.gray.cgColor
    cell.layer.borderWidth = 1
    return cell
  }
}

extension MainViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
  }
}
