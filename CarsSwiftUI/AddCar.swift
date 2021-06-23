//
//  AddCar.swift
//  CarsSwiftUI
//
//  Created by Дмитрий Геращенко on 15.06.2021.
//

import SwiftUI

struct AddCar: View {
  
  @Environment(\.managedObjectContext) var moc
  @Environment(\.presentationMode) var presentationMode
  
  @State private var image: Image?
  @State private var showingImagePicker = false
  @State private var inputImage: UIImage?
  
  @State private var manufacturer = ""
  @State private var model = ""
  @State private var year = 1986
  @State private var carDescription = ""
  
  let yearFromDate: Int = {
    let date = Date()
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year], from: date)
    guard let year = components.year else { return 0 }
    return year
  } ()
  
  var body: some View {
    GeometryReader { geometry in
      NavigationView {
        VStack {
          ZStack {
            Rectangle()
              .fill(Color.secondary)
              .frame(maxWidth: geometry.size.width, maxHeight: 250)

              if image != nil {
                image?
                  .resizable()
                  .scaledToFit()
              } else {
                Text("Tap to select a picture")
                  .foregroundColor(.white)
                  .font(.headline)
            }
//            if image != nil {
           //              image!
           //                .resizable()
           //                .scaledToFit()
           //                .onTapGesture { self.showingImagePicker.toggle() }
           //            } else {
           //              Button(action: { self.showingImagePicker.toggle() }) {
           //                Text("Select Image", comment: "Select Image Button")
           //                  .accessibility(identifier: "Select Image")
           //              }
           //
           //
          }
          .onTapGesture {
            self.showingImagePicker.toggle()
          }
          
          Form {
            Section {
              TextField("Manufacturer", text: $manufacturer)
              TextField("Model", text: $model)
              
              Picker("Year", selection: $year) {
                ForEach(1886..<yearFromDate + 1, id: \.self) {
                  Text("\($0)")
                }
              }
              .pickerStyle(MenuPickerStyle())
            }
            
            Section {
              TextField("Car Description", text: $carDescription)
            }
            
            Section {
              Button("Add Car") {
                let pickedImage = inputImage?.jpegData(compressionQuality: 1.0)
                
                let newCar = Car(context: self.moc)
                
                newCar.id = UUID()
                newCar.carImage = pickedImage
                newCar.manufacturer = manufacturer
                newCar.model = model
                newCar.year = Int16(year)
                
//                try? self.moc.save()
                
                print(newCar.manufacturer ?? "Unknown manufacturer")
                print(newCar.model ?? "Unknown model")
                print(newCar.year)
                print("Image is saved")
                
                presentationMode.wrappedValue.dismiss()
              }
              
              .frame(maxWidth: .infinity, minHeight: 10, maxHeight: 30, alignment: .center)
              .padding(20)
              .foregroundColor(.white)
              .background(LinearGradient(gradient: Gradient(colors: [.gray, .blue, .green]), startPoint: .leading, endPoint: .trailing))
              .clipShape(Capsule())
              .padding()
            }
            
          }
        }
        .navigationTitle("New Car")
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
          ImagePicker(image: self.$inputImage)
        }
      }
    }
  }
  
  func loadImage() {
    guard let inputImage = inputImage else { return }
    image = Image(uiImage: inputImage)
  }
  
}


struct AddCar_Previews: PreviewProvider {
  static var previews: some View {
    AddCar()
  }
}
