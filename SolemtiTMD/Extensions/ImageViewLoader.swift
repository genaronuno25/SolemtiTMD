//
//  ImageViewLoader.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//
import UIKit

extension UIImageView{
    
    func setImageFromURL(toPath path:String , toType type: TypeImage , completion: @escaping (Bool) -> Void)  {
        guard let imageURL = URL(string: Constants.movieImageHost(type: type)+path) else { return }
        setImage(imageURL) { (complete) in
            completion(complete)
        }
    }
    
    
    fileprivate func setImage(_ url: URL, completion: @escaping (Bool) -> Void){
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            print(response as Any)
            guard let data = data, error == nil,
                let image = UIImage(data: data) else { return }
            completion(true)
            DispatchQueue.main.async() {
                self.image = image
            }
        }
        dataTask.resume()
    }
}
