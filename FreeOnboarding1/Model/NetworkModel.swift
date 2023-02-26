//
//  NetworkModel.swift
//  FreeOnboarding1
//
//  Created by Sooik Kim on 2023/02/26.
//

import UIKit

class NetworkModel {
    func fetchImage(from url: String, completion: @escaping (UIImage) -> ())  {
        let url = URL(string: url)!
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else { return }
            guard let image = UIImage(data: data) else { return }
            completion(image)
        })
        dataTask.resume()
    }
}
