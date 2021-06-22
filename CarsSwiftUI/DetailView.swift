//
//  DetailView.swift
//  CarsSwiftUI
//
//  Created by Дмитрий Геращенко on 15.06.2021.
//

import SwiftUI
import CoreData

struct DetailView: View {
  
  @Environment(\.managedObjectContext) var moc
  @Environment(\.presentationMode) var presentationMode
  
  let car: Car
    var body: some View {
      VStack {
        Section {
          Text(car.manufacturer ?? "Unknown manufacturer")
          Text(car.model ?? "Unknown model")
        }
      }
    }
}

struct DetailView_Previews: PreviewProvider {
  static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
  
    static var previews: some View {
      
      let car = Car(context: moc)
      
      car.manufacturer = "Toyota"
      car.model = "Corolla"
      car.year = 1988
      car.carDescription = "Some information about car."
      
      return NavigationView {
        DetailView(car: car)
      }
    }
}
