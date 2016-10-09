import Foundation
import CoreImage

protocol ImageProcessOperation {
    func process(_ image: CIImage) -> CIImage
}
