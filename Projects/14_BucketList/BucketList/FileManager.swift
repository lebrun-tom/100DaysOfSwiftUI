//
//  FileManager.swift
//  Moonshot
//
//  Created by Tom LEBRUN on 31/10/2022.
//

import Foundation

extension FileManager {
    private func getDocumentsDirectory() -> URL {
        let paths = self.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func encode<T: Encodable>(_ input: T, to file: String) {
        let url = getDocumentsDirectory().appendingPathComponent(file)
        let encoder = JSONEncoder()

        do {
            let data = try encoder.encode(input)
            let jsonString = String(decoding: data, as: UTF8.self)
            try jsonString.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            fatalError("Failed to write to Documents \(error.localizedDescription)")
        }
    }

    func decode<T: Decodable>(_ type: T.Type,
                              from file: String,
                              dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
    ) -> T {
        let url = getDocumentsDirectory().appendingPathComponent(file)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            let data = try Data(contentsOf: url)
            let loaded = try decoder.decode(T.self, from: data)
            return loaded
        } catch {
            fatalError("Failed to decode \(file) from directory \(error.localizedDescription)")
        }
    }
}
