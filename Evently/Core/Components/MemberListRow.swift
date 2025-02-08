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

    var extraPeopleCount: Int {
        return max(0, members.count - 4)
    }

    // MARK: -
    var body: some View {
        VStack(spacing: 24) {
            HStack(spacing: 8) {
                Text("member_list_title".localized)
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
                if extraPeopleCount > 0 {
                    let labelToDisplay = "member_list_\(extraPeopleCount == 1 ? "person" : "people")".localized
                    Text("+ \(extraPeopleCount) \(labelToDisplay)")
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
