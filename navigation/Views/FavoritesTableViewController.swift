
import UIKit
import CoreData

class FavoritesTableViewController: UITableViewController {
    
    var fetchedResultController: NSFetchedResultsController<PostCD>!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        initFetchedResultController()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "cell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Фильтр", style: .plain, target: self, action: #selector(addFilter))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Показать все", style: .done, target: self, action: #selector(clearFilter))
    }
    
    private func initFetchedResultController() {
        let fetchRequest = PostCD.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "likes", ascending: false)]
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                             managedObjectContext: CoreDataManager.manager.context,
                                                             sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        
        do{
            try fetchedResultController.performFetch()
        } catch{
            print(error)
        }
    }
    
    
    @objc private func addFilter() {
        let alert = UIAlertController(title: "Фильтр", message: "Введите имя автора", preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.placeholder = "имя автора"
            textField.text = "Dog"
        }
        
        let done = UIAlertAction(title: "Применить", style: .default) {_ in
            guard let text = alert.textFields?[0].text else {return}
            self.fetchedResultController.fetchRequest.predicate = NSPredicate(format: "author contains[c] %@", text)
            do{
                try self.fetchedResultController.performFetch()
            }catch{
                print(error)
            }
            
            self.tableView.reloadData()
            alert.dismiss(animated: true)
        }
        alert.addAction(done)
        present(alert, animated: true)
    }
    
    @objc private func clearFilter() {
        fetchedResultController.fetchRequest.predicate = nil
        do{
            try fetchedResultController.performFetch()
        }catch{
            print(error)
        }
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do{
            try fetchedResultController.performFetch()
        }catch{
            print(error)
        }
        
        tableView.reloadData()
    }
    

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if let sections = fetchedResultController.sections {
            return sections.count
        }else{
            return 1
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = fetchedResultController.fetchedObjects?.count else {return 0}
        return count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell") as! PostTableViewCell
        let post = fetchedResultController.object(at: indexPath)
        cell.setupCell(post)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "delete") {action, view, completion in
            let post = self.fetchedResultController.object(at: indexPath)
            CoreDataManager.manager.deleteFromFavorites(post: post)
            
            tableView.reloadData()
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


//MARK: Fetched Result controller delegate

extension FavoritesTableViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type{
        case .insert:
            tableView.insertRows(at: [indexPath!], with: .automatic)
        case .update:
            tableView.reloadData()
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        @unknown default:
            tableView.reloadData()
        }
    }
    
    
}
