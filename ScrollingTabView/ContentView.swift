//
//  ContentView.swift
//  ScrollingTabView
//
//  Created by Zelyna Sillas on 11/13/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab? = .all
    @Environment(\.colorScheme) private var scheme
    @State private var tabProgress: CGFloat = 0
    @State private var searchShown = false
    @State private var searchText = ""
    
    let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W", "X","Y", "Z", "#"]
    
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
                    
                    TextField("Search", text: $searchText)
                        .font(.callout)
                    
                    
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
            
            HStack {
                VStack {
                    ScrollView(.vertical) {
                        
                        HStack(spacing: 15) {
                            Circle()
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
                        
                        ForEach(alphabet, id: \.self) { letter in
                            
                            VStack(alignment: .leading) {
                                Section {
                                    Text("Name")
                                    Divider()
                                } header: {
                                    Text(letter)
                                        .font(.footnote).bold()
                                        .foregroundStyle(.gray)
                                    Divider()
                                }
                            }
                            
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .overlay {
                    VStack(alignment: .listRowSeparatorLeading, spacing: 2) {
                        ForEach(alphabet, id: \.self) { letter in
                            Button {
                            } label: {
                                Text(letter)
                                    .font(.system(size: 12))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 6)
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
        .onAppear {
            searchShown = true
        }
        .onDisappear {
            searchShown = false
        }
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
