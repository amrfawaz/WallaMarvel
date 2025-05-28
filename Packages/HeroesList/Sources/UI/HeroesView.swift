//
//  HeroesView.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 24/05/2025.
//

import SwiftUI
import CoreStyles
import SharedModels
import HeroDetails

public struct HeroesView: View {
    private enum Constants {
        static let title = "List of Heroes!"
    }

    @ObservedObject private var viewModel: HeroesViewModel

    private let navigator: HeroesNavigationProtocol

    public init(
        viewModel: HeroesViewModel,
        navigator: HeroesNavigationProtocol
    ) {
        self.viewModel = viewModel
        self.navigator = navigator
    }
    
    public var body: some View {
        content
            .padding(.all, Style.Spacing.md)
            .alert(isPresented: Binding<Bool>(
                get: { !viewModel.errorMessage.isEmpty },
                set: { newValue in
                    if !newValue {
                        viewModel.errorMessage = ""
                    }
                }
            )) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
    }
    
    private var content: some View {
        VStack(alignment: .center) {
            if viewModel.isLoading {
                ProgressView()
            }
            VStack(
                alignment: .leading,
                spacing: Style.Spacing.md
            ) {
                title
                    .padding(.bottom, Style.Spacing.sm)
                
                list
                    .onFirstAppear {
                        Task {
                            await viewModel.fetchHeroes()
                        }
                    }
            }
        }
    }

    private var title: some View {
        Text(Constants.title)
            .typography(.heading02)
            .foregroundStyle(.primary)
    }
}

// MARK: - Extenstion List View

private extension HeroesView {
    var list: some View {
        // Use List for better memory unitlization. Lists provide automatic reusing for cells
        List(viewModel.filteredHeroes) { hero in
            let heroViewModel = HeroViewModel(hero: hero)
            
            HeroView(viewModel: heroViewModel)
                .onFirstAppear {
                    // Trigger pagination when the last movie appears
                    if viewModel.searchText.isEmpty, hero.id == viewModel.filteredHeroes.last?.id {
                        Task {
                            await viewModel.fetchHeroes()
                        }
                    }
                }
                .onReceive(heroViewModel.subject) { action in
                    switch action {
                    case .didTapHeroCard:
                        navigator.showHeroDetail(hero.id)
                    }
                }
                .listRowSeparator(.hidden) // hide separators
                .listRowInsets(EdgeInsets()) // remove default padding
        }
        .listStyle(.plain)
        .searchable(text: $viewModel.searchText, prompt: "Enter hero name...")
    }
}
