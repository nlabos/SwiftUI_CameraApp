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
            HStack{
                Spacer()
                if let image = processedImage {
                    Image(uiImage: applyEffect(to: image, effectname: "CIPhotoEffectMono") ?? processedImage!)
                                .resizable()
                                .frame(width: 200, height: 200)
                                .padding()
                                .onTapGesture {
                                    // Apply effect to selected image
                                    processedImage = applyEffect(to: selectedImage, effectname: "CIPhotoEffectMono")
                                }
                        } else if let originalImage = selectedImage {
                            Image(uiImage: originalImage)
                                .resizable()
                                .frame(width: 300, height: 200)
                                .padding()
                                .onTapGesture {
                                    // Apply effect to selected image
                                    processedImage = applyEffect(to: selectedImage, effectname: "CIPhotoEffectMono")
                                }
                        } else {
                            Text("表示する画像を選択してください")
                        }
                
                if let image = processedImage {
                            Image(uiImage: applyEffect(to: image, effectname: "CIPhotoEffectInstant") ?? processedImage!)
                                .resizable()
                                .frame(width: 200, height: 200)
                                .padding()
                                .onTapGesture {
                                    // Apply effect to selected image
                                    processedImage = applyEffect(to: selectedImage, effectname: "CIPhotoEffectInstant")
                                }
                        } else if let originalImage = selectedImage {
                            Image(uiImage: originalImage)
                                .resizable()
                                .frame(width: 200, height: 200)
                                .padding()
                                .onTapGesture {
                                    // Apply effect to selected image
                                    processedImage = applyEffect(to: selectedImage, effectname: "CIPhotoEffectInstant")
                                }
                        } else {
                            Text("表示する画像を選択してください")
                        }
                Spacer()
                    }
            HStack{
                Spacer()
                if let image = processedImage {
                            Image(uiImage: applyEffect(to: image, effectname: "CIPhotoEffectProcess") ?? processedImage!)
                                .resizable()
                                .frame(width: 200, height: 200)
                                .padding()
                                .onTapGesture {
                                    // Apply effect to selected image
                                    processedImage = applyEffect(to: selectedImage, effectname: "CIPhotoEffectProcess")
                                }
                        } else if let originalImage = selectedImage {
                            Image(uiImage: originalImage)
                                .resizable()
                                .frame(width: 200, height: 200)
                                .padding()
                                .onTapGesture {
                                    // Apply effect to selected image
                                    processedImage = applyEffect(to: selectedImage, effectname: "CIPhotoEffectProcess")
                                }
                        } else {
                            Text("表示する画像を選択してください")
                        }
                        
                if let image = processedImage {
                            Image(uiImage: applyEffect(to: image, effectname: "CIPhotoEffectTransfer") ?? processedImage!)
                                .resizable()
                                .frame(width: 200, height: 200)
                                .padding()
                                .onTapGesture {
                                    // Apply effect to selected image
                                    processedImage = applyEffect(to: selectedImage,effectname: "CIPhotoEffectTransfer")
                                }
                        } else if let originalImage = selectedImage {
                            Image(uiImage: originalImage)
                                .resizable()
                                .frame(width: 200, height: 200)
                                .padding()
                                .onTapGesture {
                                    // Apply effect to selected image
                                    processedImage = applyEffect(to: selectedImage,effectname: "CIPhotoEffectTransfer")
                                }
                        } else {
                            Text("表示する画像を選択してください")
                        }
                Spacer()
                    }
            HStack{
                Spacer()
                if let image = processedImage {
                            Image(uiImage: applyEffect(to: image, effectname: "CISepiaTone") ?? processedImage!)
                                .resizable()
                                .frame(width: 200, height: 200)
                                .padding()
                                .onTapGesture {
                                    // Apply effect to selected image
                                    processedImage = applyEffect(to: selectedImage,effectname: "CISepiaTone")
                                }
                        } else if let originalImage = selectedImage {
                            Image(uiImage: originalImage)
                                .resizable()
                                .frame(width: 200, height: 200)
                                .padding()
                                .onTapGesture {
                                    // Apply effect to selected image
                                    processedImage = applyEffect(to: selectedImage,effectname: "CISepiaTone")
                                }
                        } else {
                            Text("表示する画像を選択してください")
                        }
                        
                if let image = processedImage {
                            Image(uiImage: applyEffect(to: image, effectname: "CIVignette") ?? processedImage!)
                                .resizable()
                                .frame(width: 200, height: 200)
                                .padding()
                                .onTapGesture {
                                    // Apply effect to selected image
                                    processedImage = applyEffect(to: selectedImage,effectname: "CIVignette")
                                }
                        } else if let originalImage = selectedImage {
                            Image(uiImage: originalImage)
                                .resizable()
                                .frame(width: 200, height: 200)
                                .padding()
                                .onTapGesture {
                                    // Apply effect to selected image
                                    processedImage = applyEffect(to: selectedImage,effectname: "CIVignette")
                                }
                        } else {
                            Text("表示する画像を選択してください")
                        }
                    }
            .padding()
            .navigationTitle("エフェクトを選択")
                }
                
    }

    private func applyEffect(to image: UIImage?, effectname: String) -> UIImage? {
        //エフェクト前の画像ををアンラップして取り出す
        if let image = selectedImage {
            //フィルター名を指定する
            //let filterName = effectname
            //元々の画像の回転角度を取得
            let rotate = image.imageOrientation
            //UIImage型の画像をCIImage型に変換
            guard let inputImage = CIImage(image: image) else {
                        return image
                    }
            //フィルターに種類を引数で指定されたものに指定してCIFilterインスタンスを取得
            guard let effectFilter = CIFilter(name: effectname) else {
                return image
            }
            //エフェクトのパラメータを初期化
            effectFilter.setDefaults()
            //インスタンスにエフェクトする元画像を指定
            effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
            //エフェクトを適用したCGImage型の画像を取得
            guard let outputImage = effectFilter.outputImage else {
                return image
            }
            //CIContextのインスタンスを取得
            let ciContext = CIContext(options: nil)
            //エフェクト後の画像をCIContext上に描画し、結果をCGImage型で取得
            guard let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else{
                return image
            }
            
            let filteredImage = UIImage(cgImage: cgImage, scale: image.scale, orientation: rotate)
            return filteredImage
        }
        return image
    }
}

