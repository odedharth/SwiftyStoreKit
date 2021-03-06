//
//  OS.swift
//  SwiftyStoreKit
//
// Copyright (c) 2015 Andrea Bizzotto (bizz84@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import StoreKit

// MARK: - missing SKPaymentTransactionState on OSX
#if os(iOS)
    typealias PaymentTransactionState = SKPaymentTransactionState
#elseif os(OSX)
    enum PaymentTransactionState : Int {
        case Purchasing // Transaction is being added to the server queue.
        case Purchased // Transaction is in queue, user has been charged.  Client should complete the transaction.
        case Failed // Transaction was cancelled or failed before being added to the server queue.
        case Restored // Transaction was restored from user's purchase history.  Client should complete the transaction.
        case Deferred // The transaction is in the queue, but its final status is pending external action.
    }
#endif

// MARK: - missing SKMutablePayment init with product on OSX
#if os(OSX)
    extension SKMutablePayment {
        convenience init(product: SKProduct) {
            self.init()
            self.productIdentifier = product._productIdentifier! // unsafe
        }
    }
#endif

// MARK: - product identifier optional on OSX, not on iOS

extension SKProduct {
    var _productIdentifier: String? {
        return self.productIdentifier
    }
}

// MARK: - products is optional on OSX, not on iOS
extension SKProductsResponse {
    var _products: [SKProduct]? {
        return self.products
    }
    var _invalidProductIdentifiers: [String]? {
        return self.invalidProductIdentifiers
    }
}