//
//  ViewController.swift
//  demoapp-swift
//
//  Created by Afon on 15/4/30.
//  Copyright (c) 2015年 Pingplusplus. All rights reserved.
//

import UIKit

let kBackendChargeURL = "Your-Backend-Charge-URL"
let kAppURLScheme = "demoappswift"

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

        var postDict : AnyObject = NSDictionary(objectsAndKeys: "alipay", "channel", "10", "amount")
        let postData = NSJSONSerialization.dataWithJSONObject(postDict, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
        
        let url = NSURL(string: kBackendChargeURL)
        let session = NSURLSession.sharedSession();
        var request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = postData

        let sessionTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if data != nil {
                let charge = NSString(data: data, encoding: NSUTF8StringEncoding)
                println(charge! as String)
                Pingpp.createPayment(charge! as String, appURLScheme: kAppURLScheme) { (result, error) -> Void in
                    println(result)
                    if error != nil {
                        println(error.code.rawValue)
                        println(error.getMsg())
                    }
                }
            } else {
                println("response data is nil")
            }
        }
        sessionTask.resume()
    }
}

