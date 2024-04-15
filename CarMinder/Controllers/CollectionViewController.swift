//
//  CollectionViewController.swift
//  CarMinder
//
//  Created by Tanveer Sran on 2024-04-12.
//  This file is used to show the collection view of images.
//


import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var imagePaths: [String] = []
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           imagePaths = mainDelegate.selectedImagePaths
           collectionView.dataSource = self
           collectionView.delegate = self
           
           // Register custom collection view cell
           collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
       }
       
       // MARK: - UICollectionViewDataSource
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return imagePaths.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
           
           if let image = UIImage(contentsOfFile: imagePaths[indexPath.item]) {
               cell.imageView.image = image
           }
                    
           return cell
       }
       
       // MARK: - UICollectionViewDelegateFlowLayout
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           // Set custom size for collection view cells
           return CGSize(width: 250, height: 250)
       }
    
    
   }


   class ImageCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate {
       var imageView: UIImageView!
       var scrollView: UIScrollView!
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           
           setupImageView()
           setupScrollView()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       private func setupImageView() {
           imageView = UIImageView(frame: contentView.bounds)
           imageView.contentMode = .scaleAspectFit
           contentView.addSubview(imageView)
       }
       
       private func setupScrollView() {
           scrollView = UIScrollView(frame: contentView.bounds)
           scrollView.delegate = self
           scrollView.minimumZoomScale = 1.0
           scrollView.maximumZoomScale = 3.0
           scrollView.showsHorizontalScrollIndicator = false
           scrollView.showsVerticalScrollIndicator = false
           scrollView.addSubview(imageView)
           contentView.addSubview(scrollView)
       }
       
       func viewForZooming(in scrollView: UIScrollView) -> UIView? {
           return imageView
       }

}
