//
//  SelectProjectImageWorker.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 16/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Photos
import UIKit

protocol SelectProjectImageWorkerProtocol {
    func fetchAlbumImages(_ request: SelectProjectImage.Request.AlbumImages,
                          completion: @escaping (SelectProjectImage.Info.Response.Images) -> Void)
}

class SelectProjectImageWorker: SelectProjectImageWorkerProtocol {
    
    private let builder: FirebaseAuthHelperProtocol
    
    init(builder: FirebaseAuthHelperProtocol = FirebaseAuthHelper()) {
        self.builder = builder
    }
    
    func fetchAlbumImages(_ request: SelectProjectImage.Request.AlbumImages,
                          completion: @escaping (SelectProjectImage.Info.Response.Images) -> Void) {
        var images = [UIImage]()
        let manager = PHImageManager.default()
               let requestOptions = PHImageRequestOptions()
               requestOptions.isSynchronous = false
               requestOptions.deliveryMode = .fastFormat
               // .highQualityFormat will return better quality photos
               let fetchOptions = PHFetchOptions()
               fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

               let results: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
               if results.count > 0 {
                   for i in 0..<results.count {
                       let asset = results.object(at: i)
                       let size = CGSize(width: 700, height: 700)
                       manager.requestImage(for: asset, targetSize: size,
                                            contentMode: .aspectFill,
                                            options: requestOptions) { (image, _) in
                           if let image = image {
                               images.append(image)
                               completion(SelectProjectImage.Info.Response.Images(images: images))
                           } else {
                               print("error asset to image")
                           }
                       }
                   }
               } else {
                   print("no photos to display")
               }
    }
}
