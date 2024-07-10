//
//  bannerImageViewController.swift
//  keyPointTechRound
//
//  Created by susmita on 09/07/24.
//

import UIKit

class bannerImageViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var timer: Timer?
    var currentIndex = 0
    var viewModel = bannerImageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCell()
        setupCollectionViewLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        startAutoScrolling()
        fetchData()
    }
    func registerCollectionViewCell(){
        let nibName = UINib(nibName: "BannerCollectionViewCell", bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "BannerCollectionViewCell")
    }
    func setupCollectionViewLayout(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0 // No space between items
        layout.itemSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        collectionView.collectionViewLayout = layout
    }
    func startAutoScrolling() {
        // Invalidate existing timer if any
        timer?.invalidate()
        
        // Create a new timer to scroll every 5 seconds
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc func autoScroll() {
        // Calculate next index path to scroll to
        currentIndex = (currentIndex + 1) % collectionView.numberOfItems(inSection: 0)
        
        let nextIndexPath = IndexPath(item: currentIndex, section: 0)
        
        // Scroll to next index path
        collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    }
    func fetchData() {
        viewModel.fetchData { result in
            switch result {
            case .success(let banners):
                // Use `banners` array here, update UI, etc.
                print("Fetched \(banners.count) banners.")
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error fetching banners: \(error)")
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
        
        let item = viewModel.item(at: indexPath.row)
        if let imageURL = URL(string: item.imageMobile) {
            cell.bannerImage.loadImage(from: imageURL)
            
        }
        return cell
    }    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    //    deinit {
    //           timer?.invalidate()
    //       }
}
