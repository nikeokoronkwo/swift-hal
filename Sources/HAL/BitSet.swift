//
//  Bitset.swift
//  swift-hal
//
//  Created by Nikechukwu Okoronkwo on 12/20/25.
//

/// Default conformances to ExpressibleByIntegerLiteral and RawRepresentable are provided via
/// protocol extensions and rely only on `value`.
public protocol BitSetProtocol: ExpressibleByIntegerLiteral, RawRepresentable, CustomStringConvertible where RawValue == Base, IntegerLiteralType == Base, IntegerLiteralType == Base {
    associatedtype Base: FixedWidthInteger & UnsignedInteger
    
    /// Create an empty bit set (all bits cleared).
    init()
    
    /// The underlying unsigned integer storage for the bit set.
    /// Implementations should mutate this value to reflect bit operations.
    var value: Base { get set }
    
    /// Get or set the bit at a given index. This is not guaranteed to be checked. For checked gets or sets, see ``set`` and ``get``
    /// - Parameter index: The zero-based bit position. Valid range is `0..<base.bitWidth`.
    /// - Returns: `1` if the bit is set, otherwise `0`.
    subscript(_ index: Int) -> UInt8 { get set }
    
    /// Returns `true` if all bits in the bit set are `1`.
    func all() -> Bool
    
    /// Returns `true` if at least one bit in the bit set is `1`.
    func any() -> Bool
    
    /// Returns `true` if all bits in the bit set are `0`.
    func none() -> Bool
    
    /// The number of `1` bits in the bit set.
    var nonzeroBitCount: Int { get }
    
    /// The total number of bits in the bit set (equal to the bit width of `base`).
    var count: Int { get }
    
    /// Gets the bit at the given position
    func get(_ pos: Int) throws -> UInt8
    
    /// Sets the bit at the given position to `value` (0 or 1).
    mutating func set(_ pos: Int, _ value: UInt8) throws
    
    /// Sets all bits to `1`.
    mutating func set()
    
    /// Sets all bits at the given positions to `value` (0 or 1).
    mutating func setAll(_ value: UInt8, at positions: [Int])
    
    /// Resets (sets to `0`) the bit at the given position.
    mutating func reset(_ pos: Int) throws
    
    /// Resets all bits to `0`.
    mutating func reset()
    
    /// Resets (sets to `0`) all bits at the given positions.
    mutating func resetAll(at positions: [Int])
    
    /// Flips (toggles) the bit at the given position.
    mutating func flip(_ pos: Int) throws
    
    /// Flips (toggles) all bits.
    mutating func flip()
}

public extension BitSetProtocol {
    static func & (lhs: Self, rhs: Self) -> Base { lhs.value & rhs.value }
    static func ^ (lhs: Self, rhs: Self) -> Base { lhs.value ^ rhs.value }
    static func | (lhs: Self, rhs: Self) -> Base { lhs.value | rhs.value }
    
    static func & (lhs: Self, rhs: Base) -> Base { lhs.value & rhs }
    static func ^ (lhs: Self, rhs: Base) -> Base { lhs.value ^ rhs }
    static func | (lhs: Self, rhs: Base) -> Base { lhs.value | rhs }
    
    static func &= (lhs: inout Self, rhs: Base) { lhs.value &= rhs }
    static func ^= (lhs: inout Self, rhs: Base) { lhs.value ^= rhs }
    static func |= (lhs: inout Self, rhs: Base) { lhs.value |= rhs }
    
    static prefix func ~ (x: Self) -> Base { ~x.value }
    
    static func << (lhs: Self, rhs: Base) -> Base { lhs.value << rhs }
    static func >> (lhs: Self, rhs: Base) -> Base { lhs.value >> rhs }
    
    static func <<= (lhs: inout Self, rhs: Base) { lhs.value <<= rhs }
    static func >>= (lhs: inout Self, rhs: Base) { lhs.value >>= rhs }
}

public extension BitSetProtocol {
    init(rawValue: RawValue) {
        self.init(integerLiteral: rawValue)
    }
    
    var rawValue: RawValue { value }
}

public extension BitSetProtocol {
    init(integerLiteral value: IntegerLiteralType) {
        self = Self._make(from: value)
    }

    // Helper to build a default instance and assign its storage.
    private static func _make(from raw: Base) -> Self {
        var instance = Self._empty()
        instance.value = raw
        return instance
    }

