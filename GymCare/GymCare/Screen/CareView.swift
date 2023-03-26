//
//  CareView.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 17/02/2023.
//

import SwiftUI
//import SwiftUICircleProgressBar

struct CareView: View {
    @State private var progress = 0.0
    @State private var isHidden = true

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            //MARK - APP BAR
            HStack {
                Text("Sức khoẻ")
                    .font(.system(size: 24, weight: Font.Weight.bold))
            }
            .foregroundColor(.black)
            .overlay(
                Image("logo")
                    .resizable()
                    .frame(width: 32, height: 32)
            )

            // END APP BAR

            //MARK: - PRODUCT LIST
            let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
            // MARK: - GRID VIEW
            LazyVGrid(columns: columns, spacing:  18) {
                ForEach(healths){product in
                    CardView(product: product)
                }
            }.padding()
        }
    }
    
    //MARK: PRODUCT VIEW
    @ViewBuilder
    func CardView(product: Health)-> some View {
        HStack {
            VStack(spacing: 15) {
                
                //MARK: PRODUCT TITLE
                Text(product.title)
                    .fontWeight(.semibold)
                    .padding(.top)
                
                //MARK: - PRODUCT IMAGE

                //MARK: - PRODUCT PRICE
                Text(product.content)
                    .font(.title2.bold())
                
            }

            VStack {
                Image(product.image)
                    .frame(width: 30, height: 30)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                ProgressView(value: progress, total: 1.0) {
                } currentValueLabel: {
                    Text(String(format: "%0.0f%%", progress))
                        .font(.system(size: 12).monospacedDigit())
                }
//                .progressViewStyle(RingProgressViewStyle(progressLabelPosition: .inside))
                .opacity(product.showProgress ? 1 : 0)

            }
        }
        .padding()
        .background(Color.white, in: RoundedRectangle(cornerRadius: 12))
        .clipped()
        .shadow(radius: 5)

    }
}

struct CareView_Previews: PreviewProvider {
    static var previews: some View {
        CareView()
    }
}
