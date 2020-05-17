//
//  ViewController.swift
//  PhotoAlbum
//
//  Created by Esra Dursun on 17/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import UIKit
import CoreData

class AlbumListViewController: UITableViewController {
    
    var albumList: [AlbumModel] = []
    var albumService = AlbumListService()
    var pageId = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        
        //This method is using for test purpose
        //deleteAllData()
        setup()
    }
    
    private func setup() {
        albumService.fetchAlbumList(pageId: pageId) { albums in
            if let albums = albums {
                self.albumList = albums
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let albumVM = self.albumList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.listOfAlbumCell, for: indexPath)
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.lineBreakMode = .byWordWrapping;
        cell.textLabel?.text = "\(albumVM.title)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == (pageId * Constants.albumCountPerPage) - 1) {
            albumService.isMoreDataAvailable(listedAlbumCount: albumList.count, pageId: pageId + 1, completionHandler: {_ in
                self.pageId += 1
                self.albumService.fetchAlbumList(pageId: self.pageId) { albums in
                    if let albums = albums {
                        self.albumList += albums
                    }
                }
            })
            self.perform(#selector(self.loadTable), with: nil, afterDelay: 0.30)
        }
    }
    
    @objc func loadTable(){
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.gotoPhotosSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PhotoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedAlbum = self.albumList[indexPath.row]
        }
    }
    
    //MARK: - these following methods are using for test purpose
    func saveCategories() {
        do {
            try CoreDataManager.sharedManager.managedObjectContext().save()
        } catch {
            print("Error saving category \(error)")
        }
    }
    
    func deleteAllData(){
        deleteAlbumData()
        deletePhotoData()
    }
    
    func deleteAlbumData()
    {
        let request : NSFetchRequest<Album> = Album.fetchRequest()
        request.returnsObjectsAsFaults = false
        
        do
        {
            let results = try CoreDataManager.sharedManager.managedObjectContext().fetch(request)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as NSManagedObject
                CoreDataManager.sharedManager.managedObjectContext().delete(managedObjectData)
                saveCategories()
            }
        } catch let error as NSError {
            print("Detele all data in error : \(error) \(error.userInfo)")
        }
    }
    
    func deletePhotoData()
    {
        let request : NSFetchRequest<Photo> = Photo.fetchRequest()
        request.returnsObjectsAsFaults = false
        
        do
        {
            let results = try CoreDataManager.sharedManager.managedObjectContext().fetch(request)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as NSManagedObject
                CoreDataManager.sharedManager.managedObjectContext().delete(managedObjectData)
                saveCategories()
            }
        } catch let error as NSError {
            print("Detele all data in error : \(error) \(error.userInfo)")
        }
    }
    
}


