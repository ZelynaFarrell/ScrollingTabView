//
//  ContentView.swift
//  ScrollingTabView
//
//  Created by Zelyna Sillas on 11/13/23.
//

import SwiftUI

// MAP ALPHABET TO DATA. REFER TO SSTACK OVERFLOW THEN UPDATE COMPUTED PROPERTY IN VIEWMODEL.
// remove init for textfield if possible
//REFACTOR CODE

struct ContentView: View {
    @Environment(\.colorScheme) private var scheme
    @State private var selectedTab: Tab? = .all
    @State private var tabProgress: CGFloat = 0
    @StateObject var viewModel = CountryViewModel()
    
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
  
    
    @State private var selectedOption = "All"
    var options = ["All", "Missed"]
    
    var body: some View {
            VStack {
                
                GeometryReader {
                    let size = $0.size
                    
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 0) {
                            FavoritesView()
                                .id(Tab.favorites)
                                .containerRelativeFrame(.horizontal)
                            
//                            Text("RecentsView()")
                            RecentsView()
                                .id(Tab.recents)
                                .containerRelativeFrame(.horizontal)
                            
                            
                           ContactsView()
//                            Text("Voicemail")
                                .id(Tab.all)
                                .containerRelativeFrame(.horizontal)
                              
                            
                            KeypadView()
//                            Text("Voicemail")
                                .id(Tab.keypad)
                                .containerRelativeFrame(.horizontal)
                            
                            VoicemailView()
//                            Text("Voicemail")
                                .id(Tab.voicemail)
                                .containerRelativeFrame(.horizontal)
                        }
                        .scrollTargetLayout()
                        .offsetX { value in
                            let progress = -value / (size.width * CGFloat(Tab.allCases.count - 1))
                            
                            tabProgress = max(min(progress, 1), 0)
                        }
                    }
                    .scrollPosition(id: $selectedTab)
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.paging)
                    .scrollClipDisabled()
                }
                
                CustomTabBar()
            }
            .background(.gray.opacity(0.1))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

    }
    
    @ViewBuilder
    func CustomTabBar()-> some View {
        HStack(spacing: 5) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                VStack(spacing: 5) {
                    Image(systemName: tab.systemImage)
                    
                    
                    Text(tab.rawValue)
                        .font(.footnote)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .contentShape(.capsule)
                .onTapGesture {
                    withAnimation(.snappy) {
                        selectedTab = tab
                    }
                }
            }
        }
        .tabMask(tabProgress)
        .background {
            GeometryReader {
                let size = $0.size
                let capsuleWidth = size.width / CGFloat(Tab.allCases.count)
                
                Capsule()
                    .fill(scheme == .dark ? .black : .white)
                    .frame(width: capsuleWidth)
                    .offset(x: tabProgress * (size.width - capsuleWidth))
            }
        }
        .background(.gray.opacity(0.1), in: .capsule)
        .padding(.horizontal, 5)
    }
    
    @ViewBuilder
    func ContactsView()-> some View {
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
    
    
     var contactsListView: some View {
         ScrollViewReader { value in
             ScrollView {
                 personalCard
                 LazyVStack(pinnedViews:[.sectionHeaders]) {
                   
                     ForEach(viewModel.alphabet, id: \.self) { letter in
                         Section(header: ContactsSectionHeaderView(text: letter)) {
                             ForEach(viewModel.filteredSearch)
                             //                                .filter{(country) -> Bool in country.name.prefix(1) == letter && searchForCountry(country.name)}
                             //                                     , id: \.id)
                             { country in
                                 CountryItemView(country: country)
                             }
                         }
                     }
                 }
              
                 .onChange(of: viewModel.selectedLetter) { old, new in
                     withAnimation {
                         viewModel.selectedLetter = new
                         value.scrollTo(viewModel.selectedLetter, anchor: .topLeading)
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
    
     func searchForCountry(_ txt: String) -> Bool {
         return (txt.lowercased(with: .current).hasPrefix(viewModel.searchText.lowercased(with: .current)) || viewModel.searchText.isEmpty)
     }
    
    @ViewBuilder
    func FavoritesView()-> some View {
        VStack {
            HStack {
                Button {
                } label: {
                    Image(systemName: "plus")
                }
                .frame(width: 250)
              
                
                Text("Favorites").bold()
            }
            .offset(x: -130, y: -310)
           
           
            
            Text("No Favorites")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
        }
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

    
    @ViewBuilder
    func RecentsView()-> some View {
        VStack {
            HStack(spacing: 50) {
                Spacer()
                    .frame(width: 45)
                Button {
                } label: {
                    Picker("picker", selection: $selectedOption) {
                        ForEach(options, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .frame(width: 140)
                
                Button {
                } label: {
                    Text("Edit")
                }
            
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Recents")
                    .font(.largeTitle).bold()
                
                Rectangle()
                    .fill(.gray.opacity(0.6))
                    .frame(height: 0.5)
            }
            
            HStack {
                VStack {
                    Text("Name")
                        .font(.headline)
                    
                    Text("mobile")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                
                Text("08:04")
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                Button {
                } label: {
                    Image(systemName: "info.circle")
                        .font(.title2)
                }
               
            }
            Divider()
            
            Spacer()
        }
        .frame(alignment: .top)
        .padding(.horizontal, 18)
    }
    
    @ViewBuilder
    func VoicemailView()-> some View {
        VStack {
            HStack {
                Button {} label: { Text("Greeting") }
              
                Spacer()
                
                Button {} label: { Text("Edit") }
            }
            .padding(.bottom, 10)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Voicemail")
                    .font(.largeTitle).bold()
                
                Rectangle()
                    .fill(.gray.opacity(0.6))
                    .frame(height: 0.5)
            }
            
            HStack {
                VStack {
                    Text("Name")
                        .font(.headline)
                    
                    Text("mobile")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("11/1/23")
                    Text("02:45")
                        .foregroundStyle(.secondary)
                }
                .font(.subheadline)
                
                Button {} label: { Image(systemName: "info.circle") }
                    .font(.title2)
                    .padding(.horizontal, 8)
               
            }
            Divider()
            
            Spacer()
        }
        .frame(alignment: .top)
        .padding(.horizontal, 18)
    }
    
}

#Preview {
    ContentView()
}
