//
//  ImageHelper.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/3/13.
//

import Foundation
import UIKit

struct ImageHelper{
    func deCode(base64String:String?) -> UIImage?{
        guard let imageString = base64String else{
            return nil
        }
        
        guard let imageData = Data(base64Encoded: imageString) else{
            return nil
        }
        
        guard let image = UIImage(data: imageData)else{
            return nil
        }
        return image
    }
    
    func encode(image:UIImage?) -> String?{
        if let imageData = image?.jpegData(compressionQuality: 0.8){
            return imageData.base64EncodedString()
        }
        return nil
    }
}
