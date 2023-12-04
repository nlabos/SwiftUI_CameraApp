import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct EffectView: View {
    @Binding var selectedImage: UIImage?
    
    var body: some View {
        
        
        VStack {
            Text("エフェクトサンプル")
                .font(.title)
                .fontWeight(.bold)
            if let selectedImage = selectedImage {
                HStack {
                    EffectImageView(image: selectedImage, effectName: "CIPhotoEffectMono")
                    EffectImageView(image: selectedImage, effectName: "CIPhotoEffectInstant")
                }
                HStack {
                    EffectImageView(image: selectedImage, effectName: "CIPhotoEffectProcess")
                    EffectImageView(image: selectedImage, effectName: "CIPhotoEffectTransfer")
                }
                HStack {
                    EffectImageView(image: selectedImage, effectName: "CISepiaTone")
                    EffectImageView(image: selectedImage, effectName: "CIVignette")
                }
            } else {
                Text("画像を選択してください")
            }
        }
        .navigationBarTitle("エフェクトサンプル", displayMode: .inline)
        
        
    }
}

struct EffectImageView: View {
    var image: UIImage
    var effectName: String
    
    var body: some View {
        VStack {
            Image(uiImage: applyEffect(to: image, effectName: effectName) ?? image)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            Text(effectName)
        }
    }
    
    
    private func applyEffect(to image: UIImage, effectName: String) -> UIImage? {
        let context = CIContext()
        guard let filter = CIFilter(name: effectName) else { return nil }
        filter.setDefaults()
        
        let inputImage = CIImage(image: image)
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        
        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
        }
        return nil
    }
}
