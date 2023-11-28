//
//  ContactsViewModel.swift
//  ScrollingTabView
//
//  Created by Zelyna Sillas on 11/27/23.
//

import Foundation

class ContactsViewModel: ObservableObject {
    @Published var contacts = [Country]()
    @Published var searchText = ""
    @Published var selectedLetter = "A"
    
    let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W", "X","Y", "Z", "#"]
    
    init() {
        loadCountries()
    }
    
    func loadCountries(){
        let countryCodesPath = Bundle.main.path(forResource: "CountryCodes", ofType: "json")!
        
        do {
            let fileCountryCodes = try? String(contentsOfFile: countryCodesPath).data(using: .utf8)!
            let decoder = JSONDecoder()
            contacts = try decoder.decode([Country].self, from: fileCountryCodes!)
        }
        catch {
            print(error)
        }
    }
}
