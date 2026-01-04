//
//  HAL.swift
//  swift-hal
//
//  Created by Nikechukwu Okoronkwo on 12/19/25.
//

import HAL

class RaspberryPi4BHAL: HAL {
    
}

// MARK: Raspberry Pi 4B IO Capabilities
extension RaspberryPi4BHAL: IOCapable {
    func read(at: UInt) throws -> Bool {
        // assert this is GPLEV address
        guard at <= 57 else {
            throw HALError.unknownAddress("The given value is an invalid GPIO pin address", addr: at)
        }
        
        if #available(macOS 26.0.0, *) {
            return try performBitSetLev(at: at)
        } else {
            return try performExhaustiveRead(at: at)
        }
    }
    

    func write(at: UInt, value: Bool) throws {
        // assert this is either GPCLR (value = 0) or GPSET (value = 1)
        guard at <= 57 else {
            throw HALError.unknownAddress("The given value is an invalid GPIO pin address", addr: at)
        }
        
        if value {
            if #available(macOS 26.0.0, *) {
                performBitSetSet(at: at)
            } else {
                performExhaustiveSet(at: at)
            }
        } else {
            if #available(macOS 26.0.0, *) {
                performBitSetClr(at: at)
            } else {
                performExhaustiveClear(at: at)
            }
        }
    }
    
    func readAll(at: [UInt]) throws -> [UInt : Bool] {
        guard at.allSatisfy({ v in
            return v <= 57
        }) else {
            throw HALError.unknown("There is at least one invalid address provided")
        }
        
        if #available(macOS 26.0.0, *) {
            return try performBitSetLev(at: at)
        } else {
            var output: [UInt: Bool] = [:]
            for addr in at {
                output[addr] = try performExhaustiveRead(at: addr)
            }
            return output
        }
    }
    
    func writeAll(map: [UInt : Bool]) throws {
        guard map.keys.allSatisfy({ v in
            return v <= 57
        }) else {
            throw HALError.unknown("There is at least one invalid address provided")
        }
        
        if #available(macOS 26.0.0, *) {
            var sets: [UInt] = []
            var clrs: [UInt] = []
            
            for (addr, value) in map {
                if value {
                    sets.append(addr)
                } else {
                    clrs.append(addr)
                }
            }
            
            performBitSetSet(at: sets)
            performBitSetClr(at: clrs)
        } else {
            map.forEach { (key: UInt, value: Bool) in
                if value {
                    performExhaustiveSet(at: key)
                } else {
                    performExhaustiveClear(at: key)
                }
            }
        }
    }
    

    func configure(at: UInt, mode: PinMode, pull: PinPullState) throws {
        // assert this is GPFSEL address
        guard at <= 57 else {
            throw HALError.unknownAddress("The given value is an invalid GPIO pin address", addr: at)
        }
        
        var rawMode: UInt32
        switch mode {
        case .input:
            rawMode = 0b000
        case .output:
            rawMode = 0b001
        case .inputOutput:
            throw HALError.unsupported("Raspberry Pi 4B does not support both IO")
        }
        
        // configure pin state
        switch at / 10 {
        case 0:
            gpio.gpfsel0.write { writer in
                switch at {
                case 0:
                    writer.raw.fsel00 = rawMode
                case 1:
                    writer.raw.fsel01 = rawMode
                case 2:
                    writer.raw.fsel02 = rawMode
                case 3:
                    writer.raw.fsel03 = rawMode
                case 4:
                    writer.raw.fsel04 = rawMode
                case 5:
                    writer.raw.fsel05 = rawMode
                case 6:
                    writer.raw.fsel06 = rawMode
                case 7:
                    writer.raw.fsel07 = rawMode
                case 8:
                    writer.raw.fsel08 = rawMode
                case 9:
                    writer.raw.fsel09 = rawMode
                default: break
                }
            }
        case 1:
            gpio.gpfsel1.write { writer in
                switch at {
                case 10:
                    writer.raw.fsel10 = rawMode
                case 11:
                    writer.raw.fsel11 = rawMode
                case 12:
                    writer.raw.fsel12 = rawMode
                case 13:
                    writer.raw.fsel13 = rawMode
                case 14:
                    writer.raw.fsel14 = rawMode
                case 15:
                    writer.raw.fsel15 = rawMode
                case 16:
                    writer.raw.fsel16 = rawMode
                case 17:
                    writer.raw.fsel17 = rawMode
                case 18:
                    writer.raw.fsel18 = rawMode
                case 19:
                    writer.raw.fsel19 = rawMode
                default: break
                }
            }
        case 2:
            gpio.gpfsel2.write { writer in
                switch at {
                case 20:
                    writer.raw.fsel20 = rawMode
                case 21:
                    writer.raw.fsel21 = rawMode
                case 22:
                    writer.raw.fsel22 = rawMode
                case 23:
                    writer.raw.fsel23 = rawMode
                case 24:
                    writer.raw.fsel24 = rawMode
                case 25:
                    writer.raw.fsel25 = rawMode
                case 26:
                    writer.raw.fsel26 = rawMode
                case 27:
                    writer.raw.fsel27 = rawMode
                case 28:
                    writer.raw.fsel28 = rawMode
                case 29:
                    writer.raw.fsel29 = rawMode
                default: break
                }
            }
        case 3:
            gpio.gpfsel3.write { writer in
                switch at {
                case 30:
                    writer.raw.fsel30 = rawMode
                case 31:
                    writer.raw.fsel31 = rawMode
                case 32:
                    writer.raw.fsel32 = rawMode
                case 33:
                    writer.raw.fsel33 = rawMode
                case 34:
                    writer.raw.fsel34 = rawMode
                case 35:
                    writer.raw.fsel35 = rawMode
                case 36:
                    writer.raw.fsel36 = rawMode
                case 37:
                    writer.raw.fsel37 = rawMode
                case 38:
                    writer.raw.fsel38 = rawMode
                case 39:
                    writer.raw.fsel39 = rawMode
                default: break
                }
            }
        case 4:
            gpio.gpfsel4.write { writer in
                switch at {
                case 40:
                    writer.raw.fsel40 = rawMode
                case 41:
                    writer.raw.fsel41 = rawMode
                case 42:
                    writer.raw.fsel42 = rawMode
                case 43:
                    writer.raw.fsel43 = rawMode
                case 44:
                    writer.raw.fsel44 = rawMode
                case 45:
                    writer.raw.fsel45 = rawMode
                case 46:
                    writer.raw.fsel46 = rawMode
                case 47:
                    writer.raw.fsel47 = rawMode
                case 48:
                    writer.raw.fsel48 = rawMode
                case 49:
                    writer.raw.fsel49 = rawMode
                default: break
                }
            }
        case 5:
            gpio.gpfsel5.write { writer in
                switch at {
                case 50:
                    writer.raw.fsel50 = rawMode
                case 51:
                    writer.raw.fsel51 = rawMode
                case 52:
                    writer.raw.fsel52 = rawMode
                case 53:
                    writer.raw.fsel53 = rawMode
                case 54:
                    writer.raw.fsel54 = rawMode
                case 55:
                    writer.raw.fsel55 = rawMode
                case 56:
                    writer.raw.fsel56 = rawMode
                case 57:
                    writer.raw.fsel57 = rawMode
                default: break
                }
            }
        default:
            throw HALError.unknown("We should handle new address at this point, but it isn't")
        }
        
        // configure internal resistor pull
        var rawPull: UInt32
        switch pull {
        case .none:
            rawPull = 0b00
        case .pullUp:
            rawPull = 0b01
        case .pullDown:
            rawPull = 0b10
        }
        
        switch at / 16 {
        case 0:
            gpio.gpio_pup_pdn_cntrl_reg0.write { writer in
                switch at {
                case 0:  writer.raw.gpio_pup_pdn_cntrl_reg00 = rawPull
                case 1:  writer.raw.gpio_pup_pdn_cntrl_reg01 = rawPull
                case 2:  writer.raw.gpio_pup_pdn_cntrl_reg02 = rawPull
                case 3:  writer.raw.gpio_pup_pdn_cntrl_reg03 = rawPull
                case 4:  writer.raw.gpio_pup_pdn_cntrl_reg04 = rawPull
                case 5:  writer.raw.gpio_pup_pdn_cntrl_reg05 = rawPull
                case 6:  writer.raw.gpio_pup_pdn_cntrl_reg06 = rawPull
                case 7:  writer.raw.gpio_pup_pdn_cntrl_reg07 = rawPull
                case 8:  writer.raw.gpio_pup_pdn_cntrl_reg08 = rawPull
                case 9:  writer.raw.gpio_pup_pdn_cntrl_reg09 = rawPull
                case 10: writer.raw.gpio_pup_pdn_cntrl_reg0A = rawPull
                case 11: writer.raw.gpio_pup_pdn_cntrl_reg0B = rawPull
                case 12: writer.raw.gpio_pup_pdn_cntrl_reg0C = rawPull
                case 13: writer.raw.gpio_pup_pdn_cntrl_reg0D = rawPull
                case 14: writer.raw.gpio_pup_pdn_cntrl_reg0E = rawPull
                case 15: writer.raw.gpio_pup_pdn_cntrl_reg0F = rawPull
                default: break
                }
            }
        case 1:
            gpio.gpio_pup_pdn_cntrl_reg1.write { writer in
                switch at {
                case 16: writer.raw.gpio_pup_pdn_cntrl_reg10 = rawPull
                case 17: writer.raw.gpio_pup_pdn_cntrl_reg11 = rawPull
                case 18: writer.raw.gpio_pup_pdn_cntrl_reg12 = rawPull
                case 19: writer.raw.gpio_pup_pdn_cntrl_reg13 = rawPull
                case 20: writer.raw.gpio_pup_pdn_cntrl_reg14 = rawPull
                case 21: writer.raw.gpio_pup_pdn_cntrl_reg15 = rawPull
                case 22: writer.raw.gpio_pup_pdn_cntrl_reg16 = rawPull
                case 23: writer.raw.gpio_pup_pdn_cntrl_reg17 = rawPull
                case 24: writer.raw.gpio_pup_pdn_cntrl_reg18 = rawPull
                case 25: writer.raw.gpio_pup_pdn_cntrl_reg19 = rawPull
                case 26: writer.raw.gpio_pup_pdn_cntrl_reg1A = rawPull
                case 27: writer.raw.gpio_pup_pdn_cntrl_reg1B = rawPull
                case 28: writer.raw.gpio_pup_pdn_cntrl_reg1C = rawPull
                case 29: writer.raw.gpio_pup_pdn_cntrl_reg1D = rawPull
                case 30: writer.raw.gpio_pup_pdn_cntrl_reg1E = rawPull
                case 31: writer.raw.gpio_pup_pdn_cntrl_reg1F = rawPull
                default: break
                }
            }
        case 2:
            gpio.gpio_pup_pdn_cntrl_reg2.write { writer in
                switch at {
                case 32: writer.raw.gpio_pup_pdn_cntrl_reg20 = rawPull
                case 33: writer.raw.gpio_pup_pdn_cntrl_reg21 = rawPull
                case 34: writer.raw.gpio_pup_pdn_cntrl_reg22 = rawPull
                case 35: writer.raw.gpio_pup_pdn_cntrl_reg23 = rawPull
                case 36: writer.raw.gpio_pup_pdn_cntrl_reg24 = rawPull
                case 37: writer.raw.gpio_pup_pdn_cntrl_reg25 = rawPull
                case 38: writer.raw.gpio_pup_pdn_cntrl_reg26 = rawPull
                case 39: writer.raw.gpio_pup_pdn_cntrl_reg27 = rawPull
                case 40: writer.raw.gpio_pup_pdn_cntrl_reg28 = rawPull
                case 41: writer.raw.gpio_pup_pdn_cntrl_reg29 = rawPull
                case 42: writer.raw.gpio_pup_pdn_cntrl_reg2A = rawPull
                case 43: writer.raw.gpio_pup_pdn_cntrl_reg2B = rawPull
                case 44: writer.raw.gpio_pup_pdn_cntrl_reg2C = rawPull
                case 45: writer.raw.gpio_pup_pdn_cntrl_reg2D = rawPull
                case 46: writer.raw.gpio_pup_pdn_cntrl_reg2E = rawPull
                case 47: writer.raw.gpio_pup_pdn_cntrl_reg2F = rawPull
                default: break
                }
            }
        case 3:
            gpio.gpio_pup_pdn_cntrl_reg3.write { writer in
                switch at {
                case 48: writer.raw.gpio_pup_pdn_cntrl_reg30 = rawPull
                case 49: writer.raw.gpio_pup_pdn_cntrl_reg31 = rawPull
                case 50: writer.raw.gpio_pup_pdn_cntrl_reg32 = rawPull
                case 51: writer.raw.gpio_pup_pdn_cntrl_reg33 = rawPull
                case 52: writer.raw.gpio_pup_pdn_cntrl_reg34 = rawPull
                case 53: writer.raw.gpio_pup_pdn_cntrl_reg35 = rawPull
                case 54: writer.raw.gpio_pup_pdn_cntrl_reg36 = rawPull
                case 55: writer.raw.gpio_pup_pdn_cntrl_reg37 = rawPull
                case 56: writer.raw.gpio_pup_pdn_cntrl_reg38 = rawPull
                case 57: writer.raw.gpio_pup_pdn_cntrl_reg39 = rawPull
                default: break
                }
            }
        default:
            break
        }
    }
    
    func resetIO(at: UInt) throws {
        // noop
    }
}

