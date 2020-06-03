//
//  ViewController.swift
//  AlamofireDemo
//
//  Created by mac on 2020/6/3.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    var urlStringGet = "https://httpbin.org/get"
    var urlStringPost = "https://httpbin.org/post"
    var urlStringupload = "https://httpbin.org/post"
    var urlStringDownload = "https://httpbin.org/image/png"
    
    var imageView:UIImageView!
    
    
    let url = "http://onapp.yahibo.top/public/?s=api/test/list"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView()
        imageView.image = UIImage(named: "landscape_1")
        imageView.frame = CGRect(x: 0, y: 50, width: 100, height: 100)
        self.view.addSubview(imageView)
        
//        getHandler()
//
//        postHandler()
        
//        downloadHandler(fileName: "pig.jpg")
        
//        uploadHandler()
        
        responseMethod()
        // Do any additional setup after loading the view.
    }
    
    func responseMethod() {
        //responseData和responseJSON 增加返回方式的示例  https://www.jianshu.com/p/068eeb72439a
        
        let url2 = self.urlStringGet
        Alamofire.request(url2).responseData(completionHandler: { response in
            guard let value = response.result.value else { return }
            let result = try? JSONSerialization.jsonObject(with: value, options: [])
            guard let res = result else { return }
            let dictionary = res as! [String: Any]
            print("dictionary = ", dictionary)
            //输出：dictionary =  ["origin": 101.81.57.239]

        })
        
        Alamofire.request(url2).responseJSON { response in
            guard let value = response.result.value else { return }
            let dictionary = value as! [String: Any]
            print("dictionary = ", dictionary)
            //输出：dictionary
        }
        
    }
    
    //GET方式
    func getHandler() {
        //https://blog.csdn.net/lpCrazyBoy/article/details/88533287
        DispatchQueue.main.async(execute: {() in
            Alamofire.request(self.urlStringGet).responseJSON{response in
                response.error
                if let json = response.result.value {
                    print("JSON\(json)");
                }
            }
        })
        
    }
    
    //POST方式
    func postHandler() {
        var parameters: Parameters;
        parameters = ["foo":"bar", "baz":["a", 1], "qux":["x":1, "y":2, "z":3]];
        DispatchQueue.main.async(execute: {() in
            Alamofire.request(self.urlStringPost, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                if let json = response.result.value {
                    print("JSON\(json)");
                    
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        print("Data: \(utf8Text)")
                    }
                }
            }
            
        })
    }
    
    //文件下载
    func downloadHandler(fileName:String) {
        let destination: DownloadRequest.DownloadFileDestination = {_, _ in
            let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0];
            let fileURL = documentURL.appendingPathComponent(fileName);
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories]);
        }
        DispatchQueue.main.async(execute: {() in
            Alamofire.download(self.urlStringDownload, to: destination)
                .downloadProgress { progress in
                    print("下载进度：\(progress.fractionCompleted)");
                    print("已下载：\(progress.completedUnitCount)");
                    print("总大小：\(progress.totalUnitCount)")
            }
                .responseData {response in
                    if let data = response.result.value {
                        let image = UIImage(data: data);
                        self.imageView.image = image;
                    }
                    
            }
        })
    }
    

    //上传文件
     func uploadHandler() {
         let fileURL = Bundle.main.url(forResource: "landscape_1", withExtension: "png");
         DispatchQueue.main.async(execute: {() in
             Alamofire.upload(fileURL!, to: self.urlStringupload)
                 .uploadProgress { progress in
                     print("上传进度：\(progress.fractionCompleted)");
                     print("已上传：\(progress.completedUnitCount)");
                     print("总大小：\(progress.totalUnitCount)")
                 }
                 .responseJSON {response in
                 print(response.result);
             }
         })
     }
}

