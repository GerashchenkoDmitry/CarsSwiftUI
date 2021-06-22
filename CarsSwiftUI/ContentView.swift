//
//  ContentView.swift
//  CarsSwiftUI
//
//  Created by Дмитрий Геращенко on 13.06.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) private var moc
  
  @FetchRequest(entity: Car.entity(),
    sortDescriptors: [NSSortDescriptor(keyPath: \Car.manufacturer, ascending: true)],
    animation: .default)
  private var cars: FetchedResults<Car>
  
  @State private var showingAddCarView = false
  
  var body: some View {
    NavigationView {
      List {
        ForEach(cars, id: \.id) { car in
          NavigationLink(destination: DetailView(car: car)) {
            HStack {
              Image(systemName: "car")
                .font(.system(size: 60))
//                .frame(maxWidth: 160, maxHeight: 90)

              VStack(alignment: .leading) {
                Text("\(car.manufacturer ?? "Unknown manufaturer")")
                  .font(.headline)
                Text("\(car.model ?? "Unknown model")")
                  .foregroundColor(.secondary)
              }
            }
          }
        }
        .onDelete(perform: deleteCars)
      }
      
      .listStyle(PlainListStyle())
      .navigationTitle("Cars")
      .navigationBarItems(leading: EditButton(),
                          trailing: Button(action: { showingAddCarView.toggle() }) {
                            Image(systemName: "plus")
                          }
                          .font(.title)
      )
      .sheet(isPresented: $showingAddCarView) {
        AddCar().environment(\.managedObjectContext, self.moc)
      }
    }
  }
  
  private func deleteCars(offsets: IndexSet) {
    withAnimation {
      offsets.map { cars[$0] }.forEach(moc.delete)
      
      do {
        try moc.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
