//
//  ContentView.swift
//  ScrollingTabView
//
//  Created by Zelyna Sillas on 11/13/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab? = .keypad
    @Environment(\.colorScheme) private var scheme
    @State private var tabProgress: CGFloat = 0
    @State private var searchText = ""
    
    let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W", "X","Y", "Z", "#"]
    
    private var gridItemLayout = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
                 ]
    
    var body: some View {
        NavigationStack {
            VStack {
                Rectangle()
                    .fill(.gray.opacity(0.6))
                    .frame(height: 0.5)
                    .padding(.horizontal, 18)
                
                GeometryReader {
                    let size = $0.size
                    
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 0) {
                            Text("Favorites")
                                .id(Tab.favorites)
                                .containerRelativeFrame(.horizontal)
                            
                            Text("Recents")
                                .id(Tab.recents)
                                .containerRelativeFrame(.horizontal)
                            
                           ContactsView()
                                .id(Tab.all)
                                .containerRelativeFrame(.horizontal)
                            
                            KeypadView()
                                .id(Tab.keypad)
                                .containerRelativeFrame(.horizontal)
                            
                            Text("Voicemail")
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
            .navigationTitle("Contacts")
            .searchable(text: $searchText)
            .toolbar {
                Button {
                } label: {
                    Image(systemName: "plus")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
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
        HStack {
            VStack {
                ScrollView(.vertical) {
                    ForEach(alphabet, id: \.self) { letter in
                            Text(letter)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 5)
                        Divider()
                        
                    }
                }
            }
            .padding(.horizontal, 20)
            .overlay {
                VStack(alignment: .listRowSeparatorLeading, spacing: 2) {
                    ForEach(alphabet, id: \.self) { letter in
                        Button {
                        } label: {
                            Text(letter)
                                .font(.system(size: 12))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 14)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func KeypadView()-> some View {
        ZStack {
            LazyVGrid(columns: gridItemLayout) {
                ForEach(1...9, id: \.self) { n in
                    ZStack {
                        Circle()
                            .fill(.gray.opacity(0.3))
                            .frame(width: 90, height: 90)
                        
                        
                        Text("\(n)")
                            .font(.largeTitle)
                            .padding(.top, 3)
                        if n != 1 {
                            Text("A")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
