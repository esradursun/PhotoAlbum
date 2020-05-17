//
//  PhotoDetailViewController.swift
//  PhotoAlbum
//
//  Created by Esra Dursun on 18/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var photoDetailScrollView: UIScrollView!
    @IBOutlet weak var photoDetailImageView: UIImageView!
    @IBOutlet weak var photoDetailTitleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    var gestureRecognizer: UITapGestureRecognizer!
    
    var selectedPhotoDetail : PhotoModel? {
        didSet{
            loadPhotoDetails()
        }
    }
    
    class func fromStoryboard(photo: PhotoModel) -> PhotoDetailViewController? {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: Constants.photoDetailViewController) as! PhotoDetailViewController;
        vc.selectedPhotoDetail = photo;
        return vc;
    }
    
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoDetailScrollView.delegate = self
        photoDetailScrollView.alwaysBounceVertical = false
        photoDetailScrollView.alwaysBounceHorizontal = false
        photoDetailScrollView.showsVerticalScrollIndicator = false
        photoDetailScrollView.flashScrollIndicators()
        
        photoDetailScrollView.minimumZoomScale = 1.0
        photoDetailScrollView.maximumZoomScale = 5.0
        photoDetailScrollView!.layer.cornerRadius = 6.0
        photoDetailScrollView!.clipsToBounds = false
        
        self.photoDetailTitleLabel.text = selectedPhotoDetail?.title
        setupGestureRecognizer()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoDetailImageView
    }
    
    func setupGestureRecognizer() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        gestureRecognizer.numberOfTapsRequired = 2
        photoDetailScrollView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleDoubleTap() {
        if photoDetailScrollView.zoomScale == 1 {
            photoDetailScrollView.zoom(to: zoomRectForScale(photoDetailScrollView.maximumZoomScale, center: gestureRecognizer.location(in: gestureRecognizer.view)), animated: true)
        } else {
            photoDetailScrollView.setZoomScale(1, animated: true)
        }
    }
    
    func zoomRectForScale(_ scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = photoDetailImageView.frame.size.height / scale
        zoomRect.size.width = photoDetailImageView.frame.size.width / scale
        let newCenter = photoDetailScrollView.convert(center, from: photoDetailImageView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    func loadPhotoDetails() {
        let url = URL(string: selectedPhotoDetail!.url)
        let data = try? Data(contentsOf: url!)
        DispatchQueue.main.async {
            self.photoDetailImageView.image = UIImage(data: data!)
        }
        
    }
    
    @IBAction func pressedCloseButton(_ sender: UIButton) {
        closeButton.setTitleColor(UIColor.lightGray, for: .highlighted);
        self.dismiss(animated: true, completion: nil);
    }
    
}
