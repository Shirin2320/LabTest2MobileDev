import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)]
    ) private var products: FetchedResults<Product>
    
    @State private var productName = ""
    @State private var productDescription = ""
    @State private var productPrice = ""
    @State private var productProvider = ""
    var body: some View {
            NavigationView {
                VStack {
                    // Add Product Form
                    Form {
                        TextField("Product Name", text: $productName)
                        TextField("Description", text: $productDescription)
                        TextField("Price", text: $productPrice)
                            .keyboardType(.decimalPad)
                        TextField("Provider", text: $productProvider)

                        Button("Add Product") {
                            addProduct()
                        }
                    }
