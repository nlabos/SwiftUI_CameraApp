//
//  EffectView.swift
//  swiftui_cameraapp_complete
//
//  Created by 篠原優仁 on 2023/11/25.
//

import SwiftUI

struct EffectView: View {
    @Binding var selectedImage: UIImage?
    @Binding var processedImage: UIImage?

    var body: some View {
        VStack {
            if let image = processedImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 400, height: 400)
                    .padding()
            } else if let originalImage = selectedImage {
                Image(uiImage: originalImage)
                    .resizable()
                    .frame(width: 400, height: 400)
                    .padding()
            } else {
                Text("No Images")
            }

            Button("Apply Effect") {
                processedImage = applyEffect(to: selectedImage)
            }
            .padding()
            
        }
        .padding()
        .navigationTitle("Effect")
    }

    private func applyEffect(to image: UIImage?) -> UIImage? {
        // ここに画像の加工処理を実装（例: グレースケールに変換）
        guard let originalImage = image else {
            return nil
        }

        let context = CIContext()
        let ciImage = CIImage(image: originalImage)
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(0.0, forKey: kCIInputSaturationKey)

        if let outputImage = filter?.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        } else {
            return nil
        }
    }
}
