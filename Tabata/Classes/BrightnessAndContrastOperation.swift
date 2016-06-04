import Cocoa

class BrightnessAndContrastOperation: NSObject {
    static let DefaultBrightness: Float = 0
    static let DefaultContrast: Float = 1
    
    var brightness: Float?
    var contrast: Float?
    
    init?(brightness: Float?, contrast: Float?) {
        if brightness == nil && contrast == nil {
            return nil
        }
        
        if brightness == BrightnessAndContrastOperation.DefaultBrightness && contrast == BrightnessAndContrastOperation.DefaultContrast {
            return nil
        }
        
        self.brightness = brightness
        self.contrast = contrast
    }
    
    override var debugDescription: String {
        return "<BrightnessAndConstract \(brightness), \(contrast)>"
    }
}

extension BrightnessAndContrastOperation: ImageProcessOperation {
    func process(image: CIImage) -> CIImage {
        guard let colorFilter = CIFilter(name: "CIColorControls") else {
            print("Failed to instantiate color filter")
            return image
        }
        
        colorFilter.setValue(image, forKey: "inputImage")
        colorFilter.setValue(brightness, forKey: "inputBrightness")
        colorFilter.setValue(contrast, forKey: "inputContrast")
        
        guard let outputImage = colorFilter.outputImage else {
            print("Filter ouput error.")
            return image
        }
        return outputImage
    }
}