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
                // Display products
                List {
                    ForEach(products, id: \.self) { product in
                        VStack(alignment: .leading) {
                            Text(product.productName ?? "Unknown")
                                .font(.headline)
                            Text(product.productDescription ?? "No Description")
                                .font(.subheadline)
                        }
                    }
                    .onDelete(perform: deleteProducts)
                }
            }
            .navigationBarTitle("Products")
            .navigationBarItems(trailing: EditButton())
        }
    }
    private func addProduct() {
        let newProduct = Product(context: viewContext)
        newProduct.productName = productName
        newProduct.productDescription = productDescription
        newProduct.productPrice = Double(productPrice) ?? 0.0
        newProduct.productProvider = productProvider
        do {
            try viewContext.save()  // Save the new product
            clearForm()
        } catch {
            print("Error saving product: \(error.localizedDescription)")
        }
    }
    private func deleteProducts(offsets: IndexSet) {
        withAnimation {
            offsets.map { products[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()  // Save changes after deleting
            } catch {
                print("Error deleting product: \(error.localizedDescription)")
            }
        }
    }
    private func clearForm() {
        productName = ""
        productDescription = ""
        productPrice = ""
        productProvider = ""
    }
   }

#Preview {
    ContentView()
