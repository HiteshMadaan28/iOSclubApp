//
//  SocialMediaHomeHeaderView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 10/03/25.
//

import SwiftUI

struct SocialMediaHomeHeaderView: View {
    
    var body: some View {
        HStack(spacing:0){
            NavigationLink(destination : SocialMediaProfileView()){
                Circle()
                    .fill(Color.gray.opacity(0.6))
                    .frame(width: 36, height: 36)
                    .padding(.leading,24)
                    .padding(.top,4)
                    .padding(.bottom,8)
            }
           
            
            Text("iOS Club")
                .font(.custom("Inter", size: 18).bold())
                .padding(.leading,14)
                .padding(.top,12)
                .padding(.bottom,12)
            
            Spacer()
            
            NavigationLink(destination: ChatListView()) {
                Image(systemName:"ellipsis.message.fill")
                    .padding([.top,.bottom,.trailing],14)
            }
            .foregroundStyle(Color.gray.opacity(0.8))
        }
        
    }
}

#Preview {
    SocialMediaHomeHeaderView()
}
