//
//  HeroDetailsView.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 25/05/2025.
//

import SwiftUI
import CoreStyles

public struct HeroDetailsView: View {
    @ObservedObject var viewModel: HeroDetailsViewModel

    public init(viewModel: HeroDetailsViewModel) {
        self.viewModel = viewModel
    }

    public var  body: some View {
        ScrollView {
            VStack(spacing: .zero) {
                ZStack(alignment: .topLeading) {
                    backgroundImage
                }
                .frame(height: Style.Size.heroImageCoverHeight)

                details
                    .padding(.all, Style.Spacing.md)

                Spacer()
            }
            .navigationBarBackButtonHidden(false)
            .navigationTitle(viewModel.name)
            .padding(.top, Style.Spacing.md)
            .task {
                await viewModel.fetchHeroDetails()
            }
        }
    }
}

// MARK: - Top Image View
private extension HeroDetailsView {
    var backgroundImage: some View {
        VStack {
            AsyncImage(url: URL(string: viewModel.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .padding(.bottom, Style.Spacing.px64)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(maxWidth: .infinity)
                        .frame(height: Style.Size.heroImageCoverHeight)
                case .failure(_):
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
        }
        .clipShape(.rect(cornerRadius: Style.CornerRadius.md))
    }
    
    var overlayView: some View {
        Rectangle()
            .foregroundStyle(.black)
            .opacity(0.4)
            .clipShape(.rect(cornerRadius: Style.Spacing.md))
    }
}


// MARK: - Details View

private extension HeroDetailsView {
    var details: some View {
        VStack(spacing: Style.Spacing.sm) {
            description

            if let viewModel = viewModel.comicsViewModel {
                HeroInfoListView(viewModel: viewModel)
            }
            if let viewModel = viewModel.seriesViewModel {
                HeroInfoListView(viewModel: viewModel)
            }
            if let viewModel = viewModel.storiesViewModel {
                HeroInfoListView(viewModel: viewModel)
            }
        }
    }

    func infoView(title: String, value: String) -> some View {
        VStack(
            alignment: .leading,
            spacing: Style.Spacing.xxs
        ) {
            Text(title)
                .typography(.heading02)
                .foregroundStyle(.primary)

            Text(value)
                .typography(.caption02)
                .foregroundStyle(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

// MARK: - Description

private extension HeroDetailsView {
    @ViewBuilder
    var description: some View {
        if !viewModel.description.isEmpty {
            VStack(
                alignment: .leading,
                spacing: Style.Spacing.lg
            ) {
                infoView(
                    title: "Description",
                    value: viewModel.description
                )
            }
        }
    }
}
