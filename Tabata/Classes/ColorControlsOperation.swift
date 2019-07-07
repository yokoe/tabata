import Cocoa

class ColorControlsOperation: NSObject {
    static let DefaultBrightness: Float = 0
    static let DefaultSaturation: Float = 1
    static let DefaultContrast: Float = 1
    
    var brightness: Float?
    var saturation: Float?
    var contrast: Float?
    
    init?(brightness: Float?, saturation: Float?, contrast: Float?) {
        if brightness == nil && saturation == nil && contrast == nil {
            return nil
        }
        
        if brightness == ColorControlsOperation.DefaultBrightness &&
            saturation == ColorControlsOperation.DefaultSaturation &&
            contrast == ColorControlsOperation.DefaultContrast {
            return nil
        }
        
        self.brightness = brightness
        self.saturation = saturation
        self.contrast = contrast
    }
    
    override var debugDescription: String {
        return "<ColorControlsOperation \(brightness ?? -1), \(contrast ?? -1)>"
    }
}

extension ColorControlsOperation: ImageProcessOperation {
    func process(_ image: CIImage) -> CIImage {
        guard let colorFilter = CIFilter(name: "CIColorControls") else {
            print("Failed to instantiate color filter")
            return image
        }
        
        colorFilter.setValue(image, forKey: "inputImage")
        if let brightness = brightness {
            colorFilter.setValue(brightness, forKey: "inputBrightness")
        }
        
        if let saturation = saturation {
            colorFilter.setValue(saturation, forKey: "inputSaturation")
        }
        
        if let contrast = contrast {
            colorFilter.setValue(contrast, forKey: "inputContrast")
        }
        
        guard let outputImage = colorFilter.outputImage else {
            print("Filter ouput error.")
            return image
        }
        return outputImage
    }
}
