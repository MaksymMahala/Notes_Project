//
//  ModelCode.swift
//  Notes
//
//  Created by Maksym on 23.11.2023.
//
import Foundation
import Combine

struct Model: Codable{
    var name: String
    var type: String
    var muscle: String
    var equipment: String
    var difficulty: String
    var instructions: String
}

class APICodeReceive{
//    sDQAQ6Fo1iogsWoZGU3aBwobqvnpzt8cgwdcb3Sy57ywqjQtANGZx45qm7xQ
    func loadAPI(comletition: @escaping ([Model]) -> Void, muscle: String!){
        var cancellables = Set<AnyCancellable>()
        let url = URL(string: "https://api.api-ninjas.com/v1/exercises?muscle="+muscle!)!
        var request = URLRequest(url: url)
        request.setValue("eyLV+qyW3kAk8MbNMZ82cQ==SK4bNvlH61kAzNRd", forHTTPHeaderField: "X-Api-Key")
        request.httpMethod = "GET"
        
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
        
            .tryMap{ (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else{
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Model].self, decoder: JSONDecoder())
            .sink{ (comletition) in
                print("Completition \(comletition)")
            }receiveValue: { [weak self] (newValue) in
                comletition(newValue)
                print(newValue)
            }
            .store(in: &cancellables)
    }
    
}
