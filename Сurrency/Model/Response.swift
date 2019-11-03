//
//  Response.swift
//  Сurrency
//
//  Created by Алексей Евменьков on 9/8/19.
//  Copyright © 2019 MyCompany. All rights reserved.
//

import Foundation


struct Response: Codable {
    let usd_byn: Double?
    
    
    enum CodingKeys: String, CodingKey {
        case usd_byn = "USD_BYN"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(usd_byn, forKey: .usd_byn)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        usd_byn = try container.decode(Double.self, forKey: .usd_byn)
    }
    
}
