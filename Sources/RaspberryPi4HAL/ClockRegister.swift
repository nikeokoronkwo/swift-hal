//
//  ClockRegister.swift
//  swift-hal
//
//  Created by Nikechukwu Okoronkwo on 12/26/25.
//
import MMIO

/// 0x7e003000
let SYSTEM_TIMER_BASE_ADDRESS: UInt = BASE_ADDRESS + 0x3000

/// IGNORED:
/// - CS (0x00, W1C)
/// - Cx (0x0c to 0x10, stride: 0x04, RW)
@RegisterBlock
struct SYSTEM_TIMER {
    @RegisterBlock(offset: 0x04)
    var clo: Register<CLO>
    
    @RegisterBlock(offset: 0x08)
    var chi: Register<CHI>
}

@Register(bitWidth: 32)
struct CLO {
    @ReadOnly(bits: 0..<32)
    var cnt: CNT
}

@Register(bitWidth: 32)
struct CHI {
    @ReadOnly(bits: 0..<32)
    var cnt: CNT
}


let systemTimer = SYSTEM_TIMER(unsafeAddress: SYSTEM_TIMER_BASE_ADDRESS)