    // Default empty factory; conformers inherit a synthesized init() if available.
    private static func _empty() -> Self {
        return Self.init()
    }
}

public extension BitSetProtocol {
    var description: String {
        var result: [String] = []
        for i in 0..<(value.bitWidth / 8) {
            let byte = UInt8(truncatingIfNeeded: value >> (i * 8))
            let byteString = String(byte, radix: 2)
            let padding = String(repeating: "0",
                                 count: 8 - byteString.count)
            result.append(padding + byteString)
        }
        return "0b" + result.reversed().joined(separator: "_")
    }
}

/// A fixed view of individual bits in a given unsigned integer
///
/// A bitset is meant to represent a set of bits, usually for a given number. It allows users to have a view of individual bits in a given number in order to manipulate them in a safe, easy way. The implementation of a bitset here is meant to be similar to `std::bitset` in C++, but making use of Swift semantics and without the dependency on `bitset.h`.
///
/// This implementation of a bit set makes use of an ``InlineArray`` rather than a normal ``UInt`` to reduce space and for more performance, since the size of the bitset is known at compile time.
/// For dynamically-growing bit sets, use ``BitSet`` instead.
@available(macOS 26.0.0, *)
@frozen
public struct FixedBitSet<let count: Int> {
    var base: InlineArray<count, UInt8>
}

@available(macOS 26.0.0, *)
extension FixedBitSet {
    public init() {
        self.base = InlineArray<count, UInt8>(repeating: 0)
    }

    public init(_ int: UInt?) {
        self.base = InlineArray<count, UInt8>(repeating: 0)
        guard var num = int else { return }

        withUnsafeBytes(of: &num) { rawBuffer in
            let byteCount = min(count, rawBuffer.count)
            for i in 0..<byteCount {
                self.base[i] = rawBuffer[i]
            }
        }
    }
    
    public init(_ int: Int?) {
        self.init(int == nil ? nil : UInt(int!))
    }
    
    public init(repeating: UInt8) {
        self.base = InlineArray<count, UInt8>(repeating: repeating)
    }
}

@available(macOS 26.0.0, *)
extension FixedBitSet: BitSetProtocol {
    public var value: UInt {
        get {
            var buf: UInt = 0
            for i in 0..<base.count {
                buf += UInt(base[i] << i)
            }
            
            return buf
        }
        set {
            for i in 0..<newValue.bitWidth {
                base[i] = UInt8((newValue >> 0) & 1)
            }
        }
    }
    
    public subscript(index: Int) -> UInt8 {
        get {
            base[index]
        }
        set {
            base[index] = newValue
        }
    }
    
    public func all() -> Bool {
        for i in 0..<base.count {
            if base[i] == 0 { return false }
        }
        return true
    }
    
    public func any() -> Bool {
        for i in 0..<base.count {
            if base[i] != 0 { return true }
        }
        return false
    }
    
    public func none() -> Bool {
        for i in 0..<base.count {
            if base[i] != 0 { return false }
        }
        return true
    }
    
    public var nonzeroBitCount: Int {
        var count = 0
        for i in 0..<base.count {
            if base[i] != 0 { count += 1 }
        }
        return count
    }
    
    public var count: Int {
        base.count
    }
    
    public func get(_ pos: Int) throws -> UInt8 {
        guard pos >= 0 && pos < base.count else {
            throw BitSetError.outOfBounds
        }
        return base[pos]
    }
    
    public mutating func set(_ pos: Int, _ value: UInt8) throws {
        guard pos >= 0 && pos < base.count else {
            throw BitSetError.outOfBounds
        }
        base[pos] = value
    }
    
    public mutating func set() {
        for i in 0..<base.count {
            base[i] = 1
        }
    }
    
    public mutating func setAll(_ value: UInt8, at positions: [Int]) {
        positions.forEach { p in
            base[p] = value
        }
    }
    
    public mutating func reset(_ pos: Int) throws {
        base[pos] = 0
    }
    
    public mutating func reset() {
        for i in 0..<base.count {
            base[i] = 0
        }
    }
    
    public mutating func resetAll(at positions: [Int]) {
        positions.forEach { p in
            base[p] = 0
        }
    }
    
    public mutating func flip(_ pos: Int) throws {
        base[pos] = base[pos] == 0 ? 1 : 0
    }
    
    public mutating func flip() {
        for i in 0..<base.count {
            base[i] = base[i] == 0 ? 1 : 0
        }
    }
}


enum BitSetError: Error {
    case outOfBounds
}

