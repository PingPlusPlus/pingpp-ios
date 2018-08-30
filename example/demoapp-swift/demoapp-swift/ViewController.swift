//
//  ViewController.swift
//  demoapp-swift
//
//  Created by Afon on 15/4/30.
//  Copyright (c) 2015年 Pingplusplus. All rights reserved.
//

import UIKit

let kBackendChargeURL = "http://218.244.151.190/demo/charge" // 你的服务端创建并返回 charge 的 URL 地址，此地址仅供测试用。如果该地址失效，请使用你自己的后端接口。
// 以下参数的相关说明请查看 Objective-C 相关文件
let kAppURLScheme = "demoappswift" // 这个是你定义的 URL Scheme，支付宝、微信支付和测试模式需要。

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {

        let postDict : AnyObject = NSDictionary(objects: ["alipay", "10"], forKeys: ["channel" as NSCopying, "amount" as NSCopying])
        var postData: NSData = NSData()
        do {
            try postData = JSONSerialization.data(withJSONObject: postDict, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
        } catch {
            print("Serialization error")
        }
        
        let url = NSURL(string: kBackendChargeURL)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData as Data

        let sessionTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if data != nil {
                let charge = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print(charge! as String)
                
                    Pingpp.createPayment(charge! as String as String as NSObject!, appURLScheme: kAppURLScheme) { (result, error) -> Void in
                        print(result)
                        if error != nil {
                            print(error?.code.rawValue)
                            print(error?.getMsg())
                        }
                    }
                
            } else {
                print("response data is nil")
            }
        }
        sessionTask.resume()
    }
}

