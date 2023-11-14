//
//  ContentView.swift
//  ScrollingTabView
//
//  Created by Zelyna Sillas on 11/13/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab?
    @Environment(\.colorScheme) private var scheme
    @State private var tabProgress: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 15) {
            
            HStack {
                Button {
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                }
                
                Spacer()
                
                Text("Contacts")
                    .font(.title3).bold()
                
                Spacer()
                
                Button {
                } label: {
                    Image(systemName: "bell.badge")
                }
            }
            .font(.title2)
            .foregroundStyle(.primary)
            .padding([.horizontal, .top], 18)
            .padding(.bottom, 5)
            
            CustomTabBar()
            
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.gray.opacity(0.1))
    }
    @ViewBuilder
    func CustomTabBar()-> some View {
        HStack(spacing: 5) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                HStack(spacing: 5) {
                    Image(systemName: tab.systemImage)
                    
                    Text(tab.rawValue)
                        .font(.body)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
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
        .padding(.horizontal, 6)
    }
}

#Preview {
    ContentView()
}