// MARK: Raspberry Pi 4B Clock Capability
extension RaspberryPi4BHAL: ClockCapable {
    static var frequency: Float {
        1_000_000
    }
    
    func timeSinceBoot() throws -> Double {
        var hi1, hi2: UInt32
        var low: UInt32
        repeat {
            hi1 = systemTimer.chi.read().raw.cnt
            low = systemTimer.clo.read().raw.cnt
            hi2 = systemTimer.chi.read().raw.cnt
        } while (hi1 != hi2);
        
        return Double(hi1 << 32 | low)
    }
}

// MARK: Internal Functionality
extension RaspberryPi4BHAL {
    /// Uses the GPIO SETn operation to perform an exhaustive set on all possible pins
    private func performExhaustiveSet(at: UInt) {
        if at >= 32 {
            gpio.gpset1.write { write in
                switch at {
                case 32: write.set32 = true
                case 33: write.set33 = true
                case 34: write.set34 = true
                case 35: write.set35 = true
                case 36: write.set36 = true
                case 37: write.set37 = true
                case 38: write.set38 = true
                case 39: write.set39 = true
                case 40: write.set40 = true
                case 41: write.set41 = true
                case 42: write.set42 = true
                case 43: write.set43 = true
                case 44: write.set44 = true
                case 45: write.set45 = true
                case 46: write.set46 = true
                case 47: write.set47 = true
                case 48: write.set48 = true
                case 49: write.set49 = true
                case 50: write.set50 = true
                case 51: write.set51 = true
                case 52: write.set52 = true
                case 53: write.set53 = true
                case 54: write.set54 = true
                case 55: write.set55 = true
                case 56: write.set56 = true
                case 57: write.set57 = true
                default:
                    break
                }
            }
        } else {
            gpio.gpset0.write { write in
                switch at {
                case 0:  write.set00 = true
                case 1:  write.set01 = true
                case 2:  write.set02 = true
                case 3:  write.set03 = true
                case 4:  write.set04 = true
                case 5:  write.set05 = true
                case 6:  write.set06 = true
                case 7:  write.set07 = true
                case 8:  write.set08 = true
                case 9:  write.set09 = true
                case 10: write.set10 = true
                case 11: write.set11 = true
                case 12: write.set12 = true
                case 13: write.set13 = true
                case 14: write.set14 = true
                case 15: write.set15 = true
                case 16: write.set16 = true
                case 17: write.set17 = true
                case 18: write.set18 = true
                case 19: write.set19 = true
                case 20: write.set20 = true
                case 21: write.set21 = true
                case 22: write.set22 = true
                case 23: write.set23 = true
                case 24: write.set24 = true
                case 25: write.set25 = true
                case 26: write.set26 = true
                case 27: write.set27 = true
                case 28: write.set28 = true
                case 29: write.set29 = true
                case 30: write.set30 = true
                case 31: write.set31 = true
                default:
                    break
                }
            }
        }
    }
    
