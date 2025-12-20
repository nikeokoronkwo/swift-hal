//
//  GPIORegister.swift
//  swift-hal
//
//  Created by Nikechukwu Okoronkwo on 12/19/25.
//
// GPIO Register Description
//
// Sourced from: https://datasheets.raspberrypi.com/bcm2711/bcm2711-peripherals.pdf
//
// ## FSEL
// 0b000: input, 0b001: output


import MMIO

let GPIO_BASE_ADDRESS: UInt = BASE_ADDRESS + 0x20_0000

@RegisterBlock
struct GPIO {
    @RegisterBlock(offset: 0x00)
    var gpfsel0: Register<GPFSEL0>
    
    @RegisterBlock(offset: 0x04)
    var gpfsel1: Register<GPFSEL1>
    
    @RegisterBlock(offset: 0x08)
    var gpfsel2: Register<GPFSEL2>
    
    @RegisterBlock(offset: 0x0c)
    var gpfsel3: Register<GPFSEL3>
    
    @RegisterBlock(offset: 0x10)
    var gpfsel4: Register<GPFSEL4>
    
    @RegisterBlock(offset: 0x14)
    var gpfsel5: Register<GPFSEL5>
    
    @RegisterBlock(offset: 0x1c)
    var gpset0: Register<GPSET0>
    
    @RegisterBlock(offset: 0x20)
    var gpset1: Register<GPSET1>
    
    @RegisterBlock(offset: 0x28)
    var gpclr0: Register<GPCLR0>
    
    @RegisterBlock(offset: 0x2c)
    var gpclr1: Register<GPCLR1>
    
    @RegisterBlock(offset: 0x34)
    var gplev0: Register<GPLEV0>
    
    @RegisterBlock(offset: 0x38)
    var gplev1: Register<GPLEV1>
}

@Register(bitWidth: 32)
struct GPFSEL0 {
    @ReadWrite(bits: 0..<3)
    var fsel00: FSEL00
    
    @ReadWrite(bits: 3..<6)
    var fsel01: FSEL01
    
    @ReadWrite(bits: 6..<9)
    var fsel02: FSEL02
    
    @ReadWrite(bits: 9..<12)
    var fsel03: FSEL03
    
    @ReadWrite(bits: 12..<15)
    var fsel04: FSEL04
    
    @ReadWrite(bits: 15..<18)
    var fsel05: FSEL05
    
    @ReadWrite(bits: 18..<21)
    var fsel06: FSEL06
    
    @ReadWrite(bits: 21..<24)
    var fsel07: FSEL07
    
    @ReadWrite(bits: 24..<27)
    var fsel08: FSEL08
    
    @ReadWrite(bits: 27..<30)
    var fsel09: FSEL09
}

@Register(bitWidth: 32)
struct GPFSEL1 {
    @ReadWrite(bits: 0..<3)
    var fsel10: FSEL10
    
    @ReadWrite(bits: 3..<6)
    var fsel11: FSEL11
    
    @ReadWrite(bits: 6..<9)
    var fsel12: FSEL12
    
    @ReadWrite(bits: 9..<12)
    var fsel13: FSEL13
    
    @ReadWrite(bits: 12..<15)
    var fsel14: FSEL14
    
    @ReadWrite(bits: 15..<18)
    var fsel15: FSEL15
    
    @ReadWrite(bits: 18..<21)
    var fsel16: FSEL16
    
    @ReadWrite(bits: 21..<24)
    var fsel17: FSEL17
    
    @ReadWrite(bits: 24..<27)
    var fsel18: FSEL18
    
    @ReadWrite(bits: 27..<30)
    var fsel19: FSEL19
}

@Register(bitWidth: 32)
struct GPFSEL2 {
    @ReadWrite(bits: 0..<3)
    var fsel20: FSEL20
    
    @ReadWrite(bits: 3..<6)
    var fsel21: FSEL21
    
    @ReadWrite(bits: 6..<9)
    var fsel22: FSEL22
    
    @ReadWrite(bits: 9..<12)
    var fsel23: FSEL23
    
    @ReadWrite(bits: 12..<15)
    var fsel24: FSEL24
    
