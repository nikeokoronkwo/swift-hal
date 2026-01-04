public protocol Device {
    associatedtype UnderlyingHAL: HAL
}


enum DeviceError: Error {
    case notFound(String)
}
