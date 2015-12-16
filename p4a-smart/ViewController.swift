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
    @IBOutlet weak var webView: WebView!
    @IBOutlet weak var tableView: NSTableView!
    
    
    //realm Data configuration
    let realm = try! Realm()
    
    
        //realm data variables
        let textPrinterData = TextPrinterData()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.reloadData()
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "WebKitDeveloperExtras")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        webView.policyDelegate = self;
        webView.frameLoadDelegate = self;
        webView.UIDelegate = self;
        webView.editingDelegate = self;
        

        
        
        let try6 = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("index", ofType:"html")!)
        let fragUrl = NSURL(string: "index.html", relativeToURL: try6)!
        let request = NSURLRequest(URL: fragUrl)
        self.webView.mainFrame.loadRequest(request)
        
        // Do any additional setup after loading the view.
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

//    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage){
//        if(message.name == "callbackHandler") {
//            print("JavaScript is sending a message \(message.body)")
//        }
//    }
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        if(message.name == "callbackHandler") {
            print("JavaScript is sending a message \(message.body)")
        }
    }

}

