//
//  HeroesView.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 24/05/2025.
//

import SwiftUI
import CoreStyles

public struct HeroesView: View {
    private enum Constants {
        static let title = "List of Heroes!"
    }

    @ObservedObject private var viewModel: HeroesViewModel
    @State private var path = NavigationPath()

    public init(viewModel: HeroesViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationStack(path: $path) {
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
                .onFirstAppear {
                    Task {
                        await viewModel.fetchHeroes()
                    }
                }
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
            .foregroundStyle(.black)
    }
}

// MARK: - Extenstion List View

private extension HeroesView {
    var list: some View {
        // Use List for better memory unitlization. Lists provide automatic reusing for cells
        List(viewModel.filteredHeroes) { hero in
            let heroViewModel = HeroViewModel(hero: hero)
            
            HeroView(viewModel: heroViewModel)
                .onReceive(heroViewModel.subject) { action in
                    switch action {
                    case .didTapHeroCard:
                        path.append(hero)
                    }
                }
                .listRowSeparator(.hidden) // hide separators
                .listRowInsets(EdgeInsets()) // remove default padding
        }
        .listStyle(.plain)
        .searchable(text: $viewModel.searchText, prompt: "Enter hero name...")
        .navigationDestination(for: CharacterDataModel.self) { hero in
            // Your destination view here
        }
    }
}


// MARK: - Preview

#if DEBUG
struct HeroesView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            heroesView()
        }
    }

    private static func heroesView() -> some View {
        @State var path = NavigationPath()

        return HeroesView(viewModel: .mockHeroesViewModel)
    }
}
#endif
