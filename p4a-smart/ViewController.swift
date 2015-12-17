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
    @IBOutlet weak var tableView: NSTableView!
    var webView: WKWebView?
    
    
    //realm Data configuration
    let realm = try! Realm()
    
    
    //realm data variables
    let textPrinterData = TextPrinterData()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.reloadData()
        
        laodingWeb("index.html")
        
    }
    
    
    
    func laodingWeb(file: String) {
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
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "WebKitDeveloperExtras")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        containerView.policyDelegate = self;
        containerView.frameLoadDelegate = self;
        containerView.UIDelegate = self;
        containerView.editingDelegate = self;
        let try6 = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("index", ofType:"html")!)
        let fragUrl = NSURL(string: file, relativeToURL: try6)!
        let request = NSURLRequest(URL: fragUrl)
        self.webView?.loadRequest(request)
        self.containerView.mainFrame.loadRequest(request)
    }
    

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    func numberOfRowsInTableView(tableView: NSTableView) -> Int
    {
        return 1
    }

    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView?
    {
        let cellView = tableView.makeViewWithIdentifier("cell", owner: self) as! NSTableCellView
        
        cellView.textField!.stringValue = "sds"
        
        return cellView
    }
        



    func tableViewSelectionDidChange(notification: NSNotification)
    {
        if (self.tableView.numberOfSelectedRows > 0)
        {
            let selectedItem = "sds"
            
       print(selectedItem)
            
        }
        
    }
    
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        if(message.name == "callbackHandler") {
          let something = message.body
            print(something)
        }
    }
    
    func webView(sender: WebView!, didFinishLoadForFrame frame: WebFrame!) {
        self.containerView.stringByEvaluatingJavaScriptFromString("")
    }

     func webView(webView: WebView!, decidePolicyForNavigationAction actionInformation: [NSObject : AnyObject]!, request: NSURLRequest!, frame: WebFrame!, decisionListener listener: WebPolicyDecisionListener!) {
        
        if request.URL!.scheme == "action" {
            
            switch request.URL!.host!
            {
            case "signin":
                print("sdsdfdsd")

                
            default:
                print("action doesn't exist")
            }
        }
        
        listener.use()
    }

}

