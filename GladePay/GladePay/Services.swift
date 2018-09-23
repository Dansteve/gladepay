//
//  Services.swift
//  GladePay
//
//  Created by Muhammed ibrahim on 23/09/2018.
//  Copyright © 2018 Muhammed ibrahim. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let paymentUrl = "https://demo.api.gladepay.com/payment"
let resourcesUrl = "https://demo.api.gladepay.com/resources"

public class Services {
    private init() {}
    
    //-----------------------------Transactions--------------------------------//
    
    func verifyTransaction(key: String, mid: String, txnRef: String, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        let payload: [String: Any] = [
            "action":"verify",
            "txnRef": txnRef
        ]
        Alamofire.request(paymentUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
    }
    
    //-----------------------------Transactions--------------------------------//
    
    //-----------------------------Start Recurrent Transactions--------------------------------//
    
    func recurrentTransactions(key: String, mid: String, firstName: String, lastname: String, email: String, ip: String, fingerprint: String, cardNo: String,  expiryMonth: String, expiryYear: String, cvv: String, pin: String, amount: String, frequency: String, value: String, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        
        let payload: [String: Any] = [
            "action": "initiate",
            "paymentType": "card",
            "user": [
                "firstname": firstName,
                "lastname": lastname,
                "email": email,
                "ip": ip,
                "fingerprint": fingerprint
            ],
            "card": [
                "card_no": cardNo,
                "expiry_month": expiryMonth,
                "expiry_year": expiryYear,
                "ccv": cvv,
                "pin": pin
            ],
            "amount": amount,
            "country": "NG",
            "currency": "NGN",
            "recurrent": [
                "frequency": frequency,
                "value": value
            ]
        ]
        Alamofire.request(paymentUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
    }
    
    func recurrentTransactionsViaToken(key: String, mid: String, firstName: String, lastname: String, email: String, ip: String, fingerprint: String, amount: Int, token: String, frequency: String, value: String, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        
        let payload: [String: Any] = [
            "action": "charge",
            "paymentType": "token",
            "token": token,
            "user": [
                "firstname": firstName,
                "lastname": lastname,
                "email": email,
                "ip": ip,
                "fingerprint": fingerprint
            ],
            "amount": amount,
            "recurrent": [
                "frequency": frequency,
                "value": value
            ]
        ]
        Alamofire.request(paymentUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
    }
    
    func getListOfRecurrentTransactions(key: String, mid: String, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        let payload: [String: Any] = [
            "inquire": "recurrents"
        ]
        Alamofire.request(resourcesUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
    }
    
    func getARecurruentHistory(key: String, mid: String, id: String, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        let payload: [String: Any] = [
            "inquire": "recurrent",
            "id": id
        ]
        Alamofire.request(resourcesUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
    }
    
    func stopRecurrentTransactions(key: String, mid: String, id: String, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        let payload: [String: Any] = [
            "inquire": "recurrent",
            "id": id,
            "status":"start"
        ]
        Alamofire.request(resourcesUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
    }
    
    //-----------------------------End Recurrent Transactions--------------------------------//
    
    //-----------------------------Start Installmental Transactions--------------------------------//
    
    func installmentViaAccount(key: String, mid: String, firstName: String, lastname: String, email: String, ip: String, fingerprint: String, accountNumber: String, bankCode: String, amount: Int, paymentSchedule: [String: Any], total: Int, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        let payload: [String: Any] = [
            "action": "charge",
            "paymentType": "account",
            "user": [
                "firstname": firstName,
                "lastname": lastname,
                "email": email,
                "ip": ip,
                "fingerprint": fingerprint
            ],
            "account": [
                "accountnumber": accountNumber,
                "bankcode": bankCode
            ],
            "amount": amount,
            "installment": [
                "payment_schedule": paymentSchedule,
                "total": total
            ]
        ]
        Alamofire.request(paymentUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
    }
    
    func installmentViaCard(key: String, mid: String, firstName: String, lastname: String, email: String, ip: String, fingerprint: String, cardNo: String,  expiryMonth: String, expiryYear: String, cvv: String, amount: Int, paymentSchedule: [String: Any], total: Int, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        
        let payload: [String: Any] = [
            "action": "initiate",
            "paymentType": "card",
            "user": [
                "firstname": firstName,
                "lastname": lastname,
                "email": email,
                "ip": ip,
                "fingerprint": fingerprint
            ],
            "card": [
                "card_no": cardNo,
                "expiry_month": expiryMonth,
                "expiry_year": expiryYear,
                "ccv": cvv
            ],
            "amount": amount,
            "country": "NG",
            "currency": "NGN",
            "installment": [
                "payment_schedule": paymentSchedule,
                "total": total
            ]
        ]
        Alamofire.request(paymentUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
        
    }
    
    func installmentViaToken(key: String, mid: String, firstName: String, lastname: String, email: String, ip: String, fingerprint: String, token: String, amount: Int, paymentSchedule: [String: Any], total: Int, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        
        let payload: [String: Any] = [
            "action": "charge",
            "paymentType": "token",
            "token": token,
            "user": [
                "firstname": firstName,
                "lastname": lastname,
                "email": email,
                "ip": ip,
                "fingerprint": fingerprint
            ],
            "amount": amount,
            "installment": [
                "payment_schedule": paymentSchedule,
                "total": total
            ]
        ]
        Alamofire.request(paymentUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
    }
    
    func installmentStatus(key: String, mid: String, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        let payload: [String: Any] = [
            "inquire": "installments"
        ]
        Alamofire.request(resourcesUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
    }
    
    func getListOfInstallmentalPayment(key: String, mid: String, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        let payload: [String: Any] = [
            "inquire": "installments"
        ]
        Alamofire.request(resourcesUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
    }
    
    //-----------------------------Stop Installmental Transactions--------------------------------//
    
    //-----------------------------Start Card--------------------------------//
    
    func cardInitiation(key: String, mid: String, firstName: String, lastname: String, email: String, ip: String, fingerprint: String, cardNo: String,  expiryMonth: String, expiryYear: String, cvv: String , amount: Int, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        
        let payload: [String: Any] = [
            "action": "initiate",
            "paymentType": "card",
            "user": [
                "firstname": firstName,
                "lastname": lastname,
                "email": email,
                "ip": ip,
                "fingerprint": fingerprint
            ],
            "card": [
                "card_no": cardNo,
                "expiry_month": expiryMonth,
                "expiry_year": expiryYear,
                "ccv": cvv
            ],
            "amount": amount,
            "country": "NG",
            "currency": "NGN"
        ]
        Alamofire.request(paymentUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
    }
    
    func cardCharge(key: String, mid: String, firstName: String, lastname: String, email: String, ip: String, fingerprint: String, cardNo: String,  expiryMonth: String, expiryYear: String, cvv: String, pin: String, txnRef: String, amount: Int, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        
        let payload: [String: Any] = [
            "action": "initiate",
            "paymentType": "card",
            "user": [
                "firstname": firstName,
                "lastname": lastname,
                "email": email,
                "ip": ip,
                "fingerprint": fingerprint
            ],
            "card": [
                "card_no": cardNo,
                "expiry_month": expiryMonth,
                "expiry_year": expiryYear,
                "ccv": cvv,
                "pin": pin
            ],
            "amount": amount,
            "country": "NG",
            "currency": "NGN",
            "txnRef": txnRef,
            "auth_type":"PIN"
        ]
        Alamofire.request(paymentUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
    }
    
    
    func cardValidation(key: String, mid: String, txnRef: String, otp: String, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        let payload: [String: Any] = [
            "action":"validate",
            "txnRef": txnRef,
            "otp": otp
        ]
        Alamofire.request(paymentUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
    }
    
    func chargeToken(key: String, mid: String, firstName: String, lastname: String, email: String, ip: String, fingerprint: String, amount: Int, token: String, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        let payload: [String: Any] = [
            "action": "charge",
            "paymentType": "token",
            "token": token,
            "user": [
                "firstname":firstName,
                "lastname":lastname,
                "email":email,
                "ip":ip,
                "fingerprint": fingerprint
            ],
            "amount": amount,
            ]
        Alamofire.request(paymentUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
    }
    
    //-----------------------------End Card--------------------------------//
    
    //-----------------------------Account--------------------------------//
    
    func chargeAccount(key: String, mid: String, firstName: String, lastname: String, email: String, ip: String, fingerprint: String, accountNumber: String, bankCode: String, amount: Int, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        let payload: [String: Any] = [
            "action": "charge",
            "paymentType": "account",
            "user": [
                "firstname":firstName,
                "lastname":lastname,
                "email":email,
                "ip":ip,
                "fingerprint": fingerprint
            ],
            "account": [
                "accountnumber":accountNumber,
                "bankcode":bankCode
            ],
            "amount": amount,
            ]
        Alamofire.request(paymentUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
    }
    
    func accountValidation(key: String, mid: String, txnRef: String, otp: String, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        let payload: [String: Any] = [
            "action":"validate",
            "txnRef": txnRef,
            "validate": "account",
            "otp":otp
        ]
        Alamofire.request(paymentUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
    }
    //-----------------------------Account--------------------------------//
    
    //-----------------------------Start Resources--------------------------------//
    
    func getSupportedChargeableBanks(key: String, mid: String, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        let payload: [String: Any] = [
            "inquire": "supported_chargable_banks"
        ]
        Alamofire.request(resourcesUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
    }
    
    func getListOfBanks(key: String, mid: String, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        let payload: [String: Any] = [
            "inquire": "banks"
        ]
        
        Alamofire.request(resourcesUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
    }
    
    func verifyAccountName(key: String, mid: String, accountNumber: String, bankCode: String, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        let payload: [String: Any] = [
            "inquire": "accountname",
            "accountnumber": accountNumber,
            "bankcode": bankCode
        ]
        Alamofire.request(resourcesUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
    }
    
    func getCardDetails(key: String, mid: String, cardNo: String, completion: @escaping (Any) -> Void) {
        let headers = ["Content-Type": "application/json",
                       "KEY": key,
                       "MID": mid]
        let payload: [String: Any] = [
            "inquire": "card",
            "card_no": cardNo
        ]
        Alamofire.request(resourcesUrl, method: .put, parameters: payload, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.value != nil {
                let jsonResponse = JSON(response.result.value!)
                completion(jsonResponse)
            }
        }
    }
    
    //-----------------------------End Resources--------------------------------//
}
