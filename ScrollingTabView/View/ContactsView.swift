//
//  ContactsView.swift
//  ScrollingTabView
//
//  Created by Zelyna Sillas on 11/27/23.
//

import SwiftUI

struct ContactsView: View {
    @ObservedObject var viewModel: ContactsViewModel
    
//    init() {
//        UITextField.appearance().clearButtonMode = .whileEditing
//    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Lists")
                    }
                }
                Spacer()
                    .frame(width: 280)
                
                Button {
                } label: {
                    Image(systemName: "plus")
                }
            }
            .padding(.bottom, 10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Contacts")
                    .font(.largeTitle).bold()
                
                HStack(alignment: .lastTextBaseline) {
                    Image(systemName: "magnifyingglass")
                    
                    TextField("Search", text: $viewModel.searchText)
                        .font(.callout)
                        .foregroundStyle(.primary)
                    
                    
                    Spacer()
                    
                    Image(systemName: "mic.fill")
                }
                .foregroundStyle(.gray)
                .padding(7)
                .background(.gray.opacity(0.15))
                .cornerRadius(10)
                
                
                Rectangle()
                    .fill(.gray.opacity(0.6))
                    .frame(height: 0.5)
            }
            
            contactsListView
                .overlay(alignment: .trailing) {
                    lettersView
                }
        }
        .padding(.horizontal)
    }
    
    var personalCard: some View {
        HStack(spacing: 15) {
            ZStack {
                Circle()
                    .fill(.gray.opacity(0.3))
                Text("Z")
                    .font(.largeTitle).bold()
                    .foregroundStyle(.white)
            }
            .frame(width: 70, height: 70)
            
            VStack(alignment: .leading) {
                Text("Zelyna Farrell")
                    .font(.title3)
                    .fontWeight(.medium)
                
                Text("My Card")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.vertical)
    }
    
    var contactsListView: some View {
        ScrollViewReader { value in
            ScrollView {
                personalCard
                LazyVStack(pinnedViews:[.sectionHeaders]) {
                    ForEach(viewModel.alphabet.filter{self.searchForSection($0)}, id: \.self) { letter in
                        Section(header: ContactsSectionHeaderView(text: letter)) {
                            ForEach(viewModel.contacts.filter{(country) -> Bool in country.name.prefix(1) == letter && self.searchForCountry(country.name) }) { country in
                                ContactItem(country: country)
                            }
                        }
                    }
                }
                .onChange(of: viewModel.selectedLetter) { old, new in
                    withAnimation {
                        viewModel.selectedLetter = new
                        value.scrollTo(viewModel.selectedLetter, anchor: .top)
                    }
                }
            }
        }
    }
    
    var lettersView: some View {
        VStack(alignment: .listRowSeparatorLeading, spacing: 2) {
            ForEach(viewModel.alphabet, id: \.self) { letter in
                Button {
                    withAnimation(.smooth) {
                        viewModel.selectedLetter = letter
                    }
                } label: {
                    Text(letter)
                        .font(.system(size: 12))
                        .contentShape(.rect)
                }
            }
        }
        .padding(.top)
    }
    
    private func searchForCountry(_ text: String) -> Bool {
        return (text.lowercased(with: .current).hasPrefix(viewModel.searchText.lowercased(with: .current)) || viewModel.searchText.isEmpty)
    }
    
    private func searchForSection(_ text: String) -> Bool {
        return (text.prefix(1).lowercased(with: .current).hasPrefix(viewModel.searchText.prefix(1).lowercased(with: .current)) || viewModel.searchText.isEmpty)
    }
}

#Preview {
    ContactsView(viewModel: ContactsViewModel())
}
