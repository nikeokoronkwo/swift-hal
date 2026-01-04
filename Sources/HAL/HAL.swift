/// # The Hardware Abstraction Layer
/// A HAL (Hardware Abstraction Layer) is an interface that separates hardware-specific software code (like memory mapping)
open class HAL {
    /// The device identifier
    let id: StaticString

    /// Resets the HAL
    func reset() throws {}

    init(id: StaticString) {
        self.id = id
    }
}

public enum HALError: Error {
    case unknownAddress(String, addr: UInt)
    case unknown(String)
    case unsupported(String)
}

/// A base protocol for defining HAL capabilities that can be used to augment the base HAL interface.
///
/// A HAL capability defines a set of extensions that can allow a base HAL to be able to access
/// and work with certain drivers and peripherals, including IO interfaces, bluetooth, WiFi, Clock,
///
/// Users can define custom capabilites for ``HAL`` implementations only.
public protocol HALCapability: HAL {}

/// A HAL Capability that adds the ability to be able to read and write from external I/O (input/output) interfaces
/// 
/// This means being able to read and write raw data, either in the form of voltages or 1/0 to external I/O pins
/// The HAL is responsible for being able to map addresses to actual physical addresses (MMIO)
///
/// A simple use case for this is being able to interface with GPIO (General Purpose I/O), present in many microcontrollers like the RP2040
///
/// > For most of the interfaces described here, when dealing with boolean values, unless specified, `true` represents a high value (1), while `false` represents a low value (0).
///
/// For certain workflows, functions are available to configure, read and write to given pins at once. For most workflows, it is recommended to use ``withPin`` (if you plan on using the pin only once), or just `.pin` to get a `Pin` object which can be used in different device scenarios
///
/// For most of the functions here, a ``UInt``
public protocol IOCapable: HALCapability {
    /// Reads data available at a given pin. Returns a ``Bool`` representing the given value
    func read(at: UInt) throws -> Bool

    /// Writes data to a given pin. Returns a ``Bool`` representing the given value
    func write(at: UInt, value: Bool) throws

    /// Configures a given pin to be set for the given mode
    func configure(at: UInt, mode: PinMode, pull: PinPullState?) throws

    /// Reset a given pin to be set for a given mode
    func resetIO(at: UInt) throws
    
    /// Reads data from multiple pins at a given time. Returns a map mapping pin numbers to their respective values
    func readAll(at: [UInt]) throws -> [UInt: Bool]
    
    /// Writes data to multiple pins at a given time
    func writeAll(map: [UInt: Bool]) throws
}

public extension IOCapable {
    /// Creates an I/O Pin that can be used to read/write to by other applications
    func pin(address: UInt, mode: PinMode, pull: PinPullState? = nil) throws -> Pin<Self> {
        try Pin(self, address: address, mode: mode, pull: pull)
    }
    
    /// Creates an I/O PinSet, which represents a set of pins used for reading/writing to multiple pins at the same time
    func pinset(addresses: [UInt], modes: [PinMode], pulls: [PinPullState?] = []) throws -> PinSet<Self> {
        try PinSet(self, addresses: addresses, modes: modes)
    }
    
    /// Creates a pin to be used for collective operations
    func withPin<R, E>(address: UInt, mode: PinMode, _ closure: (Pin<Self>) throws(E) -> R) throws -> R {
        let pin = try Pin(self, address: address, mode: mode)
        let result = try closure(pin)
        try resetIO(at: address)
        return result
    }
    
    /// Creates a pinset to be used for collective operations
    func withPinset<R, E>(addressMap: [UInt: (PinMode, PinPullState?)], _ closure: (PinSet<Self>) throws(E) -> R) throws -> R {
        let pinset = try PinSet(self, addressMap: addressMap)
        let result = try closure(pinset)
        try addressMap.forEach { (key: UInt, _) in
            try resetIO(at: key)
        }
        return result
    }
}

/// A HAL Capability that adds support for performing asynchronous I/O operations
///
/// This is different from an asynchronous API for ``IOCapable``, which can be done by making calls to the APIs in ``IOCapable`` asynchronous.
/// This protocol, however, provides asynchronous access to I/O state, for instance, like watching for edge changes.
///
/// Most of the APIs here may require polling on the implementation end, and polling ranges/accuracy and latencies are up to the user implementing this protocol
public protocol AsyncIOCapable: IOCapable {
    /// Returns a stream which can listen to changes in the level of the pin, returning
    /// - ``Pin.LevelState.high`` whenever the pin level goes high, and
    /// - ``Pin.LevelState.low`` whenever the pin level goes low
    ///
    /// The stream can be listened to for changes in the pin level
    func pinLevelState(at address: UInt) throws -> AsyncStream<PinLevelState>
    
    /// Returns a stream which can listen to changes in the edge of the pin state, returning
    /// - ``Pin.EdgeState.rise`` when a rising edge is detected, and
    /// - ``Pin.EdgeState.fall`` when a falling edge is detected
    func pinEdgeState(at address: UInt) throws -> AsyncStream<PinEdgeState>
}

/// A HAL Capability that adds support for basic timing functionality, either through a system timer or a system clock
///
/// This allows for some measurement of time and duration in the hardware device
public protocol ClockCapable: HALCapability {
    /// Get the frequency the HAL runs its clock/timer on, in Hertz
    static var frequency: Float { get }
    
    /// Get the number of microseconds since the HAL device booted as a `Double` precision floating-point number
    func timeSinceBoot() throws -> Double
}

@available(macOS 15.0, *)
public extension ClockCapable {
    func durationSinceBoot() throws -> Duration {
        let seconds = try timeSinceBoot()
        let attoseconds = Int128(seconds * 1_000_000_000_000.0)
        return Duration(attoseconds: attoseconds)
    }
}

protocol TimerCapable: HALCapability {}

protocol NetworkCapable: HALCapability {}

protocol BluetoothCapable: NetworkCapable {}

protocol WirelessCapable: NetworkCapable {}

protocol EthernetCapable: NetworkCapable {}

/// A HAL Capability that adds the ability to read and manage the device's power supply.
///
/// This can allow for being able to detect battery level, battery wattage/voltage, and others.
/// The functions that can be used here are dependent on the implementation.
protocol PowerManageable: NetworkCapable {}

protocol ADCCapable: IOCapable {}

protocol DACCapable: IOCapable {}

protocol I2CCapable: IOCapable {}

protocol UARTCapable: HALCapability {}

protocol PWMCapable: HALCapability {}

protocol SPICapable: HALCapability {}

protocol GPUAugmentable: HALCapability {}

protocol USBCapable: HALCapability {}

