//
//  RecentsView.swift
//  ScrollingTabView
//
//  Created by Zelyna Sillas on 11/17/23.
//

//import SwiftUI
//
//struct RecentsView: View {
//    @State private var selectedOption = "All"
//    var options = ["All", "Missed"]
//    
//    var body: some View {
//        ZStack {
//            Rectangle()
//                .fill(.clear)
//                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//                .ignoresSafeArea()
//                
//            VStack {
//                Text("Recents")
//            
//            }
////            .toolbar {
////                ToolbarItem(placement: .principal) {
////                    Button {
////                    } label: {
////                        Picker("picker", selection: $selectedOption) {
////                            ForEach(options, id: \.self) {
////                                Text($0)
////                            }
////                        }
////                        .pickerStyle(.segmented)
////                    }
////                }
////                ToolbarItem(placement: .topBarTrailing) {
////                    Button {
////                    } label: {
////                        Text("Edit")
////                            .font(.largeTitle)
////                    }
////                }
////            }
//        }
//    }
//}
//
//#Preview {
//    RecentsView()
//}