    @ReadWrite(bits: 15..<18)
    var fsel25: FSEL25
    
    @ReadWrite(bits: 18..<21)
    var fsel26: FSEL26
    
    @ReadWrite(bits: 21..<24)
    var fsel27: FSEL27
    
    @ReadWrite(bits: 24..<27)
    var fsel28: FSEL28
    
    @ReadWrite(bits: 27..<30)
    var fsel29: FSEL29
}

@Register(bitWidth: 32)
struct GPFSEL3 {
    @ReadWrite(bits: 0..<3)
    var fsel30: FSEL30
    
    @ReadWrite(bits: 3..<6)
    var fsel31: FSEL31
    
    @ReadWrite(bits: 6..<9)
    var fsel32: FSEL32
    
    @ReadWrite(bits: 9..<12)
    var fsel33: FSEL33
    
    @ReadWrite(bits: 12..<15)
    var fsel34: FSEL34
    
    @ReadWrite(bits: 15..<18)
    var fsel35: FSEL35
    
    @ReadWrite(bits: 18..<21)
    var fsel36: FSEL36
    
    @ReadWrite(bits: 21..<24)
    var fsel37: FSEL37
    
    @ReadWrite(bits: 24..<27)
    var fsel38: FSEL38
    
    @ReadWrite(bits: 27..<30)
    var fsel39: FSEL39
}

@Register(bitWidth: 32)
struct GPFSEL4 {
    @ReadWrite(bits: 0..<3)
    var fsel40: FSEL40
    
    @ReadWrite(bits: 3..<6)
    var fsel41: FSEL41
    
    @ReadWrite(bits: 6..<9)
    var fsel42: FSEL42
    
    @ReadWrite(bits: 9..<12)
    var fsel43: FSEL43
    
    @ReadWrite(bits: 12..<15)
    var fsel44: FSEL44
    
    @ReadWrite(bits: 15..<18)
    var fsel45: FSEL45
    
    @ReadWrite(bits: 18..<21)
    var fsel46: FSEL46
    
    @ReadWrite(bits: 21..<24)
    var fsel47: FSEL47
    
    @ReadWrite(bits: 24..<27)
    var fsel48: FSEL48
    
    @ReadWrite(bits: 27..<30)
    var fsel49: FSEL49
}

@Register(bitWidth: 32)
struct GPFSEL5 {
    @ReadWrite(bits: 0..<3)
    var fsel50: FSEL50
    
    @ReadWrite(bits: 3..<6)
    var fsel51: FSEL51
    
    @ReadWrite(bits: 6..<9)
    var fsel52: FSEL52
    
    @ReadWrite(bits: 9..<12)
    var fsel53: FSEL53
    
    @ReadWrite(bits: 12..<15)
    var fsel54: FSEL54
    
    @ReadWrite(bits: 15..<18)
    var fsel55: FSEL55
    
    @ReadWrite(bits: 18..<21)
    var fsel56: FSEL56
    
    @ReadWrite(bits: 21..<24)
    var fsel57: FSEL57
}

@Register(bitWidth: 32)
struct GPSET0 {
    @WriteOnly(bits: 0..<1, as: Bool.self)
    var set00: SET00
    
    @WriteOnly(bits: 1..<2, as: Bool.self)
    var set01: SET01
    
    @WriteOnly(bits: 2..<3, as: Bool.self)
    var set02: SET02
    
    @WriteOnly(bits: 3..<4, as: Bool.self)
    var set03: SET03
    
    @WriteOnly(bits: 4..<5, as: Bool.self)
    var set04: SET04
    
    @WriteOnly(bits: 5..<6, as: Bool.self)
    var set05: SET05
    
    @WriteOnly(bits: 6..<7, as: Bool.self)
    var set06: SET06
    
    @WriteOnly(bits: 7..<8, as: Bool.self)
    var set07: SET07
    
    @WriteOnly(bits: 8..<9, as: Bool.self)
    var set08: SET08
    
    @WriteOnly(bits: 9..<10, as: Bool.self)
    var set09: SET09
    
    @WriteOnly(bits: 10..<11, as: Bool.self)
    var set10: SET10
    
