//
//  MoneyTests.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

import ExtDomainModel

//////////////////
// MoneyTests
//
class MoneyTests: XCTestCase {
    
    let tenUSD = Money(amount: 10, currency: Money.Currency.USD)
    let twelveUSD = Money(amount: 12, currency: Money.Currency.USD)
    let fiveGBP = Money(amount: 5, currency: Money.Currency.GBP)
    let fifteenEUR = Money(amount: 15, currency: Money.Currency.EUR)
    let fifteenCAN = Money(amount: 15, currency: Money.Currency.CAN)
    
    // added description to all tests //
    
    func testCanICreateMoney() {
        let oneUSD = Money(amount: 1, currency: Money.Currency.USD)
        XCTAssert(oneUSD.amount == 1)
        XCTAssert(oneUSD.currency == Money.Currency.USD)
        XCTAssert(oneUSD.description == "USD1.0")
        
        let tenGBP = Money(amount: 10, currency: Money.Currency.GBP)
        XCTAssert(tenGBP.amount == 10)
        XCTAssert(tenGBP.currency == Money.Currency.GBP)
        XCTAssert(tenGBP.description == "GBP10.0")
    }
    
    func testUSDtoGBP() {
        let gbp = tenUSD.convert("GBP")
        XCTAssert(gbp.currency == Money.Currency.GBP)
        XCTAssert(gbp.amount == 5)
        XCTAssert(gbp.description == "GBP5.0")
        
    }
    func testUSDtoEUR() {
        let eur = tenUSD.convert("EUR")
        XCTAssert(eur.currency == Money.Currency.EUR)
        XCTAssert(eur.amount == 15)
        XCTAssert(eur.description == "EUR15.0")
        
    }
    func testUSDtoCAN() {
        let can = twelveUSD.convert("CAN")
        XCTAssert(can.currency == Money.Currency.CAN)
        XCTAssert(can.amount == 15)
        XCTAssert(can.description == "CAN15.0")
        
    }
    func testGBPtoUSD() {
        let usd = fiveGBP.convert("USD")
        XCTAssert(usd.currency == Money.Currency.USD)
        XCTAssert(usd.amount == 10)
        XCTAssert(usd.description == "USD10.0")
        
    }
    func testEURtoUSD() {
        let usd = fifteenEUR.convert("USD")
        XCTAssert(usd.currency == Money.Currency.USD)
        XCTAssert(usd.amount == 10)
        XCTAssert(usd.description == "USD10.0")
        
    }
    func testCANtoUSD() {
        let usd = fifteenCAN.convert("USD")
        XCTAssert(usd.currency == Money.Currency.USD)
        XCTAssert(usd.amount == 12)
        XCTAssert(usd.description == "USD12.0")
        
    }
    
    func testUSDtoEURtoUSD() {
        let eur = tenUSD.convert("EUR")
        let usd = eur.convert("USD")
        XCTAssert(tenUSD.amount == usd.amount)
        XCTAssert(tenUSD.currency == usd.currency)
        XCTAssert(eur.description == "EUR15.0")
        XCTAssert(usd.description == "USD10.0")
        
    }
    func testUSDtoGBPtoUSD() {
        let gbp = tenUSD.convert("GBP")
        let usd = gbp.convert("USD")
        XCTAssert(tenUSD.amount == usd.amount)
        XCTAssert(tenUSD.currency == usd.currency)
        XCTAssert(gbp.description == "GBP5.0")
        XCTAssert(usd.description == "USD10.0")
    }
    func testUSDtoCANtoUSD() {
        let can = twelveUSD.convert("CAN")
        let usd = can.convert("USD")
        XCTAssert(twelveUSD.amount == usd.amount)
        XCTAssert(twelveUSD.currency == usd.currency)
        XCTAssert(can.description == "CAN15.0")
        XCTAssert(usd.description == "USD12.0")
    }
    
    func testAddUSDtoUSD() {
        let total = tenUSD.add(tenUSD)
        XCTAssert(total.amount == 20)
        XCTAssert(total.currency == Money.Currency.USD)
        XCTAssert(total.description == "USD20.0")
    }
    
    func testAddUSDtoGBP() {
        let total = tenUSD.add(fiveGBP)
        XCTAssert(total.amount == 10)
        XCTAssert(total.currency == Money.Currency.GBP)
        XCTAssert(total.description == "GBP10.0")
        
    }
    
    func testSubtractTenUSDfromTwelveUSD() {
        let difference = tenUSD.subtract(twelveUSD)
        XCTAssert(difference.amount == 2)
    }
    
    func testExtensionDoubleTwelveUSD() {
        let usd = 12.USD
        XCTAssert(usd.amount == 12)
        XCTAssert(usd.currency == Money.Currency.USD)
        XCTAssert(usd.description == "USD12.0")
    }
    
    func testExtensionDoubleFiftyFiveEUR() {
        let usd = 55.EUR
        XCTAssert(usd.amount == 55)
        XCTAssert(usd.currency == Money.Currency.EUR)
        XCTAssert(usd.description == "EUR55.0")
    }
    
    func testExtensionDoubleTwentyThreeGBP() {
        let usd = 23.GBP
        XCTAssert(usd.amount == 23)
        XCTAssert(usd.currency == Money.Currency.GBP)
        XCTAssert(usd.description == "GBP23.0")
    }
    
    func testExtensionDoubleNintyThousandTwoHundredEightFourYEN() {
        let usd = 90284.YEN
        XCTAssert(usd.amount == 90284)
        XCTAssert(usd.currency == Money.Currency.YEN)
        XCTAssert(usd.description == "YEN90284.0")
    }
}

