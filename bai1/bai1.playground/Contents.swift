//: Playground - noun: a place where people can play

import UIKit
// 1. In Hello World
print("Hello World")

// 2. In hinh chu nhat
for _ in 1...15 {
    print("*", terminator: "")
}
print("")
for _ in 1...10 {
    print("*", terminator: "")
    for _ in 1...13 {
        print(" ", terminator: "")
    }
    print("*", terminator: "")
    print("")
}
for _ in 1...15 {
    print("*", terminator: "")
}
print("")

// 3. Khai bao mang gom cac chuoi,
// them phan tu vao mang,
// in ra mang truoc va sau khi them
var array = ["Anh", "yeu", "em"]
for string in array {
    print("\(string) ", terminator: "")
}
print("")
array.append("nhieu")
for string in array {
    print("\(string) ", terminator: "")
}
print("")

// 4. Khai bao dictionary luu tru
// ten, tuoi, dia chi, sdt
// in ra ten nguoi dung do
let info = ["name": "Giap Minh Cuong", "age": "22", "address": "Ha Noi", "phone": "0967962148"]
print("name = \(info["name"]!)")
print("-----------------")

// 5. Mang cac dictionary luu thong tin nguoi dung
// sap xep mang theo tuoi tang dan
// in ra man hinh
var users: [[String: String]] = []
users.append(["name": "Giap Minh Cuong", "age": "22", "address": "Ha Noi", "phone": "0967962148"])

users.append(["name": "Thu Uyen", "age": "21", "address": "Sam Son", "phone": "0967962148"])

users.append(["name": "XXX", "age": "23", "address": "Hai Phong", "phone": "xxxxxxxx"])
let sortedUsers = users.sorted(by: { $0["age"]! < $1["age"]! })
for user in sortedUsers {
    for (key, value) in user {
        print("\(key) : \(value)")
    }
    print("-----------------")
}








