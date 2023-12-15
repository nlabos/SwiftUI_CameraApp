import SwiftUI
import UIKit

struct ContentView: View {
    @State private var isImagePickerPresented: Bool = false
    @State private var selectedImage: UIImage?
    @State private var isEffectViewPresented: Bool = false
    @State private var selectedEffectIndex: Int = 0
    private let effects = ["None", "CIPhotoEffectMono", "CIPhotoEffectInstant", "CIPhotoEffectProcess", "CIPhotoEffectTransfer", "CISepiaTone", "CIVignette"]
    
    //アラートを表示させるかさせないかの状態を定義する
    @State private var showAlart = false
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = selectedImage {
                    Image(uiImage: applyEffect(to: image, effectName: effects[selectedEffectIndex]) ?? image)
                        .resizable()
                        //.frame(width: 400, height: 400)
                        .padding()
                    
                    Picker("エフェクト", selection: $selectedEffectIndex) {
                        ForEach(0..<effects.count, id: \.self) {
                            Text(self.effects[$0])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                } else {
                    Text("画像がありません")
                        .padding()
                }
                
                
                Button("写真を選択する") {
                    isImagePickerPresented.toggle()
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
                }
                Button("写真を撮影する") {
                    isImagePickerPresented.toggle()
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $selectedImage, sourceType: .camera)
                }
            }
            .padding()
            .navigationTitle("CameraApp")
            .navigationBarItems(trailing: Button(action: {
                isEffectViewPresented.toggle()
            }) {
                Image(systemName: "wand.and.stars")
            }
                .sheet(isPresented: $isEffectViewPresented) {
                    EffectView(selectedImage: $selectedImage)
                })
            .navigationBarItems(trailing: Button(action: {
                if let image = selectedImage{
                    UIImageWriteToSavedPhotosAlbum(applyEffect(to: image, effectName: effects[selectedEffectIndex]) ?? image, nil, nil, nil)
                }
            })
            {
                Image(systemName: "square.and.arrow.down")
            }
//                .alert(isPresented: $showAlart, content: {
//                        Alert(title: Text("保存"))
//                    })
            )
           
        }
        
        
    }
    
    
    
    private func applyEffect(to image: UIImage, effectName: String) -> UIImage? {
        guard effectName != "None" else { return image }
        
        let context = CIContext()
        guard let filter = CIFilter(name: effectName) else { return nil }
        filter.setDefaults()
        
        let inputImage = CIImage(image: image)
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        
        if let outputImage = filter.outputImage, let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
        }
        return nil
    }
}
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    var sourceType: UIImagePickerController.SourceType
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var selectedImage: UIImage?
        
        init(selectedImage: Binding<UIImage?>) {
            _selectedImage = selectedImage
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                selectedImage = uiImage
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedImage: $selectedImage)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

// ContentViewのプレビュー
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
