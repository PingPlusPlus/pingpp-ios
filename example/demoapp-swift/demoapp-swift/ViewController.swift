//
//  ViewController.swift
//  demoapp-swift
//
//  Created by Afon on 15/4/30.
//  Copyright (c) 2015年 Pingplusplus. All rights reserved.
//

import UIKit

let kBackendChargeURL = "http://218.244.151.190/demo/charge" // 你的服务端创建并返回 charge 的 URL 地址，此地址仅供测试用。
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

    override func viewDidAppear(animated: Bool) {

        let postDict : AnyObject = NSDictionary(objects: ["alipay", "10"], forKeys: ["channel", "amount"])
        var postData: NSData = NSData()
        do {
            try postData = NSJSONSerialization.dataWithJSONObject(postDict, options: NSJSONWritingOptions.PrettyPrinted)
        } catch {
            print("Serialization error")
        }
        
        let url = NSURL(string: kBackendChargeURL)
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = postData

        let sessionTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if data != nil {
                let charge = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print(charge! as String)
                Pingpp.createPayment(charge! as String, appURLScheme: kAppURLScheme) { (result, error) -> Void in
                    print(result)
                    if error != nil {
                        print(error.code.rawValue)
                        print(error.getMsg())
                    }
                }
            } else {
                print("response data is nil")
            }
        }
        sessionTask.resume()
    }
}

