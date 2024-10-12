//
//  CounterViewModel.swift
//  Counter
//
//  Created by Lê Thọ Sơn on 12/10/24.
//

import Foundation

protocol RandomViewModelDelegate: AnyObject {
    func didUpdate(to value: RandomValue?)
}

class RandomViewModel {
    weak var delegate: RandomViewModelDelegate?
    
    private(set) var random: RandomValue?
    
    func randomNumber() {
        guard let url = URL(string: "https://www.random.org/integers/?num=1&min=0&max=99&col=1&base=10&format=plain&rnd=new") else {
            return
        }
        print("Start RANDOM")
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let self = self else { return }
            guard let data = data, error == nil else { return }
            guard let randomString = String.init(data: data, encoding: .utf8) else { return }
            guard let value = Int(randomString.trimmingCharacters(in: .whitespacesAndNewlines)) else { return }
            print("Random value = \(value)")
            DispatchQueue.main.async {
                self.delegate?.didUpdate(to: .init(value: value))
            }
        }
        task.resume()
    }
}
