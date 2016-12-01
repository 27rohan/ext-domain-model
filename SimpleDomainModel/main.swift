//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

protocol CustomStringConvertible {
    var description: String {
        get
    }
}

protocol Mathematics {
    func add(_ to: Money) -> Money
    func subtract(_ to: Money) -> Money
}

extension Double {
    var USD: Money { return Money(amt: Int(self), currency: "USD") }
    var EUR: Money { return Money(amt: Int(self), currency: "EUR") }
    var GBP: Money { return Money(amt: Int(self), currency: "GBP") }
    var YEN: Money { return Money(amt: Int(self), currency: "YEN") }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
  public enum Currency: String {
        case USD = "USD", EUR = "EUR", CAN = "CAN", GBP = "GBP", YEN = "YEN"
    }
    
    internal var description: String {
        get { return "\(currency)\(amount).0" }
    }
    
    init(amt: Int, currency: String){
        self.amount = amt
        self.currency = currency
    }
    
  public func convert(_ to: String) -> Money {
    
    if self.currency == currency{
        return self
    }
    if (self.currency == "USD"){
        
        if currency == "GBP"{
            return Money(amt:self.amount/2, currency:"GBP")
        }
            
        else if currency == "EUR"{
            return Money(amt:self.amount*3/2,currency: "EUR")
        }
            
        else if currency == "CAN"{
            return Money(amt:self.amount*5/4,currency:"CAN")
        }
        
    }//self.currency is USD
    
    if (self.currency == "GBP"){
        
        if currency == "USD"{
            return Money(amt:self.amount*2, currency:"USD")
        }
            
        else if currency == "EUR"{
            return Money(amt:self.amount*3, currency:"EUR")
        }
            
        else if currency == "CAN"{
            return Money(amt:self.amount*5/2, currency:"CAN")
        }
        
    }//self.currency is GBP
    
    if (self.currency == "EUR"){
        
        if currency == "USD"{
            return Money(amt:self.amount*2/3, currency:"USD")
        }
            
        else if currency == "GBP"{
            return Money(amt:self.amount/3, currency:"GBP")
        }
            
        else if currency == "CAN"{
            return Money(amt:self.amount*5/6, currency:"CAN")
        }
        
    }//self.currency is EUR
    
    
    if (self.currency == "CAN"){
        
        if currency == "USD"{
            return Money(amt:self.amount*4/5, currency:"USD")
        }
            
        else if currency == "GBP"{
            return Money(amt:self.amount*2/5, currency:"GBP")
        }
            
        else if currency == "EUR"{
            return Money(amt:self.amount*6/5, currency:"EUR")
        }
        
    }//self.currency is CAN
    
    return Money(amt:0,currency:"USD")
    
  }
  
  public func add(_ to: Money) -> Money {
    
    let added_value = self.amount+self.convert(self.currency).amount
    return Money(amt: added_value, currency: self.currency)
    
  }
  public func subtract(_ from: Money) -> Money {
    let sub_value = self.amount-self.convert(self.currency).amount
    return Money(amt: sub_value, currency: self.currency)
    
  }
}

////////////////////////////////////
// Job
//
open class Job {
    fileprivate var title : String
    fileprivate var type : JobType
    
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    
    open func calculateIncome(_ hours: Int) -> Int {
        switch self.type {
        case .Hourly(let time):
            return Int(time * Double(hours))
        case .Salary(let time):
            return time
        }
    }
    
    open func raise(_ amt : Double) {
        switch self.type {
        case .Hourly(let hourly):
            self.type = .Hourly(hourly + amt)
        case .Salary(let salary):
            self.type = .Salary(salary + Int(amt))
        }
    }
}

////////////////////////////////////
// Person
//
open class Person {
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    fileprivate var _job : Job? = nil
    open var job : Job? {
        get {
            return _job
        }
        set(value) {
            if self.age >= 16 {
                self._job = value
            }
        }
    }
    
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get {
            return _spouse
        }
        set(value) {
            if self.age >= 18 {
                self._spouse = value
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    open func toString() -> String {
        return ("[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]")
    }
}


////////////////////////////////////
// Family
//
open class Family {
    fileprivate var members : [Person] = []
    
    public init(spouse1: Person, spouse2: Person) {
        members.append(spouse1)
        members.append(spouse2)
        
        // test for validity before proceding
        assert(spouse1._spouse == nil)
        assert(spouse2._spouse == nil)
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
    }
    
    open func haveChild(_ child: Person) -> Bool {
        members.append(child)
        return true
    }
    
    open func householdIncome() -> Int {
        var result: Int = 0
        for member in self.members {
            if member.job != nil {
                result = result + (member.job?.calculateIncome(2000))!
            }
        }
        return result
    }
}





