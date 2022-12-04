//
//  Client.swift
//  breakingBadAPI
//
//  Created by Tarik Efe on 26.11.2022.
//

import Foundation

struct Constant {
    static let baseUrl = "https://www.breakingbadapi.com/api"
}

final class Client {
    static let shared = Client()
    private init() {}
    //MARK: Methods
    func makeRequest<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getCharacters(completion: @escaping (Result<[CharactersModel]?, Error>) -> Void) {
        guard let url = URL(string: "\(Constant.baseUrl)/characters") else { return }
        makeRequest(url: url, completion: completion)
    }
    
    func getSingleCharacter(with id: Int, completion: @escaping (Result<[CharactersModel]?, Error>) -> Void) {
        guard let url = URL(string: "\(Constant.baseUrl)/characters/\(id)") else {
            return
        }
        makeRequest(url: url, completion: completion)
    }
    
    func getQuotes(with authorName: String, with authorSurname: String, completion: @escaping (Result<[QuotesModel]?, Error>) -> Void) {
        guard let url = URL(string: "\(Constant.baseUrl)/quote?author=\(authorName)+\(authorSurname)") else {
            return
        }
        makeRequest(url: url, completion: completion)
    }
    
    func getEpisodes(completion: @escaping (Result<[EpisodeModel]?, Error>) -> Void) {
        guard let url = URL(string: "\(Constant.baseUrl)/episodes") else { return }
        makeRequest(url: url, completion: completion)
    }
}
