//
//  KeypadView.swift
//  ScrollingTabView
//
//  Created by Zelyna Sillas on 11/17/23.
//

import SwiftUI

struct KeypadView: View {
    private var gridItemLayout = [GridItem(.fixed(100)), GridItem(.fixed(100)), GridItem(.fixed(100))]
    
    let keypadContent = ["1" : "",
                  "2" : "A B C",
                  "3" : "D E F",
                  "4" : "G H I",
                  "5" : "J K L",
                  "6" : "M N O",
                  "7" : "P Q R S",
                  "8" : "T U V",
                  "9": "W X Y Z"]
    let keypadBottomKeys = ["*", "0", "#"]
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 30)
            
            LazyVGrid(columns: gridItemLayout) {
                ForEach(keypadContent.sorted(by: <), id: \.key) { key, value in
                    Button {
                    } label: {
                        ZStack {
                            Circle()
                                .fill(.gray.opacity(0.3))
                                .frame(width: 80, height: 80)
                            
                            VStack(spacing: 0) {
                                Text(key)
                                    .font(.title)
                                    .padding(.top, 3)
                                
                                Text(value)
                                    .font(.footnote)
                            }
                        }
                    }
                }
                
                ForEach(keypadBottomKeys, id: \.self) { key in
                    Button {
                    } label: {
                        ZStack {
                            Circle()
                                .fill(.gray.opacity(0.3))
                                .frame(width: 90, height: 90)
                            
                            VStack(spacing: 0) {
                                Text(key)
                                    .font(key == "*" ? .system(size: 60) : .title)
                                    .padding(.top, key == "*" ? 20 : 0)
                                    .fontWeight(key == "*" ? .light : .regular)
                                
                                if key == "0" {
                                    Text("+")
                                        .padding(.top, -8)
                                }
                            }
                        }
                    }
                }
            }
            
            Button {
            } label: {
                ZStack {
                    Circle()
                        .fill(.green)
                        .frame(width: 80, height: 80)
                    
                    
                    Image(systemName: "phone.fill")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                }
                .padding(.top, 10)
            }
        }
        .foregroundStyle(.primary)
    }
}

#Preview {
    KeypadView()
}
