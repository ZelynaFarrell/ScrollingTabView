//
//  ContentView.swift
//  ScrollingTabView
//
//  Created by Zelyna Sillas on 11/13/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) private var scheme
    @State private var selectedTab: Tab? = .all
    @State private var tabProgress: CGFloat = 0
    @StateObject var viewModel = ContactsViewModel()
    
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some View {
        VStack {
            
            GeometryReader {
                let size = $0.size
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 0) {
                        FavoritesView()
                            .id(Tab.favorites)
                            .containerRelativeFrame(.horizontal)
                        
                        RecentsView()
                            .id(Tab.recents)
                            .containerRelativeFrame(.horizontal)
                        
                        ContactsView(viewModel: viewModel)
                            .id(Tab.all)
                            .containerRelativeFrame(.horizontal)
                        
                        KeypadView()
                            .id(Tab.keypad)
                            .containerRelativeFrame(.horizontal)
                        
                        VoicemailView()
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
}

#Preview {
    ContentView()
}
