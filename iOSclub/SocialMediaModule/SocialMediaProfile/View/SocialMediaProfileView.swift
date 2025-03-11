//
//  SocialMediaProfileView.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 11/03/25.
//

import SwiftUI

struct SocialMediaProfileView: View {
    var body: some View {
        ScrollView{
            VStack(spacing:0){
                //Profile Header View
                HStack(spacing:0){
                    Image("Chevron left")
                        .frame(width: 24, height: 24)
                        .padding(.leading,14)
                    
                    Spacer()
                    
                    Text("Katie Lee")
                        .foregroundStyle(Color(hex: "323842"))
                        .font(.custom("Inter", size: 18).bold())
                    
                    Spacer()
                    
                    Image("Search")
                        .padding(.trailing,14)
                    
                }
                
                //Profile Photo and Banner section
                ZStack{
                    Image("DemoBanner")
                        .resizable()
                        .cornerRadius(16, corners: [.topLeft,.topRight])
                        .frame(height: 150)
                        .padding([.leading,.trailing],24)
                    
                    VStack(spacing:0){
                        Image("Avatar")
                            .frame(width: 160,height: 160)
                            .cornerRadius(100)
                    }
                    .offset(y: 80)
                    
                    
                }
                .padding(.top,12)
                .padding(.bottom,80)
                
                Text("Jena")
                    .font(.custom("Archivo", size: 20).bold())
                    .padding(.top,18)
                
                Text("Photographer, travelholic, food love and iOS Dev")
                    .font(.custom("Inter", size: 16)) // Add font name
                    .foregroundStyle(Color(hex: "9095A0"))
                    .padding(.top, 10)
                    .padding([.leading, .trailing], 70)
                    .multilineTextAlignment(.center) // Optional alignment
                    .lineLimit(nil) // Or omit this line, wrapping works by default
                

               
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    SocialMediaProfileView()
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner

    init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
