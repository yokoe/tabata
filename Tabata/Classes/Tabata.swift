import Cocoa

open class Tabata {
    fileprivate var image: NSImage
    
    fileprivate var operations = [ImageProcessOperation]()
    
    public init(image: NSImage) {
        self.image = image
    }
    
    open func brightness(_ brightness: Float?, saturation: Float?, andContrast contrast: Float?) -> Tabata {
        if let operation = ColorControlsOperation(brightness: brightness, saturation: saturation, contrast: contrast) {
            operations.append(operation)
        }
        return self
    }
    
    open func exposure(_ ev: Float?) -> Tabata {
        if let ev = ev {
            operations.append(ExposureOperation(ev: ev))
        }
        return self
    }
    
    open func hue(_ hue: Float?) -> Tabata {
        if let hue = hue, let operation = HueOperation(hue: hue) {
            operations.append(operation)
        }
        return self
    }
    
    open func gaussianBlur(_ radius: Float?) -> Tabata {
        if let radius = radius {
            operations.append(GaussianBlurOperation(radius: radius))
        }
        return self
    }
    
    open func tiltShift(_ radius: Float?) -> Tabata {
        if let radius = radius {
            operations.append(TiltShiftOperation(radius: radius))
        }
        return self
    }
    
    open var output: NSImage {
        if operations.count == 0 {
            return image
        }
        
        guard let ciimage = CIImageObject else {
            print("Failed to create CIImage from image. ", image)
            return image
        }
        
        var intermediate = ciimage
        for operation in operations {
            intermediate = operation.process(intermediate)
        }
        
        let rep = NSCIImageRep(ciImage: intermediate)
        let nsImage = NSImage(size: rep.size)
        nsImage.addRepresentation(rep)
        return nsImage
    }
    
    fileprivate var CIImageObject: CIImage? {
        if let tiffRep = image.tiffRepresentation, let bitmapImageRep = NSBitmapImageRep(data: tiffRep) {
            return CIImage(bitmapImageRep: bitmapImageRep)
        }
        return nil
    }
}
