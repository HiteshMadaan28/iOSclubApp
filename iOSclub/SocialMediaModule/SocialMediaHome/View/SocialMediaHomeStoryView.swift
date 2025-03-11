//
//  SocialMediaHomeStoryView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 10/03/25.
//

import SwiftUI

struct SocialMediaHomeStoryView: View {
    var body: some View {
        ScrollView(.horizontal){
            
            HStack(spacing:0){
                
                VStack(spacing:0){
                    Image("StorySelector")
                        .padding(.top,18)
                        .padding(.bottom,10)
                    
                    HStack(alignment:.center,spacing: 0){

                        Text("You")
                        .font(.custom("Inter", size: 14))
                        .foregroundStyle(Color(hex:"#323842"))
                        .padding(.bottom,18)
                        
                    }
                }
                .padding(.leading,24)
                
                
                VStack(spacing: 0){
                    Circle()
                        .fill(Color.red.opacity(0.4))
                        .frame(width: 44)
                        .padding(.top,18)
                        .padding(.bottom,10)
                    
                    HStack(alignment:.center,spacing: 0){

                        Text("Sally")
                        .font(.custom("Inter", size: 14))
                        .foregroundStyle(Color(hex:"#323842"))
                        .padding(.bottom,18)
                        
                    }
                }
                .padding(.leading,18)
                
                VStack(spacing: 0){
                    Circle()
                        .fill(Color.blue.opacity(0.4))
                        .frame(width: 44)
                        .padding(.top,18)
                        .padding(.bottom,10)
                    
                    HStack(alignment:.center,spacing: 0){

                        Text("Jason")
                        .font(.custom("Inter", size: 14))
                        .foregroundStyle(Color(hex:"#323842"))
                        .padding(.bottom,18)
                        
                    }
                }
                .padding(.leading,18)
                
                
                VStack(spacing: 0){
                    Circle()
                        .fill(Color.green.opacity(0.4))
                        .frame(width: 44)
                        .padding(.top,18)
                        .padding(.bottom,10)
                    
                    HStack(alignment:.center,spacing: 0){

                        Text("Jena")
                        .font(.custom("Inter", size: 14))
                        .foregroundStyle(Color(hex:"#323842"))
                        .padding(.bottom,18)
                        
                    }
                }
                .padding(.leading,18)
                
                VStack(spacing: 0){
                    Circle()
                        .fill(Color.yellow.opacity(0.4))
                        .frame(width: 44)
                        .padding(.top,18)
                        .padding(.bottom,10)
                    
                    HStack(alignment:.center,spacing: 0){

                        Text("Michale")
                        .font(.custom("Inter", size: 14))
                        .foregroundStyle(Color(hex:"#323842"))
                        .padding(.bottom,18)
                        
                    }
                }
                .padding(.leading,18)
                
                VStack(spacing: 0){
                    Circle()
                        .fill(Color.pink.opacity(0.4))
                        .frame(width: 44)
                        .padding(.top,18)
                        .padding(.bottom,10)
                    
                    HStack(alignment:.center,spacing: 0){

                        Text("Lary")
                        .font(.custom("Inter", size: 14))
                        .foregroundStyle(Color(hex:"#323842"))
                        .padding(.bottom,18)
                        
                    }
                }
                .padding(.leading,18)
                
                VStack(spacing: 0){
                    Circle()
                        .fill(Color.red.opacity(0.4))
                        .frame(width: 44)
                        .padding(.top,18)
                        .padding(.bottom,10)
                    
                    HStack(alignment:.center,spacing: 0){

                        Text("Sally")
                        .font(.custom("Inter", size: 14))
                        .foregroundStyle(Color(hex:"#323842"))
                        .padding(.bottom,18)
                        
                    }
                }
                .padding([.leading,.trailing],18)
                
                
                
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    SocialMediaHomeStoryView()
}
