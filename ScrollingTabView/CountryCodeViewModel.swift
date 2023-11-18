//
//  CountryCodeViewModel.swift
//  ScrollingTabView
//
//  Created by Zelyna Sillas on 11/18/23.
//

import Foundation

class CountryCodeViewModel: ObservableObject {
    var countries = [CountryModel]()
//    let sections = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
//    @Published var countryCodeNumber = ""
//    @Published var country = ""
//    @Published var code = ""
    
    init() {
        loadCountryCodes()
    }
    
    func loadCountryCodes(){
        let countryCodesPath = Bundle.main.path(forResource: "CountryCodes", ofType: "json")!
        
        do {
            let fileCountryCodes = try? String(contentsOfFile: countryCodesPath).data(using: .utf8)!
            let decoder = JSONDecoder()
            countries = try decoder.decode([CountryModel].self, from: fileCountryCodes!)
        }
        catch {
            print(error)
        }
    }
}
