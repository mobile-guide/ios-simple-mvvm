//
//  ViewController.swift
//  Counter
//
//  Created by Lê Thọ Sơn on 12/10/24.
//

import UIKit

class RandomViewController: UIViewController {
    let randomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 120, weight: .bold)
        label.textAlignment = .center
        label.text = "_"
        return label
    }()
    
    let randomButton: UIButton = {
        let button = UIButton()
        button.configuration = .tinted()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Random", for: .normal)
        return button
    }()
    
    private var viewModel = RandomViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
    }
    
    private func setupUI() {
        
        view.addSubview(randomLabel)
        view.addSubview(randomButton)
        NSLayoutConstraint.activate([
            randomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            randomLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            randomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            randomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        randomButton.addTarget(self, action: #selector(countButtonTapped), for: .touchUpInside)
    }
    
    @IBAction func countButtonTapped(_ sender: UIButton) {
        viewModel.randomNumber()
    }
}

extension RandomViewController: RandomViewModelDelegate {
    func didUpdate(to value: RandomValue?) {
        if let value = value {
            randomLabel.text = value.toString()
        }
    }
}
