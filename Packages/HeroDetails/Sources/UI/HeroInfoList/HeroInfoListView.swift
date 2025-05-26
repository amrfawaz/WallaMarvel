//
//  HeroInfoListView.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 26/05/2025.
//

import Foundation
import SwiftUI
import CoreStyles

struct HeroInfoListView: View {
    private var viewModel: HeroInfoListViewModel
    
    init(viewModel: HeroInfoListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return VStack(
            alignment: .leading,
            spacing: Style.Spacing.xxs
        ) {
            Text(viewModel.title)
                .typography(.heading02)
                .foregroundStyle(.primary)
            
            infoList
        }
    }
    
    private var infoList: some View {
        ForEach(viewModel.list, id: \.self) { name in
            VStack(
                alignment: .leading,
                spacing: Style.Spacing.xs
            ) {
                Text(name)
                    .typography(.caption02)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                
                Divider()
            }
        }
    }
}
