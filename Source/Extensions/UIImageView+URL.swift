import UIKit

extension UIImageView {
    func load(url: URL?, cache: URLCache? = nil) {
        guard let url else {
            return
        }

        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)

        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        } else {
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

                let startRange = 200
                let endRange = 299

                guard
                    let data,
                    let httpResponse = response as? HTTPURLResponse,
                    startRange ... endRange ~= httpResponse.statusCode,
                    let image = UIImage(data: data) else {
                    return
                }

                let cachedData = CachedURLResponse(response: httpResponse, data: data)
                cache.storeCachedResponse(cachedData, for: request)
                DispatchQueue.main.async {
                    self?.image = image
                }
            }.resume()
        }
    }
}
