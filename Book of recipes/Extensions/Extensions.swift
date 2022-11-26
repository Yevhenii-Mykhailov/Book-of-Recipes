//
//  Extensions.swift
//  Book of recipes
//
//  Created by Yevhenii M on 23.11.2022.
//

import UIKit

extension UIImageView {
    func load(stringUrl: String) {
        if let url = URL(string: stringUrl) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
