//
//  Test.swift
//  swift-hal
//
//  Created by Nikechukwu Okoronkwo on 12/21/25.
//

import Testing
@testable import HAL

struct FixedBitSetTest {
    
    @Test func testBitCount() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let testCases = [
            0b0001101: (ones: 3, 7),
            0b0001001: (ones: 2, 7),
            0b0001111: (ones: 4, 7),
            0b0101101: (ones: 4, 7),
            0b1111101: (ones: 6, 7),
            0b0100001: (ones: 2, 7)
        ]
        
        for (bits, caseInfo) in testCases {
            let bitset = FixedBitSet<7>(bits)
            #expect(bitset.count == caseInfo.1)
        }
    }
}
