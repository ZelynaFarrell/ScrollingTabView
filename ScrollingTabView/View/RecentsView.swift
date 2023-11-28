//
//  RecentsView.swift
//  ScrollingTabView
//
//  Created by Zelyna Sillas on 11/27/23.
//

import SwiftUI

struct RecentsView: View {
    @State private var selectedOption = "All"
    var options = ["All", "Missed"]
    
    var body: some View {
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
}

#Preview {
    RecentsView()
}
