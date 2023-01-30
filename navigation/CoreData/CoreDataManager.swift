
import UIKit
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
    //private var backgroundContext: NSManagedObjectContext {container.newBackgroundContext()}
    
    
    
    
    
    
    func addFavorites(post: Post) {
        container.performBackgroundTask { backgroundContext in
            let fetchRequest = PostCD.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "descriptionPost == %@", post.description)
            let posts = try! backgroundContext.fetch(fetchRequest)
            if posts.count == 0 {
                add(post: post)
            }
            
            func add(post: Post) {
                let postCD = PostCD(context: backgroundContext)
                postCD.author = post.author
                postCD.descriptionPost = post.description
                postCD.image = post.image
                postCD.likes = Int64(post.likes)
                postCD.viewsCount = Int64(post.views)
                
                try? backgroundContext.save()
            }

        }
        }
    
    func makeFavoritesPosts(filter: String = "") -> [PostCD]? {

        let fetchRequest = PostCD.fetchRequest()
        if filter.isEmpty != true {
            fetchRequest.predicate = NSPredicate(format: "author == %@", filter)
        }
        
        let postCDS = try? container.viewContext.fetch(fetchRequest)
        return postCDS
    }
    
    func deleteFromFavorites(post: PostCD) {
        context.delete(post)
        try! context.save()
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
    
     func deleteAll() {
        do {
            try context.execute(NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "PostCD")))
            
        } catch {
        }
        try? context.save()
        
    }
    
}


