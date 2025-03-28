import CoreData

struct PersistenceController {
    static let shared = PersistenceController()  // Shared instance for easy access

    let container: NSPersistentContainer

    // Initialize the Core Data stack
    init() {
        container = NSPersistentContainer(name: "A2_iOS_Shirin_101385244") // Replace with your project name
        container.loadPersistentStores { description, error in
            // Handle any errors that occur while loading the persistent store
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)") // Fatal error if something goes wrong
            }
        }
    }

    // Convenience method to save context (used for saving data)
    func saveContext () {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()  // Try saving the context
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")  // Fatal error if saving fails
            }
        }
    }
}
