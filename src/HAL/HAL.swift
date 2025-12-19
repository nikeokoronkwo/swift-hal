

/// # The Hardware Abstraction Layer
/// A HAL (Hardware Abstraction Layer) is an interface that separates hardware-specific software code (like memory mapping)
class HAL {
    /// The device identifier
    let id: StaticString

    /// Resets the HAL
    func reset() throws {}

    init(id: StaticString) {
        self.id = id
    }
}

/// A base protocol for defining HAL capabilities that can be used to augment the base HAL interface.
///
/// A HAL capability defines a set of extensions that can allow a base HAL to be able to access
/// and work with certain drivers and peripherals, including IO interfaces, bluetooth, WiFi, Clock,
/// 
protocol HALCapability: HAL {}

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
protocol IOCapable: HALCapability {
    /// Reads data available at a given pin. Returns a ``Bool`` representing the given value
    func read(at: UInt) throws -> Bool

    /// Writes data to a given pin. Returns a ``Bool`` representing the given value
    func write(at: UInt, value: Bool) throws

    /// Configures a given pin to be set for the given mode
    func configure(at: UInt, mode: Pin.Mode) throws

    /// Reset a given pin to be set for a given mode
    func resetIO(at: UInt) throws
}

extension IOCapable {
    /// Creates an I/O Pin that can be used to read/write to by other applications
    func pin(address: UInt, mode: Pin.Mode) throws -> Pin {
        try Pin(self, address: address, mode: mode)
    }
    
    /// Creates an I/O PinSet, which represents a set of pins used for reading/writing to multiple pins at the same time
    func pinset(addresses: [UInt], modes: [Pin.Mode]) throws -> PinSet {
        try PinSet(self, addresses: addresses, modes: modes)
    }
}

protocol ClockCapable: HALCapability {}

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

