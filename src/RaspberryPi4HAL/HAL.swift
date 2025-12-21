//
//  HAL.swift
//  swift-hal
//
//  Created by Nikechukwu Okoronkwo on 12/19/25.
//

import HAL

class RaspberryPi4BHAL: HAL, IOCapable {
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
    

    func configure(at: UInt, mode: Pin.Mode) throws {
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
    }
    
    func resetIO(at: UInt) throws {
        // noop
    }
}

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
    
    private func performBitSetLev(at: UInt) throws -> Bool {
        if at >= 32 {
            let value = gpio_26.gplev1.read()
            return try value.lev1.get(Int(at) - 32) != 0
        } else {
            let value = gpio_26.gplev0.read()
            return try value.lev0.get(Int(at)) != 0
        }
    }
}

