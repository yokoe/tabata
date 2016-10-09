import Cocoa

// https://developer.apple.com/library/mac/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_filer_recipes/ci_filter_recipes.html#//apple_ref/doc/uid/TP30001185-CH4-SW17
class TiltShiftOperation {
    var radius: Float
    
    init(radius: Float) {
        self.radius = radius
    }
}

extension TiltShiftOperation: ImageProcessOperation {
    func process(_ image: CIImage) -> CIImage {
        let blurImage = GaussianBlurOperation(radius: radius).process(image)
        
        guard let filter = CIFilter(name: "CIBlendWithMask") else {
            print("Failed to instantiate filter CIBlendWithMask")
            return image
        }
        
        guard let mask = maskImage(blurImage.extent) else {
            print("Failed to create mask image")
            return image
        }
        
        filter.setValue(blurImage, forKey: kCIInputImageKey)
        filter.setValue(image, forKey: kCIInputBackgroundImageKey)
        filter.setValue(mask, forKey: kCIInputMaskImageKey)
        
        guard let outputImage = filter.outputImage else {
            print("CIBlendWithMask filter output error.")
            return image
        }
        
        return outputImage
    }
    
    fileprivate func greenGradientImageInRect(_ rect: CGRect, point0: CIVector, point1: CIVector) -> CIImage? {
        guard let gradientFilter = CIFilter(name: "CILinearGradient") else {
            print("Failed to instantiate filter CILinearGradient")
            return nil
        }
        gradientFilter.setValue(point0, forKey: "inputPoint0")
        gradientFilter.setValue(CIColor(red: 0, green: 1, blue: 0, alpha: 1), forKey: "inputColor0")
        gradientFilter.setValue(point1, forKey: "inputPoint1")
        gradientFilter.setValue(CIColor(red: 0, green: 1, blue: 0, alpha: 0), forKey: "inputColor1")
        
        guard let gradientImage = gradientFilter.outputImage else {
            print("CILinearGradient filter output error.")
            return nil
        }
        
        guard let cropFilter = CIFilter(name: "CICrop") else {
            print("Failed to instantiate filter CICrop")
            return nil
        }
        
        cropFilter.setValue(gradientImage, forKey: kCIInputImageKey)
        cropFilter.setValue(CIVector(cgRect: rect), forKey: "inputRectangle")
        
        guard let outputImage = cropFilter.outputImage else {
            print("CICrop filter output error.")
            return nil
        }
        
        return outputImage
    }
    
    fileprivate func maskImage(_ rect: CGRect) -> CIImage? {
        let height = rect.height
        
        guard let filter = CIFilter(name: "CIAdditionCompositing") else {
            print("Failed to instantiate filter CIAdditionCompositing")
            return nil
        }
        
        guard let topGradient = greenGradientImageInRect(rect, point0: CIVector(x: 0, y: 0.75 * height), point1: CIVector(x: 0, y: 0.5 * height)) else {
            print ("Failed to create top gradient")
            return nil
        }
        
        guard let bottomGradient = greenGradientImageInRect(rect, point0: CIVector(x: 0, y: 0.25 * height), point1: CIVector(x: 0, y: 0.5 * height)) else {
            print ("Failed to create bottom gradient")
            return nil
        }
        
        filter.setValue(topGradient, forKey: kCIInputImageKey)
        filter.setValue(bottomGradient, forKey: kCIInputBackgroundImageKey)

        guard let outputImage = filter.outputImage else {
            print("CIAdditionCompositing filter output error.")
            return nil
        }
        
        return outputImage
    }
}
