//
//  HeroView.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 24/05/2025.
//

import SwiftUI
import CoreStyles

struct HeroView: View {
    private enum Constant {
        static let detailsLineLimit = 2
    }

    @ObservedObject private var viewModel: HeroViewModel

    init(viewModel: HeroViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottom) {
                backgroundImage
                overlayView
                HStack(alignment: .bottom) {
                    content
                }
            }
            .frame(height: Style.Size.heroCardImageHeight)

            HStack(alignment: .top) {
                bottomView
            }
        }
        .frame(height: Style.Size.heroCardHeight)
        .onTapGesture {
            viewModel.subject.send(.didTapHeroCard)
        }

    }
}

// MARK: - Card Image

private extension HeroView {
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
                        .frame(height: Style.Size.heroCardImageHeight)
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

// MARK: - Content Views

private extension HeroView {
    var content: some View {
        HStack(
            alignment: .bottom,
            spacing: Style.Spacing.xs
        ) {
            description
        }
        .padding(.horizontal, Style.Spacing.xs)
        .padding(.bottom, Style.Spacing.xs)
    }
}

// MARK: - Description

private extension HeroView {
    var description: some View {
        Text(viewModel.description)
            .lineLimit(Constant.detailsLineLimit)
            .typography(.button02)
            .foregroundStyle(.white)
    }
}

// MARK: - Bottom View

private extension HeroView {
    var bottomView: some View {
        HStack(alignment: .center) {
            title

            Spacer()
        }
    }

    var title: some View {
        Text(viewModel.name)
            .typography(.button01)
            .foregroundStyle(.black)
    }
}

// MARK: - Preview

#if DEBUG
struct HeroView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            hero(.mockHeroViewModel)
                .padding(.horizontal, Style.Spacing.md)
        }
    }
    
    private static func hero(_ viewModel: HeroViewModel) -> some View {
        HeroView(viewModel: viewModel)
    }
    
}
#endif
