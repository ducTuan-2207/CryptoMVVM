import Foundation

enum CryptoError: Error {
    case serverError
    case parsingError
}

class Webservice {
    func downloadCurrencies(url: URL, completion: @escaping (Result<[Crypto], CryptoError>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.serverError))
            } else if let data = data {
                do {
                    let cryptoList = try JSONDecoder().decode([Crypto].self, from: data)
                    completion(.success(cryptoList))
                } catch {
                    completion(.failure(.parsingError))
                }
            }
        }.resume()
    }
}
