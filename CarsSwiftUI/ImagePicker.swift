//
//  ImagePicker.swift
//  CarsSwiftUI
//
//  Created by Дмитрий Геращенко on 16.06.2021.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
  
  @Environment(\.presentationMode) var presentationMode
  @Binding var image: UIImage?
    
  typealias UIViewControllerType = UIImagePickerController
  
  class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let parent: ImagePicker
    
    init(_ parent: ImagePicker) {
      self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let uiImage = info[.originalImage] as? UIImage {
        parent.image = uiImage
      }
      parent.presentationMode.wrappedValue.dismiss()
    }
    
    
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    
  }
}
