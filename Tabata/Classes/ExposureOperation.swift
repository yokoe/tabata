import Cocoa

class ExposureOperation {
    var ev: Float
    
    init(ev: Float) {
        self.ev = ev
    }
}

extension ExposureOperation: ImageProcessOperation {
    func process(image: CIImage) -> CIImage {
        guard let filter = CIFilter(name: "CIExposureAdjust") else {
            print("Failed to instantiate filter")
            return image
        }
        
        filter.setValue(image, forKey: kCIInputImageKey)
        filter.setValue(ev, forKey: "inputEV")
        
        guard let outputImage = filter.outputImage else {
            print("Filter ouput error.")
            return image
        }
        
        return outputImage
    }
}