    @WriteOnly(bits: 11..<12, as: Bool.self)
    var set11: SET11
    
    @WriteOnly(bits: 12..<13, as: Bool.self)
    var set12: SET12
    
    @WriteOnly(bits: 13..<14, as: Bool.self)
    var set13: SET13
    
    @WriteOnly(bits: 14..<15, as: Bool.self)
    var set14: SET14
    
    @WriteOnly(bits: 15..<16, as: Bool.self)
    var set15: SET15
    
    @WriteOnly(bits: 16..<17, as: Bool.self)
    var set16: SET16
    
    @WriteOnly(bits: 17..<18, as: Bool.self)
    var set17: SET17
    
    @WriteOnly(bits: 18..<19, as: Bool.self)
    var set18: SET18
    
    @WriteOnly(bits: 19..<20, as: Bool.self)
    var set19: SET19
    
    @WriteOnly(bits: 20..<21, as: Bool.self)
    var set20: SET20
    
    @WriteOnly(bits: 21..<22, as: Bool.self)
    var set21: SET21
    
    @WriteOnly(bits: 22..<23, as: Bool.self)
    var set22: SET22
    
    @WriteOnly(bits: 23..<24, as: Bool.self)
    var set23: SET23
    
    @WriteOnly(bits: 24..<25, as: Bool.self)
    var set24: SET24
    
    @WriteOnly(bits: 25..<26, as: Bool.self)
    var set25: SET25
    
    @WriteOnly(bits: 26..<27, as: Bool.self)
    var set26: SET26
    
    @WriteOnly(bits: 27..<28, as: Bool.self)
    var set27: SET27
    
    @WriteOnly(bits: 28..<29, as: Bool.self)
    var set28: SET28
    
    @WriteOnly(bits: 29..<30, as: Bool.self)
    var set29: SET29
    
    @WriteOnly(bits: 30..<31, as: Bool.self)
    var set30: SET30
    
    @WriteOnly(bits: 31..<32, as: Bool.self)
    var set31: SET31
}

@Register(bitWidth: 32)
struct GPSET1 {
    @WriteOnly(bits: 0..<1, as: Bool.self)
    var set32: SET32
    
    @WriteOnly(bits: 1..<2, as: Bool.self)
    var set33: SET33
    
    @WriteOnly(bits: 2..<3, as: Bool.self)
    var set34: SET34
    
    @WriteOnly(bits: 3..<4, as: Bool.self)
    var set35: SET35
    
    @WriteOnly(bits: 4..<5, as: Bool.self)
    var set36: SET36
    
    @WriteOnly(bits: 5..<6, as: Bool.self)
    var set37: SET37
    
    @WriteOnly(bits: 6..<7, as: Bool.self)
    var set38: SET38
    
    @WriteOnly(bits: 7..<8, as: Bool.self)
    var set39: SET39
    
    @WriteOnly(bits: 8..<9, as: Bool.self)
    var set40: SET40
    
    @WriteOnly(bits: 9..<10, as: Bool.self)
    var set41: SET41
    
    @WriteOnly(bits: 10..<11, as: Bool.self)
    var set42: SET42
    
    @WriteOnly(bits: 11..<12, as: Bool.self)
    var set43: SET43
    
    @WriteOnly(bits: 12..<13, as: Bool.self)
    var set44: SET44
    
    @WriteOnly(bits: 13..<14, as: Bool.self)
    var set45: SET45
    
    @WriteOnly(bits: 14..<15, as: Bool.self)
    var set46: SET46
    
    @WriteOnly(bits: 15..<16, as: Bool.self)
    var set47: SET47
    
    @WriteOnly(bits: 16..<17, as: Bool.self)
    var set48: SET48
    
    @WriteOnly(bits: 17..<18, as: Bool.self)
    var set49: SET49
    
    @WriteOnly(bits: 18..<19, as: Bool.self)
    var set50: SET50
    
    @WriteOnly(bits: 19..<20, as: Bool.self)
    var set51: SET51
    
    @WriteOnly(bits: 20..<21, as: Bool.self)
    var set52: SET52
    
    @WriteOnly(bits: 21..<22, as: Bool.self)
    var set53: SET53
    