    /// Uses the GPIO CLRn operation to perform an exhaustive clear on all possible pins
    private func performExhaustiveClear(at: UInt) {
        if at >= 32 {
            gpio.gpclr1.write { write in
                switch at {
                case 32: write.clr32 = true
                case 33: write.clr33 = true
                case 34: write.clr34 = true
                case 35: write.clr35 = true
                case 36: write.clr36 = true
                case 37: write.clr37 = true
                case 38: write.clr38 = true
                case 39: write.clr39 = true
                case 40: write.clr40 = true
                case 41: write.clr41 = true
                case 42: write.clr42 = true
                case 43: write.clr43 = true
                case 44: write.clr44 = true
                case 45: write.clr45 = true
                case 46: write.clr46 = true
                case 47: write.clr47 = true
                case 48: write.clr48 = true
                case 49: write.clr49 = true
                case 50: write.clr50 = true
                case 51: write.clr51 = true
                case 52: write.clr52 = true
                case 53: write.clr53 = true
                case 54: write.clr54 = true
                case 55: write.clr55 = true
                case 56: write.clr56 = true
                case 57: write.clr57 = true
                default:
                    break
                }
            }
        } else {
            gpio.gpclr0.write { write in
                switch at {
                case 0:  write.clr00 = true
                case 1:  write.clr01 = true
                case 2:  write.clr02 = true
                case 3:  write.clr03 = true
                case 4:  write.clr04 = true
                case 5:  write.clr05 = true
                case 6:  write.clr06 = true
                case 7:  write.clr07 = true
                case 8:  write.clr08 = true
                case 9:  write.clr09 = true
                case 10: write.clr10 = true
                case 11: write.clr11 = true
                case 12: write.clr12 = true
                case 13: write.clr13 = true
                case 14: write.clr14 = true
                case 15: write.clr15 = true
                case 16: write.clr16 = true
                case 17: write.clr17 = true
                case 18: write.clr18 = true
                case 19: write.clr19 = true
                case 20: write.clr20 = true
                case 21: write.clr21 = true
                case 22: write.clr22 = true
                case 23: write.clr23 = true
                case 24: write.clr24 = true
                case 25: write.clr25 = true
                case 26: write.clr26 = true
                case 27: write.clr27 = true
                case 28: write.clr28 = true
                case 29: write.clr29 = true
                case 30: write.clr30 = true
                case 31: write.clr31 = true
                default:
                    break
                }
            }
        }
    }
    
