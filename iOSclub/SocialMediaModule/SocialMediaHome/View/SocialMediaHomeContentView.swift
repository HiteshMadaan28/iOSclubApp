//
//  SocialMediaHomeContentView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 10/03/25.
//

import SwiftUI

struct SocialMediaHomeContentView: View {
    var body: some View {
        
        VStack{
            SocialMediaHomeHeaderView()
            
            ScrollView{
                VStack{
                    
                    SocialMediaHomeStoryView()
                    
                    SocialMediaHomePostView()
                }
            }
            .scrollIndicators(.hidden)
            .background(Color(hex: "F8F9FA"))
        }
        
    }
}

#Preview {
    SocialMediaHomeContentView()
}
