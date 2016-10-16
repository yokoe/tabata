import Cocoa

class ScaleOperation {
    var scale: Float
    
    init(scale: Float) {
        self.scale = scale
    }
}

extension ScaleOperation: ImageProcessOperation {
    func process(_ image: CIImage) -> CIImage {
        guard let filter = CIFilter(name: "CILanczosScaleTransform") else {
            print("Failed to instantiate filter")
            return image
        }
        
        filter.setValue(image, forKey: kCIInputImageKey)
        filter.setValue(scale, forKey: "inputScale")
        
        guard let outputImage = filter.outputImage else {
            print("Filter ouput error.")
            return image
        }
        
        return outputImage
    }
}
