import Foundation
import QuartzCore

class Game: ObservableObject {
    static let boardSize = 8
    
    @Published var board = Board()
    
    var updater: CADisplayLink = CADisplayLink()

    init() {
        
        updater = CADisplayLink(target: self, selector: #selector(update))
        updater.preferredFrameRateRange = CAFrameRateRange(minimum: 40, maximum: 60)
        updater.add(to: .current, forMode: .default)
        
    }
    
    @objc
    func update() {
        
    }

    
}