    /// Uses the GPIO LEVn operation to perform an exhaustive read on the level at all possible pins
    private func performExhaustiveRead(at: UInt) throws(HALError) -> Bool {
        if at >= 32 {
            let read = gpio.gplev1.read()
            switch at {
            case 32: return read.lev32
            case 33: return read.lev33
            case 34: return read.lev34
            case 35: return read.lev35
            case 36: return read.lev36
            case 37: return read.lev37
            case 38: return read.lev38
            case 39: return read.lev39
            case 40: return read.lev40
            case 41: return read.lev41
            case 42: return read.lev42
            case 43: return read.lev43
            case 44: return read.lev44
            case 45: return read.lev45
            case 46: return read.lev46
            case 47: return read.lev47
            case 48: return read.lev48
            case 49: return read.lev49
            case 50: return read.lev50
            case 51: return read.lev51
            case 52: return read.lev52
            case 53: return read.lev53
            case 54: return read.lev54
            case 55: return read.lev55
            case 56: return read.lev56
            case 57: return read.lev57
            default:
                throw HALError.unknownAddress("No value at the given address", addr: at)
            }
        } else {
            let read = gpio.gplev0.read()
            switch at {
            case 0:  return read.lev00
            case 1:  return read.lev01
            case 2:  return read.lev02
            case 3:  return read.lev03
            case 4:  return read.lev04
            case 5:  return read.lev05
            case 6:  return read.lev06
            case 7:  return read.lev07
            case 8:  return read.lev08
            case 9:  return read.lev09
            case 10: return read.lev10
            case 11: return read.lev11
            case 12: return read.lev12
            case 13: return read.lev13
            case 14: return read.lev14
            case 15: return read.lev15
            case 16: return read.lev16
            case 17: return read.lev17
            case 18: return read.lev18
            case 19: return read.lev19
            case 20: return read.lev20
            case 21: return read.lev21
            case 22: return read.lev22
            case 23: return read.lev23
            case 24: return read.lev24
            case 25: return read.lev25
            case 26: return read.lev26
            case 27: return read.lev27
            case 28: return read.lev28
            case 29: return read.lev29
            case 30: return read.lev30
            case 31: return read.lev31
            default:
                throw HALError.unknownAddress("No value at the given address", addr: at)
            }
        }
    }
    
}

