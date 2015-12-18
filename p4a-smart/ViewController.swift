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
    
    
    override func loadView() {
        super.loadView()
        let contentController = WKUserContentController();
        let userScript = WKUserScript(
            source: "redHeader()",
            injectionTime: WKUserScriptInjectionTime.AtDocumentEnd,
            forMainFrameOnly: true
        )
        contentController.addUserScript(userScript)
        contentController.addScriptMessageHandler(
            self,
            name: "callbackHandler"
        )
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        self.webView = WKWebView(
            frame: self.containerView.bounds,
            configuration: config
        )
        self.view = self.webView!
    }
    
    override func viewDidLoad()
    {
//        super.viewDidLoad()
//             print(realm.path)
        super.viewDidLoad();
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "WebKitDeveloperExtras")
//        NSUserDefaults.standardUserDefaults().synchronize()
//        
//        containerView.policyDelegate = self;
//        containerView.frameLoadDelegate = self;
//        containerView.UIDelegate = self;
//        containerView.editingDelegate = self;
//         let try6 = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("index", ofType:"html")!)
        let try6 = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("index", ofType:"html")!)
        let fragUrl = NSURL(string: "printer.html", relativeToURL: try6)!
        let request = NSURLRequest(URL: fragUrl)
        self.webView?.loadRequest(request)
        

    }
    
    
//    
//    func laodingWeb(file: String) {
//        let contentController = WKUserContentController();
//        let userScript = WKUserScript(
//            source: "redHeader()",
//            injectionTime: WKUserScriptInjectionTime.AtDocumentEnd,
//            forMainFrameOnly: true
//        )
//        contentController.addUserScript(userScript)
//        contentController.addScriptMessageHandler(
//            self,
//            name: "callbackHandler"
//        )
//        
//        let config = WKWebViewConfiguration()
//        config.userContentController = contentController
//        
//        self.webView = WKWebView(
//            frame: self.containerView.bounds,
//            configuration: config
//        )
//        
//        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "WebKitDeveloperExtras")
//        NSUserDefaults.standardUserDefaults().synchronize()
//        
//        containerView.policyDelegate = self;
//        containerView.frameLoadDelegate = self;
//        containerView.UIDelegate = self;
//        containerView.editingDelegate = self;
//        let try6 = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("index", ofType:"html")!)
//        let fragUrl = NSURL(string: file, relativeToURL: try6)!
//        let request = NSURLRequest(URL: fragUrl)
//        self.webView?.loadRequest(request)
//         self.view = self.webView!
//
////        self.containerView.mainFrame.loadRequest(request)
//    }
//    

    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        if(message.name == "callbackHandler") {
          let something = message.body
            print(something)
        }
    }
    
//    func webView(sender: WebView!, didFinishLoadForFrame frame: WebFrame!) {
//        self.containerView.stringByEvaluatingJavaScriptFromString("")
//    }
//
//     func webView(webView: WebView!, decidePolicyForNavigationAction actionInformation: [NSObject : AnyObject]!, request: NSURLRequest!, frame: WebFrame!, decisionListener listener: WebPolicyDecisionListener!) {
//        
//        if request.URL!.scheme == "function" {
//            
//            switch request.URL!.host!
//            {
//            case "textPrinter":
//                print("textPrinter")
//                let try6 = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("printer", ofType:"html")!)
//                let fragUrl = NSURL(string: "printer.html", relativeToURL: try6)!
//                let request = NSURLRequest(URL: fragUrl)
//                self.webView?.loadRequest(request)
//            case "coverPrinter":
//                print("coverPrinter")
//            case "cutter":
//                print("Cutter")
//            case "bindler":
//                print("Bindler")
//            case "goback":
//                let try6 = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("index", ofType:"html")!)
//                let fragUrl = NSURL(string: "printer.html", relativeToURL: try6)!
//                let request = NSURLRequest(URL: fragUrl)
//                self.webView?.loadRequest(request)
//            default:
//                print("action doesn't exist")
//            }
//        }
//        
//        listener.use()
//    }

}