    @WriteOnly(bits: 22..<23, as: Bool.self)
    var set54: SET54
    
    @WriteOnly(bits: 23..<24, as: Bool.self)
    var set55: SET55
    
    @WriteOnly(bits: 24..<25, as: Bool.self)
    var set56: SET56
    
    @WriteOnly(bits: 25..<26, as: Bool.self)
    var set57: SET57
}

@Register(bitWidth: 32)
struct GPCLR0 {
    @WriteOnly(bits: 0..<1, as: Bool.self)
    var clr00: CLR00
    
    @WriteOnly(bits: 1..<2, as: Bool.self)
    var clr01: CLR01
    
    @WriteOnly(bits: 2..<3, as: Bool.self)
    var clr02: CLR02
    
    @WriteOnly(bits: 3..<4, as: Bool.self)
    var clr03: CLR03
    
    @WriteOnly(bits: 4..<5, as: Bool.self)
    var clr04: CLR04
    
    @WriteOnly(bits: 5..<6, as: Bool.self)
    var clr05: CLR05
    
    @WriteOnly(bits: 6..<7, as: Bool.self)
    var clr06: CLR06
    
    @WriteOnly(bits: 7..<8, as: Bool.self)
    var clr07: CLR07
    
    @WriteOnly(bits: 8..<9, as: Bool.self)
    var clr08: CLR08
    
    @WriteOnly(bits: 9..<10, as: Bool.self)
    var clr09: CLR09
    
    @WriteOnly(bits: 10..<11, as: Bool.self)
    var clr10: CLR10
    
    @WriteOnly(bits: 11..<12, as: Bool.self)
    var clr11: CLR11
    
    @WriteOnly(bits: 12..<13, as: Bool.self)
    var clr12: CLR12
    
    @WriteOnly(bits: 13..<14, as: Bool.self)
    var clr13: CLR13
    
    @WriteOnly(bits: 14..<15, as: Bool.self)
    var clr14: CLR14
    
    @WriteOnly(bits: 15..<16, as: Bool.self)
    var clr15: CLR15
    
    @WriteOnly(bits: 16..<17, as: Bool.self)
    var clr16: CLR16
    
    @WriteOnly(bits: 17..<18, as: Bool.self)
    var clr17: CLR17
    
    @WriteOnly(bits: 18..<19, as: Bool.self)
    var clr18: CLR18
    
    @WriteOnly(bits: 19..<20, as: Bool.self)
    var clr19: CLR19
    
    @WriteOnly(bits: 20..<21, as: Bool.self)
    var clr20: CLR20
    
    @WriteOnly(bits: 21..<22, as: Bool.self)
    var clr21: CLR21
    
    @WriteOnly(bits: 22..<23, as: Bool.self)
    var clr22: CLR22
    
    @WriteOnly(bits: 23..<24, as: Bool.self)
    var clr23: CLR23
    
    @WriteOnly(bits: 24..<25, as: Bool.self)
    var clr24: CLR24
    
    @WriteOnly(bits: 25..<26, as: Bool.self)
    var clr25: CLR25
    
    @WriteOnly(bits: 26..<27, as: Bool.self)
    var clr26: CLR26
    
    @WriteOnly(bits: 27..<28, as: Bool.self)
    var clr27: CLR27
    
    @WriteOnly(bits: 28..<29, as: Bool.self)
    var clr28: CLR28
    
    @WriteOnly(bits: 29..<30, as: Bool.self)
    var clr29: CLR29
    
    @WriteOnly(bits: 30..<31, as: Bool.self)
    var clr30: CLR30
    
    @WriteOnly(bits: 31..<32, as: Bool.self)
    var clr31: CLR31
}

@Register(bitWidth: 32)
struct GPCLR1 {
    @WriteOnly(bits: 0..<1, as: Bool.self)
    var clr32: CLR32
    
    @WriteOnly(bits: 1..<2, as: Bool.self)
    var clr33: CLR33
    
    @WriteOnly(bits: 2..<3, as: Bool.self)
    var clr34: CLR34
    
    @WriteOnly(bits: 3..<4, as: Bool.self)
    var clr35: CLR35
    