@available(macOS 26.0.0, *)
extension RaspberryPi4BHAL {
    private func performBitSetSet(at: UInt) {
        // TODO: Convert to normal write that can throw
        if at >= 32 {
            gpio_26.gpset1.write { write in
                var fixedbitset = FixedBitSet<26>()
                try? fixedbitset.set(Int(at) - 32, 1)
                write.set1 = fixedbitset
            }
        } else {
            gpio_26.gpset0.write { write in
                var fixedbitset = FixedBitSet<32>()
                try? fixedbitset.set(Int(at), 1)
                write.set0 = fixedbitset
            }
        }
    }
    
    private func performBitSetSet(at addresses: [UInt]) {
        var below32Addr: [Int] = []
        var geq32Addr: [Int] = []
        
        for address in addresses {
            if address >= 32 {
                geq32Addr.append(Int(address) - 32 )
            } else {
                below32Addr.append(Int(address))
            }
        }
        
        if !below32Addr.isEmpty {
            gpio_26.gpset0.write { write in
                var fixedbitset = FixedBitSet<32>()
                try? fixedbitset.setAll(1, at: below32Addr)
                write.set0 = fixedbitset
            }
        }
        
        if !geq32Addr.isEmpty {
            gpio_26.gpset1.write { write in
                var fixedbitset = FixedBitSet<26>()
                try? fixedbitset.setAll(1, at: geq32Addr)
                write.set1 = fixedbitset
            }
        }
    }
    
