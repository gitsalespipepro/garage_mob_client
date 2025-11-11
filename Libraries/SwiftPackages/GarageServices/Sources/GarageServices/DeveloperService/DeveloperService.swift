//
//  AccountService.swift
//  
//
//  Created by Rezo Joglidze on 11.11.25.
//

import GarageModels
import GarageBackend

struct DeveloperServiceURLs {
    static let iOSDevs =  "https://gist.githubusercontent.com/rezojoglidze/d51dff6a9c0cb78f64bf37a2e8f31edd/raw/a9c80aa4941f1b7e1251b05108670331f4bf518f/iOS_Devs"
   }

protocol DeveloperService {
    func fetchDevelopers() async throws -> [GetDevelopersResponseModel]
}

final class DeveloperServiceImpl {
    
    let coreService: CoreService
    
    public init(coreService: CoreService) {
        self.coreService = coreService
    }
}

extension DeveloperServiceImpl: DeveloperService {
    func fetchDevelopers() async throws -> [GetDevelopersResponseModel] {
        let url = DeveloperServiceURLs.iOSDevs
        
        // if we want to pass query: fetchDevelopers(model: Type) {
//        let query = (try? model.propertyValueEncodedTuples())?
//            .map { QueryParameter(name: $0.property, value: $0.value) }
        
        return try await coreService.request(
            url: url,
            method: .get,
            headers: nil,
            query: query,
            body: nil,
            encoding: .urlEncoding
        ).responseDecodable()
    }
}
