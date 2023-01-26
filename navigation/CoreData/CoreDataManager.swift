
import Foundation
import CoreData
import StorageService


class CoreDataManager {
    
    static let manager = CoreDataManager()
    private var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    
    private var context: NSManagedObjectContext {container.viewContext}
    
    
    
    
    func addFavorites(post: Post) {
        var postCD = PostCD(context: context)
        postCD.author = post.author
        postCD.descriptionPost = post.description
        postCD.image = post.image
        postCD.likes = Int64(post.likes)
        postCD.viewsCount = Int64(post.views)
        
        saveContext()
    }
    
    func makeFavoritesPosts() -> [PostCD]? {
        let fetchRequest = PostCD.fetchRequest()
        let postCDS = try? context.fetch(fetchRequest)
        return postCDS
    }
    
    private func saveContext () {
          if context.hasChanges {
              do {
                  try context.save()
              } catch {
                context.rollback()
                  let nserror = error as NSError
                  fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
              }
          }
      }

}

