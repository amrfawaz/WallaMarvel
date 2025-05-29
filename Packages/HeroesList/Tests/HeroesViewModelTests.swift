//
//  HeroesViewModelTests.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 26/05/2025.
//

import XCTest
import Combine
@testable import HeroesList
@testable import SharedModels
@testable import NetworkProvider

final class HeroesViewModelTests: XCTestCase {
    private var mockUseCase: MockHeroesUseCase!
    private var mockRepository: MockHeroesRepository!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepository = MockHeroesRepository()
        mockUseCase = MockHeroesUseCase(repository: mockRepository)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        cancellables = nil
        mockUseCase = nil
        mockRepository = nil
        super.tearDown()
    }

    @MainActor
    func test_init_shouldSetInitialValues() {
        // Given
        let sut = HeroesViewModel(heroesUseCase: mockUseCase)

        // Then
        XCTAssertTrue(sut.heroes.isEmpty, "heroes list should be empty")
        XCTAssertTrue(sut.filteredHeroes.isEmpty, "filtered heroes list should be empty")
        XCTAssertEqual(sut.searchText, "", "search bar should be empty")
        XCTAssertFalse(sut.isLoading, "loading state should be false")
        XCTAssertEqual(sut.errorMessage, "", "error message should be empty")
    }

    // MARK: - Fetch Heroes Tests

    @MainActor
    func test_fetchHeroes_withSuccessResponse_shouldUpdateHeroesAndState() async {
        // Given
        let sut = HeroesViewModel(heroesUseCase: mockUseCase)
        let expectedHeroes = CharacterDataModel.mockedHeros
        let response = FetchHeroesResponse(
            count: 3,
            limit: 20,
            offset: 0,
            characters: expectedHeroes
        )
        let jsonData = createMockJSONData(response: response)
        mockUseCase.responseData = jsonData
        
        // When
        await sut.fetchHeroes()
        
        // Then
        XCTAssertEqual(sut.heroes.count, 8, "heroes list should contains 8 elements")
        XCTAssertEqual(sut.heroes[0].name, "3-D Man", "first hero should be 3-D Man")
        XCTAssertEqual(sut.heroes[1].name, "Aaron Stack", "second hero should be Aaron Stack")
        XCTAssertEqual(sut.heroes[2].name, "A.I.M.", "Third hero should be A.I.M.")
        XCTAssertEqual(sut.filteredHeroes.count, 8, "filtered heroes should match heroes when no search")
        XCTAssertFalse(sut.isLoading, "loading state should be false")
        XCTAssertEqual(sut.errorMessage, "", "error message should be empty")
    }

    @MainActor
    func test_fetchHeroes_withError_shouldSetErrorMessage() async {
        // Given
        let sut = HeroesViewModel(heroesUseCase: mockUseCase)
        mockUseCase.responseError = NetworkError.serverError
        
        // When
        await sut.fetchHeroes()
        
        // Then
        XCTAssertTrue(sut.heroes.isEmpty, "heroes list should be empty")
        XCTAssertTrue(sut.filteredHeroes.isEmpty, "filtered heroes list should be empty")
        XCTAssertFalse(sut.isLoading, "loading state should be false")
        XCTAssertFalse(sut.errorMessage.isEmpty, "error message shouldn't be empty")
    }

    @MainActor
    func test_fetchHeroes_shouldSetLoadingStateCorrectly() async {
        // Given
        let sut = HeroesViewModel(heroesUseCase: mockUseCase)
        let response = makeMockHeroesResponse()
        let jsonData = createMockJSONData(response: response)
        mockUseCase.responseData = jsonData
        
        let loadingExpectation = XCTestExpectation(description: "Loading should be true during fetch")
        let notLoadingExpectation = XCTestExpectation(description: "Loading should be false after fetch")
        
        // Monitor loading state
        sut.$isLoading
            .sink { isLoading in
                if isLoading {
                    loadingExpectation.fulfill()
                } else if loadingExpectation.isInverted == false {
                    // Only fulfill after we've seen loading = true
                    notLoadingExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // When
        await sut.fetchHeroes()
        
        // Then
        await fulfillment(of: [loadingExpectation, notLoadingExpectation], timeout: 1.0)
        XCTAssertFalse(sut.isLoading, "loading state should be false")
    }

    func test_searchText_withValidQuery_shouldFilterHeroes() async {
        // Given
        let sut = HeroesViewModel(heroesUseCase: mockUseCase)
        let heroes = CharacterDataModel.mockedHeros
        sut.heroes = heroes
        
        let expectation = XCTestExpectation(description: "Filtered heroes should update")
        
        sut.$filteredHeroes
            .dropFirst() // Skip initial value
            .sink { filteredHeroes in
                if filteredHeroes.count == 1 && filteredHeroes[0].name == "3-D Man" {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // When
        sut.searchText = "3-D"
        
        // Then
        await fulfillment(of: [expectation], timeout: 1.0)
        XCTAssertEqual(sut.filteredHeroes.count, 1, "filtered heroes list should contains 1 element")
        XCTAssertEqual(sut.filteredHeroes[0].name, "3-D Man", "first hero should be 3-D Man")
    }

}

// MARK: - Test Helpers

extension HeroesViewModelTests {
    private func makeMockHeroesResponse() -> FetchHeroesResponse {
        return FetchHeroesResponse(
            count: 3,
            limit: 20,
            offset: 0,
            characters: CharacterDataModel.mockedHeros
        )
    }

    private func createMockJSONData(response: FetchHeroesResponse) -> Data {
        let jsonDict: [String: Any] = [
            "data": [
                "count": response.count,
                "limit": response.limit,
                "offset": response.offset,
                "results": response.characters.map { character in
                    [
                        "id": character.id,
                        "name": character.name,
                        "description": character.description,
                        "thumbnail": [
                            "path": character.thumbnail.path,
                            "extension": character.thumbnail.extension
                        ],
                        "comics": [
                            "items": character.comics.items.map { ["name": $0.name] }
                        ],
                        "series": [
                            "items": character.series.items.map { ["name": $0.name] }
                        ],
                        "stories": [
                            "items": character.stories.items.map { ["name": $0.name] }
                        ]
                    ]
                }
            ]
        ]

        return try! JSONSerialization.data(withJSONObject: jsonDict, options: [])
    }
}
