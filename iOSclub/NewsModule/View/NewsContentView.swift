//
//  NewsContentView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 28/01/25.
//

import SwiftUI

struct NewsContentView: View {
    var body: some View {
        
        VStack{
            HStack{
                Spacer()
                
                Image(systemName: "bell")
                    .resizable()
                    .frame(width: 24,height: 24)
                    .foregroundStyle(Color.black)
            }
            .padding(.trailing)
            
            HStack{
                Text("News")
                    .font(.custom("Inter", size: 28).bold())
                    .foregroundStyle(Color(hex:"#121417"))
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView{
                ForEach(0...20,id: \.self){_ in 
                    NewsContentCard(imageURL: "https://cdn.usegalileo.ai/sdxl10/d149eff1-1e5d-41b9-ba98-3943ef7ed9a0.png", newsHeading: "Swift 6 is here!", newsDescription: "The new version of Swift has been released. It brings a lot of new features.")
                        .padding(.top,10)
                }
                    
            }
            .padding(.horizontal)
            .scrollIndicators(.hidden)
        }
    }
}

struct NewsContentCard: View{
    var imageURL : String
    var newsHeading : String
    var newsDescription : String
    
    var body: some View{
        HStack(spacing:0){
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(width: 56, height: 56)
            .cornerRadius(8)
            
            VStack(alignment: .leading,spacing:0){
                Text("\(newsHeading)")
                    .font(.custom("", size: 16))
                    .foregroundStyle(Color(hex: "#121417"))
                Text("\(newsDescription)")
                    .font(.custom("", size: 14))
                    .foregroundStyle(Color(hex:"#637887"))
            }
            .padding(.leading,10)
           
            Spacer()
        }
    }
}

#Preview {
    NewsContentView()
}
