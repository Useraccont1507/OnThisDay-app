//
//  FavoritesTableViewCell.swift
//  OnThisDay
//
//  Created by Illia Verezei on 14.02.2025.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
  
  private let mainTitle = UILabel()
  private let descriptionLabel = UILabel()
  private let yearlabel = UILabel()
  private let typeLabel = UILabel()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupMainTitle(mainTitle)
    setupDescriptionLabel(descriptionLabel)
    setupYearLabel(yearlabel)
    setupTypeLabel(typeLabel)
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
  
  private func setupTypeLabel(_ label: UILabel) {
    label.textColor = UIColor(named: "AdaptiveTextColor")
    label.font = .systemFont(ofSize: 13, weight: .regular)
    label.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(label)
    
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
      label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
    ])
  }
  
  func configureCell(title: String?, descriprion: String?, year: String?, type: String?) {
    mainTitle.text = title
    descriptionLabel.text = descriprion
    yearlabel.text = "Year: \(year ?? "not defined")"
    typeLabel.text = "Type: \(type ?? "not defined")"
  }
}