    @WriteOnly(bits: 4..<5, as: Bool.self)
    var clr36: CLR36
    
    @WriteOnly(bits: 5..<6, as: Bool.self)
    var clr37: CLR37
    
    @WriteOnly(bits: 6..<7, as: Bool.self)
    var clr38: CLR38
    
    @WriteOnly(bits: 7..<8, as: Bool.self)
    var clr39: CLR39
    
    @WriteOnly(bits: 8..<9, as: Bool.self)
    var clr40: CLR40
    
    @WriteOnly(bits: 9..<10, as: Bool.self)
    var clr41: CLR41
    
    @WriteOnly(bits: 10..<11, as: Bool.self)
    var clr42: CLR42
    
    @WriteOnly(bits: 11..<12, as: Bool.self)
    var clr43: CLR43
    
    @WriteOnly(bits: 12..<13, as: Bool.self)
    var clr44: CLR44
    
    @WriteOnly(bits: 13..<14, as: Bool.self)
    var clr45: CLR45
    
    @WriteOnly(bits: 14..<15, as: Bool.self)
    var clr46: CLR46
    
    @WriteOnly(bits: 15..<16, as: Bool.self)
    var clr47: CLR47
    
    @WriteOnly(bits: 16..<17, as: Bool.self)
    var clr48: CLR48
    
    @WriteOnly(bits: 17..<18, as: Bool.self)
    var clr49: CLR49
    
    @WriteOnly(bits: 18..<19, as: Bool.self)
    var clr50: CLR50
    
    @WriteOnly(bits: 19..<20, as: Bool.self)
    var clr51: CLR51
    
    @WriteOnly(bits: 20..<21, as: Bool.self)
    var clr52: CLR52
    
    @WriteOnly(bits: 21..<22, as: Bool.self)
    var clr53: CLR53
    
    @WriteOnly(bits: 22..<23, as: Bool.self)
    var clr54: CLR54
    
    @WriteOnly(bits: 23..<24, as: Bool.self)
    var clr55: CLR55
    
    @WriteOnly(bits: 24..<25, as: Bool.self)
    var clr56: CLR56
    
    @WriteOnly(bits: 25..<26, as: Bool.self)
    var clr57: CLR57
}

@Register(bitWidth: 32)
struct GPLEV0 {
    @ReadOnly(bits: 0..<1, as: Bool.self)
    var lev00: LEV00
    
    @ReadOnly(bits: 1..<2, as: Bool.self)
    var lev01: LEV01
    
    @ReadOnly(bits: 2..<3, as: Bool.self)
    var lev02: LEV02
    
    @ReadOnly(bits: 3..<4, as: Bool.self)
    var lev03: LEV03
    
    @ReadOnly(bits: 4..<5, as: Bool.self)
    var lev04: LEV04
    
    @ReadOnly(bits: 5..<6, as: Bool.self)
    var lev05: LEV05
    
    @ReadOnly(bits: 6..<7, as: Bool.self)
    var lev06: LEV06
    
    @ReadOnly(bits: 7..<8, as: Bool.self)
    var lev07: LEV07
    
    @ReadOnly(bits: 8..<9, as: Bool.self)
    var lev08: LEV08
    
    @ReadOnly(bits: 9..<10, as: Bool.self)
    var lev09: LEV09
    
    @ReadOnly(bits: 10..<11, as: Bool.self)
    var lev10: LEV10
    
    @ReadOnly(bits: 11..<12, as: Bool.self)
    var lev11: LEV11
    
    @ReadOnly(bits: 12..<13, as: Bool.self)
    var lev12: LEV12
    
    @ReadOnly(bits: 13..<14, as: Bool.self)
    var lev13: LEV13
    
    @ReadOnly(bits: 14..<15, as: Bool.self)
    var lev14: LEV14
    
    @ReadOnly(bits: 15..<16, as: Bool.self)
    var lev15: LEV15
    
    @ReadOnly(bits: 16..<17, as: Bool.self)
    var lev16: LEV16
    
    @ReadOnly(bits: 17..<18, as: Bool.self)
    var lev17: LEV17
    
