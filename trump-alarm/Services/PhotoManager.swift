//
//  PhotoManager.swift
//  trump-alarm
//
//  Created by Julietta Yaunches on 10/26/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit

class PhotoManager: NSObject {
    
    let defaults = UserDefaults.standard
    
    public let applicationDocumentsDirectory: URL? = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        //let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls.last! as URL
    }()
    
    lazy var picURL: URL? = {
        if let appDocDir = self.applicationDocumentsDirectory {
            return appDocDir.appendingPathComponent("pic-voting.png")
        }
        return nil
    }()
    
    func getImage() -> UIImage? {
        var result: UIImage?
        if let picURL = picURL
            {
            
                if let picData = try? Data(contentsOf: picURL) {
                
            if let foo = UIImage(data: picData)?.cgImage {
                let orientation = defaults.integer(forKey: "voting-photo-orientation")
                    result = UIImage(cgImage: foo, scale: 1.0, orientation: UIImageOrientation(rawValue: orientation) ?? .up)
                }
            }
        }
        return result
    }
    
    func writeImage(image: UIImage) {
        defaults.set(image.imageOrientation.rawValue, forKey: "voting-photo-orientation")
        
        if let imagePNG = UIImagePNGRepresentation(image),
            let picURL = picURL {
            
            let imageData = NSData(data:imagePNG)
            imageData.write(to: picURL, atomically: true)
            
        }
    }


    
}
