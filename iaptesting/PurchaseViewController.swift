//
//  PurchaseViewController.swift
//  iaptesting
//
//  Created by Cyrus Chan on 5/2/2017.
//  Copyright © 2017 ckmobile.com. All rights reserved.
//

import UIKit
import StoreKit
class PurchaseViewController: UIViewController, SKPaymentTransactionObserver, SKProductsRequestDelegate{

    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var buyButton: UIButton!
    
    var product:SKProduct?
    var productID = "com.ckmobile.iaptesting.inapppurchase01"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let appDel = UIApplication.shared.delegate as! AppDelegate
//        appDel.homeController = self
        
        
        buyButton.isEnabled = false
        SKPaymentQueue.default().add(self)
        getPurchaseInfo()
        
        
      
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buy(_ sender: Any) {
        //initiate the trensaction
        let payment = SKPayment(product: product!)
        
        SKPaymentQueue.default().add(payment)
        //the above code is to trigger the payment
        
        
    }
    
    func getPurchaseInfo(){
        
        if SKPaymentQueue.canMakePayments(){
            
            let request = SKProductsRequest(productIdentifiers: NSSet(objects: self.productID) as! Set<String>)
            request.delegate = self
            request.start()
        }else{
            productDescription.text = "Please enable in app purchase in your settings"
        }
        
        
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        var products = response.products
        if (products.count != 0) {
            product = products[0]
            buyButton.isEnabled = true
            productTitle.text = product!.localizedTitle
            productDescription.text = product!.localizedDescription
            
            let save = UserDefaults.standard
            if save.value(forKey: "Purchase") != nil {
                enableLevel2()
            }else{
                
            }
            
            
        } else{
            productTitle.text = "Product not found"
            
        }
        
        let invalids = response.invalidProductIdentifiers
        for product in invalids{
            print("product not found\(product)")
        }
        
        
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions{
            
            switch transaction.transactionState {
            case SKPaymentTransactionState.purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                self.unlockPurchase()
                //finish transaction and trigger the unlock function
                productTitle.text = "Purchased !!"
                buyButton.isEnabled = false
                
                
            case SKPaymentTransactionState.failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                productTitle.text = "Not yet purchased!!!"
                
                
                
            default:
                break
            
            }
            
            
            
        }
        
        
    }
    
    func unlockPurchase(){
        //trigger function at a different view
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.homeController!.enableLevel2()
      
        let save = UserDefaults.standard
        save.setValue(true, forKey: "Purchase")
        save.synchronize()

    }
    
    func enableLevel2(){
        buyButton.isEnabled = false
        //        purchaseButton.isEnabled = false
        //        purchaseButton.isHidden = true
    }
    
}
