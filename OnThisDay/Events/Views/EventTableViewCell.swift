//
//  EventTableViewCell.swift
//  OnThisDay
//
//  Created by Illia Verezei on 13.02.2025.
//

import UIKit

class EventTableViewCell: UITableViewCell {
  
  private let mainTitle = UILabel()
  private let descriptionLabel = UILabel()
  private let yearlabel = UILabel()
  private let addToFavoritesButton = UIButton()
  
  private var cellIndex: Int?
  weak var delegate: SelectedRowDelegate?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupMainTitle(mainTitle)
    setupDescriptionLabel(descriptionLabel)
    setupYearLabel(yearlabel)
    setupAddToFavoritesButton(addToFavoritesButton)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupMainTitle(_ title: UILabel) {
    title.textColor = UIColor(named: "AdaptiveTextColor")
    title.font = .systemFont(ofSize: 17, weight: .regular)
    title.numberOfLines = 0
    title.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(title)
    
    NSLayoutConstraint.activate([
      title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
    ])
  }
  
  private func setupDescriptionLabel(_ label: UILabel) {
    label.textColor = UIColor(named: "AdaptiveTextColor")
    label.font = .systemFont(ofSize: 13, weight: .regular)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(label)
    
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 4),
      label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
    ])
  }
  
  private func setupYearLabel(_ label: UILabel) {
    label.textColor = UIColor(named: "AdaptiveTextColor")
    label.font = .systemFont(ofSize: 13, weight: .regular)
    label.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(label)
    
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
      label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
    ])
  }
  
  private func setupAddToFavoritesButton(_ button: UIButton) {
    button.setTitle("Add to favotites", for: .normal)
    button.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
    button.setImage(UIImage(systemName: "star"), for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
    button.addTarget(self, action: #selector(addToFavoritesAction(_:)), for: .touchUpInside)
    button.isUserInteractionEnabled = true
    
    button.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(button)
    
    NSLayoutConstraint.activate([
      button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
      button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
    ])
  }
  
  func configureCell(title: String?, descriprion: String?, year: String?, index: Int, isSelected: Bool) {
    mainTitle.text = title
    descriptionLabel.text = descriprion
    yearlabel.text = "Year: \(year ?? "not defined")"
    cellIndex = index
    
    if isSelected {
      addToFavoritesButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
    }
  }
  
  @objc
  private func addToFavoritesAction(_ sender: UIButton) {
    guard let cellIndex = cellIndex else { return }
    delegate?.addToFavorites(index: cellIndex)
  }
}
