//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"

//let inputTypeRegular = "^[0-9]{1,4}+(.[0-9]{1})?$"
//let inputPredicate = NSPredicate(format: "SELF MATCHES %@", inputTypeRegular)
//let a = inputPredicate.evaluate(with: "53438")

//var s = "24"
//var aa = s.split(separator: ".")
//print(aa)


//func decTohex(i:Int) -> String {
//    return String(format: "%0X", i)
//}
//
//decTohex(i: 45)
//
//var aaa = ["aa":"ss","saa":"asv"]
//
//if aaa["aaa"] == "ss"{
//    print(1)
//}

//
//var str = "a"
////String to Unicode
//var dataenc = str.data(using: String.Encoding.nonLossyASCII)
//var encodevalue = String(data: dataenc!, encoding: String.Encoding.utf8)
//
////Unicode to String
//var datadec  = encodevalue?.data(using: String.Encoding.utf8)
//var decodevalue = String(data: datadec!, encoding: String.Encoding.nonLossyASCII)
////
//
//
//let unicodeData = "\\u53f0"
//let data = unicodeData.data(using: String.Encoding.utf8)
//let value = String(data: data!, encoding: String.Encoding.nonLossyASCII)
//

//let a = "53"
//for i in a.unicodeScalars{
//    print(i.hashValue)
//    print(String(format: "%0X", i.value))
//}
//let b = a.index(a.startIndex, offsetBy: 8)
//let c = a[b..<a.endIndex].description


//extension String{
//    func separation(interval:Int)->[String]{
//        var array:[String] = []
//        var startIndex = self.startIndex
//        var endIndex = self.index(startIndex, offsetBy: interval)
//
//        for _ in 1...self.count/interval{
//            array.append(self[startIndex..<endIndex].description)
//            startIndex = endIndex
//            if startIndex == self.endIndex{
//                break
//            }else{
//                endIndex = self.index(startIndex, offsetBy: interval)
//            }
//        }
//        return array
//    }
//}
//
//var x = "F1F1F1F1F1F1F1F1F1F1"
//let kk = x.separation(interval: 5)
//for (i,j) in kk.enumerated(){
//    print(i,j)
//}
//
//
//
//var aaaa = ["a":"ss"]
//let aa = "A"
//for scaler in aa.unicodeScalars{
//    print(scaler.value)
//}

//var aa = ["a":"0","b":"1","c":"2"]
//for element in aa{
//    print(element.value)
//}



