//
//  OnboardingViewController.swift
//  keyPointTechRound
//
//  Created by susmita on 09/07/24.
//

import UIKit

class OnboardingViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, OnboardingViewModelDelegate {
    
    private var viewModel = OnboardingViewModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCollectionViewCell()
        setupCollectionViewLayout()
        
        viewModel.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        //  collectionView.isPagingEnabled = true
        
        if !viewModel.shouldShowOnboarding() {
            goToMainDashboard()
        }
    }
    
    private func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0 // No space between items
        layout.itemSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        collectionView.collectionViewLayout = layout
    }
    func registerCollectionViewCell(){
        let nibName = UINib(nibName: "OnboardingCell", bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "OnboardingCell")
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // Move to the next page in collection view
        viewModel.moveToNextPage()
    }
    private func getCurrentIndexPath() -> IndexPath? {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        return collectionView.indexPathForItem(at: visiblePoint)
    }
    func goToMainDashboard() {
        let mainStoryboard = UIStoryboard(name: "MainDashboardViewController", bundle: nil)
        let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "MainDashboardViewController") as! MainDashboardViewController
        
        // Replace the navigation stack with MainDashboardViewController
        if let navigationController = self.navigationController {
            navigationController.setViewControllers([mainVC], animated: true)
        }
    }
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
        let item = viewModel.items[indexPath.item]
        cell.imageView.image = UIImage(named: item.imageName)
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func didMoveToNextPage() {
        let indexPath = IndexPath(item: viewModel.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func didFinishOnboarding() {
        goToMainDashboard()
    }
    
    
}

