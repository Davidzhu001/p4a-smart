//
//  ViewController.swift
//  p4a-smart
//
//  Created by Weicheng Zhu on 12/16/15.
//  Copyright © 2015 Weicheng Zhu. All rights reserved.
//

import Cocoa
import Realm
import Foundation
import RealmSwift
import WebKit

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate, WKScriptMessageHandler, WebPolicyDelegate, WebFrameLoadDelegate, WebUIDelegate  {
    
    
    //view outlet
    @IBOutlet weak var containerView: WebView!  = nil
    var webView: WKWebView?
    
    
    //realm Data configuration
    let realm = try! Realm()
    
    //realm data variables
    let textPrinterData = TextPrinterData()
    
    
    
    
    func someview( callbackName: String, fileName: String) {
        let contentController = WKUserContentController();
        let userScript = WKUserScript(
            source: "redHeader()",
            injectionTime: WKUserScriptInjectionTime.AtDocumentEnd,
            forMainFrameOnly: true
        )
        contentController.addUserScript(userScript)
        contentController.addScriptMessageHandler(
            self,
            name: callbackName
        )
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        self.webView = WKWebView(
            frame: self.containerView.bounds,
            configuration: config
        )
        self.view = self.webView!
        let try6 = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("index", ofType:"html")!)
        let fragUrl = NSURL(string: fileName, relativeToURL: try6)!
        let request = NSURLRequest(URL: fragUrl)
        self.webView?.loadRequest(request)
    }
    
    override func viewDidLoad()
    {
//        super.viewDidLoad()
//             print(realm.path)
        super.viewDidLoad();
        someview("indexCallback", fileName: "index.html")

    }
    
    

    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        if(message.name == "indexCallback") {
          let callbackMessageBody = message.body
            if( String(callbackMessageBody[0]) == "redirect" ){
                someview("indexCallback", fileName: String(callbackMessageBody[1]))
            } else {
                print("cannot redirect")
            }
        }else if(message.name == "callback")   {
            print("sds")
        
        } else {
            
            print("nothing")
        }
        
    
    }
    


}

