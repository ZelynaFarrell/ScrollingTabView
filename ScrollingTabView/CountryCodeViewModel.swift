//
//  CountryCodeViewModel.swift
//  ScrollingTabView
//
//  Created by Zelyna Sillas on 11/18/23.
//

import Foundation

class CountryViewModel: ObservableObject {
    @Published var countries = [CountryModel]()
    @Published var searchText = ""
    @Published var selectedLetter = "A"
    
    let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W", "X","Y", "Z", "#"]
    
    var filteredSearch: [CountryModel] {
        guard !searchText.isEmpty else { return countries }
        return countries
//            .filter { country in
//           country.name.lowercased().contains(searchText.lowercased())
//        }
    }
    
    init() {
        loadCountries()
    }
    
    func loadCountries(){
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
