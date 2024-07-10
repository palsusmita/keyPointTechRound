//
//  YoutubeImageViewController.swift
//  keyPointTechRound
//
//  Created by susmita on 09/07/24.
//

import UIKit

class YoutubeImageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var youTubeTableView: UITableView!
    
    private var viewModel = youTubeImageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        youTubeTableView.delegate = self
        youTubeTableView.dataSource = self
        youTubeTableView.rowHeight = UITableView.automaticDimension
        youTubeTableView.estimatedRowHeight = 150
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    func registerTableView(){
        let tableViewNib = UINib(nibName: "YouTubeTableViewCell", bundle: nil)
        youTubeTableView.register(tableViewNib, forCellReuseIdentifier: "YouTubeTableViewCell")
    }
    func fetchData() {
        viewModel.fetchVideos { [weak self] result in
            switch result {
            case .success(let videos):
                DispatchQueue.main.async {
                    self?.youTubeTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching videos: \(error.localizedDescription)")
            }
        }
    }
    // MARK: - UITableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "YouTubeTableViewCell", for: indexPath) as? YouTubeTableViewCell{
            
            let item = viewModel.item(at: indexPath.row)
            cell.titleLabel?.text = item.title
            cell.descriptionLabel?.text = item.description
            if let imageURL = URL(string: item.thumbnailUrl) {
                cell.youTubeImage.loadImage(from: imageURL)
            }  
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the row after selection (optional)
        tableView.deselectRow(at: indexPath, animated: true)
        let mainStoryboard = UIStoryboard(name: "VideoPlayerViewController", bundle: nil)
        let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "VideoPlayerViewController") as! VideoPlayerViewController
        let item = viewModel.item(at: indexPath.row)
        mainVC.videoURL = item.videoUrl
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
}
