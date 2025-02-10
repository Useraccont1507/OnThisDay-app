//
//  GreetingViewController.swift
//  OnThisDay
//
//  Created by Illia Verezei on 10.02.2025.
//

import UIKit
import SwiftUI

class GreetingViewController: UIViewController {
  
  private var viewModel: GreetingViewModelProtocol
  
  private let labelStack = UIStackView()
  private let appNameLabel = UILabel()
  private let descriptionLabel = UILabel()
  private let startButton = UIButton()
  
  init(viewModel: GreetingViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupStackView(stack: labelStack)
    setupAppNameLabel(appNameLabel)
    setupDescriptionLabel(descriptionLabel)
    setupStartButton(startButton)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    startAnimate()
  }
  
  override func viewDidLayoutSubviews() {
    calculateButtonCornerRadius(startButton)
  }
  
  private func setupStackView(stack: UIStackView) {
    stack.axis = .vertical
    stack.alpha = 0
    stack.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(stack)
    
    NSLayoutConstraint.activate([
      stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
    ])
  }
  
  private func setupAppNameLabel(_ label: UILabel) {
    label.text = "On this day"
    label.font = .systemFont(ofSize: 32, weight: .bold)
    label.textAlignment = .center
    label.textColor = UIColor(named: "AdaptiveTextColor")
    labelStack.addArrangedSubview(label)
  }
  
  private func setupDescriptionLabel(_ label: UILabel) {
    label.text = "find interesting historical events that happened today"
    label.font = .systemFont(ofSize: 21, weight: .regular)
    label.textAlignment = .center
    label.numberOfLines = 0
    label.textColor = UIColor(named: "AccentColor")
    label.translatesAutoresizingMaskIntoConstraints = false
    
    labelStack.addArrangedSubview(label)
  }
  
  private func setupStartButton(_ button: UIButton) {
    button.alpha = 0
    button.isUserInteractionEnabled = false
    button.setTitle("Start".uppercased(), for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = UIColor(named: "AccentColor")
    button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)
    
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 84),
      button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
      button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08)
    ])
  }
  
  private func calculateButtonCornerRadius(_ button: UIButton) {
    button.layer.cornerRadius =  button.bounds.height / 2
    button.layer.masksToBounds = true
  }
  
  private func startAnimate() {
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
      self.labelStack.alpha = 1
      self.startButton.transform = CGAffineTransform(translationX: 0, y: -100)
      self.startButton.alpha = 1
    } completion: { isCompleted in
      if isCompleted {
        self.startButton.isUserInteractionEnabled = true
      }
    }
  }
  
  @objc
  private func buttonAction() {
    viewModel.moveToMainScreen()
  }
}
