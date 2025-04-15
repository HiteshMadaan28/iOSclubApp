//
//  SocialMediaNotificationContentView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 15/04/25.
//

import SwiftUI

struct SocialMediaNotificationContentView: View {
    var body: some View {
        ScrollView{
            HStack(spacing:0){
                Spacer()
               
                Text("Notifications")
                    .font(.custom("Inter", size:  18).bold())
                
                Spacer()
                
                Image("Search")
                    .padding(.trailing,18)
                
                
            }
        }
    }
}

#Preview {
    SocialMediaNotificationContentView()
}
