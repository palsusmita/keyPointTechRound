//
//  bannerImageViewModel.swift
//  keyPointTechRound
//
//  Created by susmita on 10/07/24.
//

import Foundation

class bannerImageViewModel {
    var banners: [BannerImageDataModel] = []
    
    func fetchData(completion: @escaping (Result<[BannerImageDataModel], Error>) -> Void) {
        guard let url = URL(string: "https://mocki.io/v1/0f9eb3e3-5835-435e-a455-b0e0beb23fb2") else {
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
            
            do {
                // Decode the nested JSON structure
                let decodedData = try JSONDecoder().decode(BannersResponse.self, from: data)
                print("Decoded Data: \(decodedData.data)")
                self.banners = decodedData.data
                completion(.success(decodedData.data))
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    func numberOfItems() -> Int {
        return banners.count
    }
    
    func item(at index: Int) -> BannerImageDataModel {
        return banners[index]
    }
}

