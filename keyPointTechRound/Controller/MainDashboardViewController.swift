//
//  MainDashboardViewController.swift
//  keyPointTechRound
//
//  Created by susmita on 09/07/24.
//

import UIKit

class MainDashboardViewController: UIViewController {
    
    private lazy var firstVC: YoutubeImageViewController = {
        let storyboard = UIStoryboard(name: "YoutubeImageViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "YoutubeImageViewController") as! YoutubeImageViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var secondVC: bannerImageViewController = {
        let storyboard = UIStoryboard(name: "bannerImageViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "bannerImageViewController") as! bannerImageViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        // Initial setup to show the first view controller
        firstVC.view.isHidden = false
        secondVC.view.isHidden = true
        let rightButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(navigationButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
    }
    @objc func navigationButtonTapped() {
        let alert = UIAlertController(title: "Alert", message: "message will add soon..", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    private func setupSegmentedControl() {
        // Assuming you have a UISegmentedControl connected via IBOutlet
        // Configure the segmented control here if needed
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
        viewController.view.isHidden = true
    }
    
    
    @IBAction func didTapSegment(segment: UISegmentedControl){
        firstVC.view.isHidden = true
        secondVC.view.isHidden = true
        
        if segment.selectedSegmentIndex == 0 {
            firstVC.view.isHidden = false
        }else{
            secondVC.view.isHidden = false
        }
    }
}
