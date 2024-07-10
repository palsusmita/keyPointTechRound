//
//  youTubeImageViewModel.swift
//  keyPointTechRound
//
//  Created by susmita on 09/07/24.
//

import Foundation

class youTubeImageViewModel {
    var videos: [youTubeImageDataModel] = []
    
    func fetchVideos(completion: @escaping (Result<[youTubeImageDataModel], Error>) -> Void) {
        guard let url = URL(string: "https://mocki.io/v1/ca612508-4a99-4f79-b341-b85ddd37d7b8") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            print("Data received: \(data)")
            
            do {
                let decodedData = try JSONDecoder().decode([youTubeImageDataModel].self, from: data)
                self.videos = decodedData
                completion(.success(decodedData))
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    func numberOfItems() -> Int {
        return videos.count
    }
    
    func item(at index: Int) -> youTubeImageDataModel {
        return videos[index]
    }
}
