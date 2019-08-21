//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var ary = [1,2,3,4,5,6,7,8,9,10]
var ary1 = [Int]()

ary1 = ary.filter({$0 % 2 == 0})

ary1 = ary.filter({ (element) -> Bool in
    return element % 2 == 0
})


//ary1 = ary.map({$0 * 2})
//
//ary1 = ary.map({ (element) -> Int in
//    return element * 2
//})


var a = ary.reduce(0, { (sum, element) -> Int in
    return sum + element
})

a = ary.reduce(0, {$0 + $1})
print(a)


ary1.sort { (first, second) -> Bool in
    return first > second
}

var ary2 = [2,6,3,5,43,4,34]
ary2.sorted()







var add = {(arg1:Int,arg2:Int) -> Int in
        return arg1 + arg2
}
add = {(arg1,arg2) -> Int in
        return arg1 + arg2
}
add = {$0 + $1}
var b = add(2, 6)

var d:Int? = nil
d = 2
print(d)

//if let c = d{
//    print(c)
//    print("d有值")
//}


var city = [1,2,2]

if city.contains(12){
    print("s")
}

print(city.contains(12))



extension Int {
    func repeats(word:String)->[String]{
        return [String](repeating: word, count: self)
    }
}

3.repeats(word: "3")




