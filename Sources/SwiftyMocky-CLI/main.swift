import ShellOut

print("Hello, world!")

do {
    let a = try shellOut(to: "which mint")
    print(a)
    let b = try shellOut(to: "echo \"123123\"")
    print(b)
    let c = try shellOut(to: "which sourcery")
    print(c)
} catch let error as ShellOutError {
    print("Error: \(error.message)")
    print("Output: \(error.output)")
} catch {
    fatalError("Unhandled error: \(error)")
}