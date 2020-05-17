//
//  PhotoListViewController.swift
//  PhotoAlbum
//
//  Created by Esra Dursun on 18/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import UIKit

class PhotoListViewController: UITableViewController {
    
    var photoService = PhotoListService()
    var photoList: [PhotoModel] = []
    var pageId = 1
    
    var selectedAlbum : AlbumModel? {
        didSet{
            loadAlbumPhotos()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: Constants.photoCell, bundle: nil), forCellReuseIdentifier: Constants.reusablePhotoCell)
        
    }
    
    func loadAlbumPhotos(){
        let albumId = selectedAlbum?.id
        
        photoService.fetchPhotoList(selectedAlbumId: albumId!, pageId: pageId) { photos in
            if let photos = photos {
                self.photoList = photos
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photoVM = self.photoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reusablePhotoCell, for: indexPath) as! PhotoCell
        
        let url = URL(string: photoVM.thumbnailUrl)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.photoImage.image = UIImage(data: data!)
            }
        }
        cell.photoLabel.text = "\(photoVM.title)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == (pageId * Constants.photoCountPerPage) - 1) {
            photoService.isMoreDataAvailable(listedPhotoCount: photoList.count,
                                             selectedAlbumId: selectedAlbum!.id,
                                             pageId: pageId + 1,
                                             completionHandler: { _ in
                                                self.pageId += 1
                                                
                                                self.photoService
                                                    .fetchPhotoList(selectedAlbumId: self.selectedAlbum!.id,
                                                                    pageId: self.pageId) { photos in
                                                                        if let photos = photos {
                                                                            self.photoList += photos
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
        if let vc = PhotoDetailViewController.fromStoryboard(photo: self.photoList[indexPath.row]) {
            self.present(vc, animated: true, completion: nil);
        }
    }
}


