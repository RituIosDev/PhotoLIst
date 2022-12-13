//
//  APIService.swift
//  LightSpeedSample
//
//  Created by Ritu on 2022-12-08.
//

import UIKit

protocol APIServiceProtocol {
    func fetchPhotos(completion: @escaping ([Photos], Error?) -> Void)
}

class APIService: APIServiceProtocol {

    //MARK: - Fetch Service
    func fetchPhotos(completion: @escaping ([Photos], Error?) -> Void) {
        guard let url = URL(string: baseUrl) else {
            return
        }
        request(url: url) { data, error in
            if let data = data,
               let photosData = try? JSONDecoder().decode([Photos].self, from: data) {
                completion(photosData, error)
            }

        }
    }
    
    //Common Get method which any method can use to get the data from server
    func request(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching : \(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            completion(data, error)
        })
        task.resume()
    }

}

    
    

