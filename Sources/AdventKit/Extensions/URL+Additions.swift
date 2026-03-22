import Foundation

extension URL {
    func appending(pathComponent: String) -> URL {
        if #available(macOS 13, *) {
            return self.appending(component: pathComponent)
        } else {
            return self.appendingPathComponent(pathComponent)
        }
    }
}
