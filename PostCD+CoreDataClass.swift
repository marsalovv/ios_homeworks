
import Foundation
import CoreData

@objc(PostCD)
public class PostCD: NSManagedObject {

}


extension PostCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostCD> {
        return NSFetchRequest<PostCD>(entityName: "PostCD")
    }

    @NSManaged public var author: String?
    @NSManaged public var descriptionPost: String?
    @NSManaged public var image: String?
    @NSManaged public var likes: Int64
    @NSManaged public var views: Int64?

}
