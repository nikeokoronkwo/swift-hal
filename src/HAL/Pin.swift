/// An I/O Pin
///
/// An I/O Pin is a peripheral device with which digital signals can be written and read to
///
/// Most pins are exclusively either used for input (reading data/signals) or output (writing data/signals). However, because architectures may differ, we do not assert that pins may be one or the other.
struct Pin {
    unowned fileprivate let hal: IOCapable
    
    /// The memory mapped address where the given pin is located
    // TODO: Memory safety address
    let address: UInt

    /// The type of pin present (input or output)
    ///
    /// For more information about pin modes, see ``Pin.Mode``
    let mode: Pin.Mode

    init(_ hal: IOCapable, address: UInt, mode: Pin.Mode = .inputOutput) throws {
        self.hal = hal
        self.address = address
        self.mode = mode

        try hal.configure(at: address, mode: mode)
    }

    /// Sets a pin's output to high (value 1)
    func on() throws {
        guard mode.isOutput else {
            throw Pin.Error.wrongMode(mode, expected: .output)
        }
        try hal.write(at: self.address, value: true)
    }

    /// Sets a pin's output to low (value 0)
    func off() throws {
        guard mode.isOutput else {
            throw Pin.Error.wrongMode(mode, expected: .output)
        }
        try hal.write(at: self.address, value: false)
    }

    /// Get the value of an input
    var value: Bool {
        get throws {
            guard mode.isInput else {
                throw Pin.Error.wrongMode(mode, expected: .input)
            }
            return try hal.read(at: self.address)
        }
    }
}

/// A set of pins, which can be used to work on pin I/O operations on multiple I/O points at the same time, without having to manage each individual pin
struct PinSet {
    unowned fileprivate let hal: IOCapable
    
    /// The set of addresses referred to by the given pin set
    let addressMap: [UInt: Pin.Mode]
    
    init(_ hal: IOCapable, addresses: [UInt], modes: [Pin.Mode]) throws {
        self.hal = hal
        self.addressMap = Dictionary(uniqueKeysWithValues: zip(addresses, modes))
        for (key, value) in addressMap {
            try self.hal.configure(at: key, mode: value)
        }
    }
    
    init(_ hal: IOCapable, pins: [Pin]) {
        self.hal = hal
        self.addressMap = Dictionary(uniqueKeysWithValues: pins.map({ pin in
            (pin.address, pin.mode)
        }))
    }
    
    subscript(address: UInt) -> Pin? {
        return try? self.pin(at: address)
    }
    
    func mode(at address: UInt) -> Pin.Mode? {
        return addressMap[address]
    }
    
    func pin(at address: UInt) throws -> Pin {
        return try Pin(from: self, address: address)
    }
}


extension Pin {
    fileprivate init(from pinSet: PinSet, address: UInt) throws {
        self.hal = pinSet.hal
        self.address = address
        guard let mode = pinSet.mode(at: address) else {
            throw DeviceError.notFound("Could not find address \(address) in the given addresses in the pin set")
        }
        self.mode = mode
    }
    
    enum Mode {
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
    
    enum Error {
        case wrongMode(Mode, expected: Mode)
    }
}

extension Pin.Error: Error {}