    private func performBitSetClr(at: UInt) {
        if at >= 32 {
            gpio_26.gpclr1.write { write in
                var fixedbitset = FixedBitSet<26>()
                try? fixedbitset.set(Int(at) - 32, 1)
                write.clr1 = fixedbitset
            }
        } else {
            gpio_26.gpclr0.write { write in
                var fixedbitset = FixedBitSet<32>()
                try? fixedbitset.set(Int(at), 1)
                write.clr0 = fixedbitset
            }
        }
    }
    
    private func performBitSetClr(at addresses: [UInt]) {
        var below32Addr: [Int] = []
        var geq32Addr: [Int] = []
        
        for address in addresses {
            if address >= 32 {
                geq32Addr.append(Int(address) - 32 )
            } else {
                below32Addr.append(Int(address))
            }
        }
        
        if !below32Addr.isEmpty {
            gpio_26.gpclr0.write { write in
                var fixedbitset = FixedBitSet<32>()
                try? fixedbitset.setAll(1, at: below32Addr)
                write.clr0 = fixedbitset
            }
        }
        
        if !geq32Addr.isEmpty {
            gpio_26.gpclr1.write { write in
                var fixedbitset = FixedBitSet<26>()
                try? fixedbitset.setAll(1, at: geq32Addr)
                write.clr1 = fixedbitset
            }
        }
    }
    
    private func performBitSetLev(at: UInt) throws -> Bool {
        if at >= 32 {
            let value = gpio_26.gplev1.read()
            return try value.lev1.get(Int(at) - 32) != 0
        } else {
            let value = gpio_26.gplev0.read()
            return try value.lev0.get(Int(at)) != 0
        }
    }
    
    private func performBitSetLev(at addresses: [UInt]) throws -> [UInt: Bool] {
        return Dictionary(uniqueKeysWithValues: try addresses.map { addr in
            if addr >= 32 {
                let value = gpio_26.gplev1.read().lev1
                return (addr, try value.get(Int(addr) - 32) != 0)
            } else {
                let value = gpio_26.gplev0.read().lev0
                return (addr, try value.get(Int(addr)) != 0)
            }
        })
    }
}

