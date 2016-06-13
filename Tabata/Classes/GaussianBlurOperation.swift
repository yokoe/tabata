import Cocoa
import CoreImage

class GaussianBlurOperation {
    var radius: Float
    
    init(radius: Float) {
        self.radius = radius
    }
}

extension GaussianBlurOperation: ImageProcessOperation {
    func process(image: CIImage) -> CIImage {
        guard let blurFilter = CIFilter(name: "CIGaussianBlur") else {
            print("Failed to instantiate filter")
            return image
        }
        
        blurFilter.setValue(image, forKey: "inputImage")
        blurFilter.setValue(radius, forKey: "inputRadius")
        
        guard let blurImage = blurFilter.outputImage else {
            print("Filter ouput error.")
            return image
        }
        
        guard let cropFilter = CIFilter(name: "CICrop") else {
            print("Failed to instantiate crop filter")
            return image
        }
        
        let sourceImageExtent = image.extent
        cropFilter.setValue(blurImage, forKey: "inputImage")
        cropFilter.setValue(CIVector(x: 0, y: 0, z: sourceImageExtent.size.width, w: sourceImageExtent.size.height), forKey: "inputRectangle")
        
        guard let outputImage = cropFilter.outputImage else {
            print("Crop filter output error.")
            return image
        }
        
        return outputImage
    }
}