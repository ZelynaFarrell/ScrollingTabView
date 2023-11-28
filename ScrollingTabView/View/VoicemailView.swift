//
//  VoicemailView.swift
//  ScrollingTabView
//
//  Created by Zelyna Sillas on 11/27/23.
//

import SwiftUI

struct VoicemailView: View {
    var body: some View {
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
    VoicemailView()
}
