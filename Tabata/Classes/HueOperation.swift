import Cocoa

class HueOperation {
    static let DefaultHue: Float = 0
    
    var hue: Float
    
    init?(hue: Float) {
        if hue == HueOperation.DefaultHue {
            return nil
        }
        self.hue = hue
    }
}

extension HueOperation: ImageProcessOperation {
    func process(_ image: CIImage) -> CIImage {
        guard let colorFilter = CIFilter(name: "CIHueAdjust") else {
            print("Failed to instantiate color filter")
            return image
        }
        
        colorFilter.setValue(image, forKey: "inputImage")
        colorFilter.setValue(hue, forKey: "inputAngle")
        
        guard let outputImage = colorFilter.outputImage else {
            print("Filter ouput error.")
            return image
        }
        return outputImage
    }
}
