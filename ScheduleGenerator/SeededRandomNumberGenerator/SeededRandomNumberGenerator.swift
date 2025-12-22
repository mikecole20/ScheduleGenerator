import Foundation

struct SeededRandomNumberGenerator: RandomNumberGenerator {
  init(
    seed: Int
  ) {
    // Use srand48 to set the seed for the drand48 function
    srand48(seed)
  }

  func next() -> UInt64 {
    // drand48() returns a Double between 0.0 and 1.0
    // Multiply by UInt64.max to get a full range UInt64 value
    return UInt64(drand48() * Double(UInt64.max))
  }
}
