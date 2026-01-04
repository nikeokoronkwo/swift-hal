public protocol IOBase: Device {
    func on() throws
    func off() throws
}

public protocol PinBase: IOBase {
    var mode: PinMode { get }
    
    var value: Bool { get throws }
}

public protocol PinSetBase: IOBase {
    associatedtype P: PinBase
    
    var values: [Bool?] { get throws }
    subscript(index: Int) -> P? { get }
}

public enum PinMode: Sendable {
    case input
    case output
    case inputOutput
    
    var isInput: Bool {
        switch self {
        case .output:
            return false
        default:
            return true
        }
    }
    
    var isOutput: Bool {
        switch self {
        case .input:
            return false
        default:
            return true
        }
    }
}

public enum PinPullState {
    case none
    case pullUp
    case pullDown
}

public enum PinLevelState {
    case high
    case low
}

public enum PinEdgeState {
    case rise
    case fall
}

public enum PinError: Error {
    case wrongMode(PinMode, expected: PinMode)
}

/// An I/O Pin
///
/// An I/O Pin is a peripheral device with which digital signals can be written and read to
///
/// Most pins are exclusively either used for input (reading data/signals) or output (writing data/signals). However, because architectures may differ, we do not assert that pins may be one or the other.
public struct Pin<H: IOCapable>: PinBase {
    public typealias UnderlyingHAL = H
    
    unowned fileprivate let hal: H
    
    /// The memory mapped address where the given pin is located
    // TODO: Memory safety address
    let address: UInt

    /// The type of pin present (input or output)
    ///
    /// For more information about pin modes, see ``PinMode``
    public let mode: PinMode
    
    /// The pull state of the pin
    public let pull: PinPullState?

    init(_ hal: H, address: UInt, mode: PinMode = .inputOutput, pull: PinPullState? = nil) throws {
        self.hal = hal
        self.address = address
        self.mode = mode
        self.pull = pull

        try hal.configure(at: address, mode: mode, pull: pull)
    }

    /// Sets a pin's output to high (value 1)
    public func on() throws {
        guard mode.isOutput else {
            throw PinError.wrongMode(mode, expected: .output)
        }
        try hal.write(at: self.address, value: true)
    }

    /// Sets a pin's output to low (value 0)
    public func off() throws {
        guard mode.isOutput else {
            throw PinError.wrongMode(mode, expected: .output)
        }
        try hal.write(at: self.address, value: false)
    }

    /// Get the value of an input
    public var value: Bool {
        get throws {
            guard mode.isInput else {
                throw PinError.wrongMode(mode, expected: .input)
            }
            return try hal.read(at: self.address)
        }
    }
}

extension Pin where H: AsyncIOCapable {
    public var valueStream: AsyncStream<PinLevelState> {
        get throws {
            try hal.pinLevelState(at: address)
        }
    }
    
    public var edgeStream: AsyncStream<PinEdgeState> {
        get throws {
            try hal.pinEdgeState(at: address)
        }
    }
}

/// A set of pins, which can be used to work on pin I/O operations on multiple I/O points at the same time, without having to manage each individual pin
public struct PinSet<H: IOCapable>: PinSetBase {
    public typealias UnderlyingHAL = H
    
    public var values: [Bool?] {
        get throws {
            let addressKeyApp: [UInt] = addressMap.compactMap({ (key: UInt, arg1) in
                let (mode, _) = arg1
                guard mode.isInput else {
                    return nil
                }
                return key
            })
            let readValues = try hal.readAll(at: addressKeyApp)
            return readValues.map { (addr: UInt, value: Bool) in
                if addressKeyApp.contains(addr) {
                    return value
                }
                return nil
            }
        }
    }
    
    public func on() throws {
        try hal.writeAll(map: addressMap.compactMapValues({ (mode, _) in
            guard mode.isOutput else { return nil }
            return true
        }))
    }
    
    public func off() throws {
        try hal.writeAll(map: addressMap.compactMapValues({ (mode, _) in
            guard mode.isOutput else { return nil }
            return false
        }))
    }
    
    unowned fileprivate let hal: H
    
    /// The set of addresses referred to by the given pin set
    let addressMap: [UInt: (PinMode, PinPullState?)]
    
    init(_ hal: H, addressMap: [UInt: (PinMode, PinPullState?)]) throws {
        self.hal = hal
        self.addressMap = addressMap
        for (key, (mode, pullState)) in addressMap {
            try self.hal.configure(at: key, mode: mode, pull: pullState)
        }
    }
    
    init(_ hal: H, addresses: [UInt], modes: [PinMode], pulls: [PinPullState?] = []) throws {
        let addressMap = Dictionary(uniqueKeysWithValues: zip(addresses, zip(modes, pulls)))
        try self.init(hal, addressMap: addressMap)
    }
    
    init(_ hal: H, pins: [Pin<H>]) {
        self.hal = hal
        self.addressMap = Dictionary(uniqueKeysWithValues: pins.map({ pin in
            (pin.address, (pin.mode, pin.pull))
        }))
    }
    
    public subscript(index: Int) -> Pin<H>? {
        let address = Array(addressMap.keys)[index]
        return try? self.pin(at: address)
    }
    
    func mode(at address: UInt) -> PinMode? {
        return addressMap[address]?.0
    }
    
    func pullState(at address: UInt) -> PinPullState? {
        return addressMap[address]?.1
    }
    
    func pin(at address: UInt) throws -> Pin<H> {
        return try Pin(from: self, address: address)
    }
}


extension Pin {
    fileprivate init(from pinSet: PinSet<H>, address: UInt) throws {
        self.hal = pinSet.hal
        self.address = address
        guard let (mode, pull) = pinSet.addressMap[address] else {
            throw DeviceError.notFound("Could not find address \(address) in the given addresses in the pin set")
        }
        self.mode = mode
        self.pull = pull
    }
}

