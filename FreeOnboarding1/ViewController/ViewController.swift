//
//  ViewController.swift
//  FreeOnboarding1
//
//  Created by Sooik Kim on 2023/02/26.
//

import UIKit

class ViewController: UIViewController {
    
    private let model = NetworkModel()
    
    private var stringData = [
        "https://t1.daumcdn.net/cfile/tistory/2322FE4157D570DD26",
        "https://photo.coolenjoy.co.kr/data/editor/1807/Bimg_20180716182301_rvwweucn.jpg",
        "https://i.pinimg.com/736x/85/f5/e8/85f5e8d3de6214bbc7a54a13612a908b.jpg",
        "https://m.media-amazon.com/images/M/MV5BMjE5MzcyNjk1M15BMl5BanBnXkFtZTcwMjQ4MjcxOQ@@._V1_FMjpg_UX1000_.jpg",
        "https://www.thefactsite.com/wp-content/uploads/2021/06/iron-man-facts.jpg",
    ]
    
    private var images: [UIImage?] = [nil, nil, nil, nil, nil]
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.setTitle("Load All Images", for: .normal)
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let width = UIScreen.main.bounds.width
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width - 32, height: 100)
        layout.scrollDirection = .vertical
        
        collectionView.collectionViewLayout = layout
        
        button.addTarget(self, action: #selector(fetchImages), for: .touchUpInside)
    }
    
    
    @objc func fetchImages() {
        for i in 0..<stringData.count {
            model.fetchImage(from: stringData[i], completion: { image in
                self.images[i] = image
                DispatchQueue.main.async {
                    self.collectionView.reloadItems(at: [IndexPath(row: i, section: 0)])
                }
                
            })
        }
    }
    


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        cell.delegate = self
        cell.setIndex(indexPath)
        cell.setImage(image: images[indexPath.row])
        return cell
    }
}


extension ViewController: CustomDelegate {
    func fetchImage(_ index: IndexPath) {
        model.fetchImage(from: stringData[index.row], completion: { image in
            self.images[index.row] = image
            DispatchQueue.main.async {
                self.collectionView.reloadItems(at: [index])
            }
        })
    }
}
