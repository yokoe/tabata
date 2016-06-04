import Foundation
import CoreImage

protocol ImageProcessOperation {
    func process(image: CIImage) -> CIImage
}