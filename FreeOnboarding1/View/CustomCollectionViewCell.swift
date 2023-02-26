//
//  CustomCollectionViewCell.swift
//  FreeOnboarding1
//
//  Created by Sooik Kim on 2023/02/26.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    private var index: IndexPath?
    weak var delegate: CustomDelegate?
    
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "photo")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    private var progressView: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = .lightGray
        view.progressTintColor = .systemBlue
        view.progress = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    private var button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBlue
        button.setTitle("Load", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(imageView)
        addSubview(progressView)
        addSubview(button)
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        autoLayout()
    }
    
    func setIndex(_ index: IndexPath) {
        self.index = index
    }
    
    func setImage(image: UIImage?) {
        DispatchQueue.main.async {
            if let newImage = image {
                self.imageView.image = newImage
            } else {
                self.imageView.image = UIImage(systemName: "photo")
            }
        }
        
    }
    
    @objc private func buttonAction() {
//        DispatchQueue.main.async {
//            self.imageView.image = UIImage(systemName: "photo")
//        }
        guard let index = self.index else { return }
        delegate?.fetchImage(index)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            
            button.widthAnchor.constraint(equalToConstant: 80),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 35),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            progressView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            progressView.centerYAnchor.constraint(equalTo: centerYAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 10),
            progressView.trailingAnchor.constraint(equalTo: button.leadingAnchor),
            
        ])
    }
}
