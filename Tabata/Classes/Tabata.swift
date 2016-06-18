import Cocoa

public class Tabata {
    private var image: NSImage
    
    private var operations = [ImageProcessOperation]()
    
    public init(image: NSImage) {
        self.image = image
    }
    
    public func brightness(brightness: Float?, saturation: Float?, andContrast contrast: Float?) -> Tabata {
        if let operation = ColorControlsOperation(brightness: brightness, saturation: saturation, contrast: contrast) {
            operations.append(operation)
        }
        return self
    }
    
    public func hue(hue: Float?) -> Tabata {
        if let hue = hue, operation = HueOperation(hue: hue) {
            operations.append(operation)
        }
        return self
    }
    
    public func gaussianBlur(radius: Float?) -> Tabata {
        if let radius = radius {
            operations.append(GaussianBlurOperation(radius: radius))
        }
        return self
    }
    
    public func tiltShift(radius: Float?) -> Tabata {
        if let radius = radius {
            operations.append(TiltShiftOperation(radius: radius))
        }
        return self
    }
    
    public var output: NSImage {
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
        
        let rep = NSCIImageRep(CIImage: intermediate)
        let nsImage = NSImage(size: rep.size)
        nsImage.addRepresentation(rep)
        return nsImage
    }
    
    private var CIImageObject: CIImage? {
        if let tiffRep = image.TIFFRepresentation, bitmapImageRep = NSBitmapImageRep(data: tiffRep) {
            return CIImage(bitmapImageRep: bitmapImageRep)
        }
        return nil
    }
}
