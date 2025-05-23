//
//  HTTPMethod.swift
//  DineReserve
//
//  Created by Nazli Gonca on 22.03.2025.
//


import Foundation

// MARK: - Network Manager
class NetworkManager {
    static let shared = NetworkManager()
    private let session = URLSession(configuration: .default, delegate: YourDelegateClass(), delegateQueue: nil)
    private init() {}
    
    func request<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let request = endpoint.urlRequest else {
            completion(.failure(.invalidURL))
            return
        }
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.unknown(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.requestFailed))
                return
            }
            
            if !data.isEmpty {
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingError))
                }
            } else if T.self == EmptyResponse.self {
                completion(.success(EmptyResponse() as! T))
            } else {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}


//NetworkManager.shared.request(endpoint: CustomerAPI.fetchCustomers) { (result: Result<[Customer], APIError>) in
//    switch result {
//    case .success(let customer):
//        print(customer)
//    case .failure(let error):
//        print("Error: \(error)")
//    }
//}

class YourDelegateClass: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // Her türlü sertifikayı kabul et (SADECE GELİŞTİRME İÇİN)
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}
