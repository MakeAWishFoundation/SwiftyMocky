// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length
fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return compare(lValue, rValue)
    case (nil, nil):
        return true
    default:
        return false
    }
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}

// MARK: - AutoEquatable for classes, protocols, structs
// MARK: - Item AutoEquatable
//extension Item: Equatable {} 
//internal func == (lhs: Item, rhs: Item) -> Bool {
//    guard lhs.name == rhs.name else { return false }
//    guard lhs.id == rhs.id else { return false }
//    return true
//}
// MARK: - ItemDetails AutoEquatable
//extension ItemDetails: Equatable {} 
//internal func == (lhs: ItemDetails, rhs: ItemDetails) -> Bool {
//    guard lhs.item == rhs.item else { return false }
//    guard lhs.price == rhs.price else { return false }
//    guard lhs.description == rhs.description else { return false }
//    return true
//}

// MARK: - AutoEquatable for Enums

// MARK: -
