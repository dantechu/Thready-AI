//
//  View+Extension.swift
//  Shades App
//
//  Created by Hamza Butt on 4/12/23.
//

import Foundation
import SwiftUI


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}


struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}




// old GAD App id
// ca-app-pub-3940256099942544~1458002511
//
// inst ad old id:
// ca-app-pub-3940256099942544/4411468910


