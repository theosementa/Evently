//
//  MemberListRow.swift
//  Evently
//
//  Created by Theo Sementa on 08/02/2025.
//

import SwiftUI

struct MemberListRow: View {
    
    var members: [UserModel]
    
    var limitedMembers: [UserModel] {
        return Array(members.prefix(4))
    }
    
    // MARK: -
    var body: some View {
        VStack(spacing: 24) {
            HStack(spacing: 8) {
                Text("Liste des membres") // TODO: TBL
                    .font(.Content.xlBold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 4) {
                    Text(members.count.formatted())
                        .font(.Content.mediumBold)
                    
                    Image(.person)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.black200)
                }
            }
            
            VStack(spacing: 16) {
                ForEach(limitedMembers) { member in
                    HStack(spacing: 8) {
                        Image(.person)
                        Text(member.fullName)
                            .font(.Content.mediumSemiBold)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                if members.count > 4 {
                    Text("+ \(members.count - 4) personnes") // TODO: TBL
                }
            }
        }
        .padding(24)
        .background {
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(Color.black100)
                .stroke(Color.black200, lineWidth: 1)
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    MemberListRow(members: [.preview])
}
