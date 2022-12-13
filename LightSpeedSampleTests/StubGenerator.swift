//
//  StubGenerator.swift
//  LightSpeedSampleTests
//
//  Created by Ritu on 2022-12-10.
//

import XCTest
@testable import LightSpeedSample

class StubGenerator {
    
    func stubPhotos(fileName: String = "Data") -> [Photos] {
        let decoder = JSONDecoder()
        do{
            let data = try fromJSON(fileName: fileName)
            do{
                return try decoder.decode([Photos].self, from: data)
            }catch{
                return [Photos]()
            }
        }catch{
            return [Photos]()
        }

    }
    
    func fromJSON(fileName: String) throws -> Data {
        let bundle = Bundle(for: type(of: self))
        do{
        let url = try XCTUnwrap(bundle.url(forResource: fileName, withExtension: "json"))
        print(url)
        return try Data(contentsOf: url)
        }catch{
            print(error.localizedDescription)
        }
        return Data()

    }
}