    @ReadOnly(bits: 18..<19, as: Bool.self)
    var lev18: LEV18
    
    @ReadOnly(bits: 19..<20, as: Bool.self)
    var lev19: LEV19
    
    @ReadOnly(bits: 20..<21, as: Bool.self)
    var lev20: LEV20
    
    @ReadOnly(bits: 21..<22, as: Bool.self)
    var lev21: LEV21
    
    @ReadOnly(bits: 22..<23, as: Bool.self)
    var lev22: LEV22
    
    @ReadOnly(bits: 23..<24, as: Bool.self)
    var lev23: LEV23
    
    @ReadOnly(bits: 24..<25, as: Bool.self)
    var lev24: LEV24
    
    @ReadOnly(bits: 25..<26, as: Bool.self)
    var lev25: LEV25
    
    @ReadOnly(bits: 26..<27, as: Bool.self)
    var lev26: LEV26
    
    @ReadOnly(bits: 27..<28, as: Bool.self)
    var lev27: LEV27
    
    @ReadOnly(bits: 28..<29, as: Bool.self)
    var lev28: LEV28
    
    @ReadOnly(bits: 29..<30, as: Bool.self)
    var lev29: LEV29
    
    @ReadOnly(bits: 30..<31, as: Bool.self)
    var lev30: LEV30
    
    @ReadOnly(bits: 31..<32, as: Bool.self)
    var lev31: LEV31
}

@Register(bitWidth: 32)
struct GPLEV1 {
    @ReadOnly(bits: 0..<1, as: Bool.self)
    var lev32: LEV32
    
    @ReadOnly(bits: 1..<2, as: Bool.self)
    var lev33: LEV33
    
    @ReadOnly(bits: 2..<3, as: Bool.self)
    var lev34: LEV34
    
    @ReadOnly(bits: 3..<4, as: Bool.self)
    var lev35: LEV35
    
    @ReadOnly(bits: 4..<5, as: Bool.self)
    var lev36: LEV36
    
    @ReadOnly(bits: 5..<6, as: Bool.self)
    var lev37: LEV37
    
    @ReadOnly(bits: 6..<7, as: Bool.self)
    var lev38: LEV38
    
    @ReadOnly(bits: 7..<8, as: Bool.self)
    var lev39: LEV39
    
    @ReadOnly(bits: 8..<9, as: Bool.self)
    var lev40: LEV40
    
    @ReadOnly(bits: 9..<10, as: Bool.self)
    var lev41: LEV41
    
    @ReadOnly(bits: 10..<11, as: Bool.self)
    var lev42: LEV42
    
    @ReadOnly(bits: 11..<12, as: Bool.self)
    var lev43: LEV43
    
    @ReadOnly(bits: 12..<13, as: Bool.self)
    var lev44: LEV44
    
    @ReadOnly(bits: 13..<14, as: Bool.self)
    var lev45: LEV45
    
    @ReadOnly(bits: 14..<15, as: Bool.self)
    var lev46: LEV46
    
    @ReadOnly(bits: 15..<16, as: Bool.self)
    var lev47: LEV47
    
    @ReadOnly(bits: 16..<17, as: Bool.self)
    var lev48: LEV48
    
    @ReadOnly(bits: 17..<18, as: Bool.self)
    var lev49: LEV49
    
    @ReadOnly(bits: 18..<19, as: Bool.self)
    var lev50: LEV50
    
    @ReadOnly(bits: 19..<20, as: Bool.self)
    var lev51: LEV51
    
    @ReadOnly(bits: 20..<21, as: Bool.self)
    var lev52: LEV52
    
    @ReadOnly(bits: 21..<22, as: Bool.self)
    var lev53: LEV53
    
    @ReadOnly(bits: 22..<23, as: Bool.self)
    var lev54: LEV54
    
    @ReadOnly(bits: 23..<24, as: Bool.self)
    var lev55: LEV55
    
    @ReadOnly(bits: 24..<25, as: Bool.self)
    var lev56: LEV56
    
    @ReadOnly(bits: 25..<26, as: Bool.self)
    var lev57: LEV57
}

let gpio = GPIO(unsafeAddress: GPIO_BASE_ADDRESS)
