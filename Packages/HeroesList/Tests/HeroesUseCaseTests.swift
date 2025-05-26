//
//  HeroesUseCaseTests.swift
//  Packages
//
//  Created by Amr Abd-Elhakim on 26/05/2025.
//

import XCTest
@testable import NetworkProvider
@testable import HeroesList
@testable import SharedModels

final class HeroesUseCaseTests: XCTestCase {
    private var sut: MockHeroesUseCase!
    private var mockRepository: MockHeroesRepository!

    // MARK: - Setup & Teardown
    
    override func setUp() {
        super.setUp()
        mockRepository = MockHeroesRepository()
        sut = MockHeroesUseCase(repository: mockRepository)
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }
    
    
    func test_execute_withValidResponseData_shouldReturnDecodedResponse() async throws {
        // Given
        let expectedResponse = makeMockHeroesResponse()
        let jsonData = createMockJSONData(response: expectedResponse)
        sut.responseData = jsonData
        
        let request = FetchHeroesRequset(page: 1)
        
        // When
        let result = try await sut.execute(request: request)
        
        // Then
        XCTAssertEqual(result.count, expectedResponse.count)
        XCTAssertEqual(result.limit, expectedResponse.limit)
        XCTAssertEqual(result.offset, expectedResponse.offset)
        XCTAssertEqual(result.characters.count, expectedResponse.characters.count)
        XCTAssertEqual(result.characters[0].name, expectedResponse.characters[0].name)
    }

    func test_execute_withMultipleHeroes_shouldReturnAllHeroes() async throws {
        // Given
        let heroes = CharacterDataModel.mockedHeros
        
        let response = FetchHeroesResponse(
            count: 8,
            limit: 10,
            offset: 0,
            characters: heroes
        )
        
        let jsonData = createMockJSONData(response: response)
        sut.responseData = jsonData
        
        let request = FetchHeroesRequset(page: 1)
        // When
        let result = try await sut.execute(request: request)
        
        // Then
        XCTAssertEqual(result.characters.count, 8)
        XCTAssertEqual(result.characters[0].name, "3-D Man")
        XCTAssertEqual(result.characters[1].name, "Aaron Stack")
        XCTAssertEqual(result.characters[2].name, "A.I.M.")
        XCTAssertEqual(result.characters[3].name, "Abomination (Emil Blonsky)")
        XCTAssertEqual(result.characters[4].name, "Abomination (Ultimate)")
        XCTAssertEqual(result.characters[5].name, "Absorbing Man")
        XCTAssertEqual(result.characters[6].name, "Abyss")
        XCTAssertEqual(result.characters[7].name, "Adam Destine")
    }
    
    func test_execute_withEmptyResponse_shouldReturnEmptyResults() async throws {
        // Given
        let emptyResponse = FetchHeroesResponse(
            count: 0,
            limit: 10,
            offset: 0,
            characters: []
        )
        
        let jsonData = createMockJSONData(response: emptyResponse)
        sut.responseData = jsonData
        
        let request = FetchHeroesRequset(page: 1)
        
        // When
        let result = try await sut.execute(request: request)
        
        // Then
        XCTAssertEqual(result.characters.count, 0)
        XCTAssertEqual(result.count, 0)
        XCTAssertEqual(result.limit, 10)
        XCTAssertEqual(result.offset, 0)
    }
    
    func test_execute_withPaginationData_shouldReturnCorrectPaginationInfo() async throws {
        // Given
        let response = FetchHeroesResponse(
            count: 3,
            limit: 20,
            offset: 40, // Page 3 with 20 items per page
            characters: [
                CharacterDataModel.mockedHero1,
                CharacterDataModel.mockedHero2,
                CharacterDataModel.mockedHero3
            ]
        )
        
        let jsonData = createMockJSONData(response: response)
        sut.responseData = jsonData
        
        let request = FetchHeroesRequset(page: 3)
        
        // When
        let result = try await sut.execute(request: request)
        
        // Then
        XCTAssertEqual(result.offset, 40)
        XCTAssertEqual(result.limit, 20)
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result.characters.count, 3)
    }
    
    func test_execute_withCompleteCharacterData_shouldDecodeAllFields() async throws {
        // Given
        let character = CharacterDataModel.mockedHero1
        
        let response = FetchHeroesResponse(
            count: 1,
            limit: 20,
            offset: 0,
            characters: [character]
        )
        
        let jsonData = createMockJSONData(response: response)
        sut.responseData = jsonData
        
        let request = FetchHeroesRequset(page: 1)
        
        // When
        let result = try await sut.execute(request: request)
        
        // Then
        let resultCharacter = result.characters[0]
        XCTAssertEqual(resultCharacter.id, 1009144)
        XCTAssertEqual(resultCharacter.name, "A.I.M.")
        XCTAssertEqual(resultCharacter.description, "AIM is a terrorist organization bent on destroying the world.")
        XCTAssertEqual(resultCharacter.thumbnail.path, "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec")
        XCTAssertEqual(resultCharacter.thumbnail.extension, "jpg")
        XCTAssertEqual(resultCharacter.comics.items.count, 2)
        XCTAssertEqual(resultCharacter.series.items.count, 1)
        XCTAssertEqual(resultCharacter.stories.items.count, 1)
    }
    
    // MARK: - Error Tests
    
    func test_execute_withNoData_shouldThrowNoDataError() async {
        // Given
        sut.responseData = nil
        sut.responseError = nil
        let request = FetchHeroesRequset(page: 1)
        
        // When & Then
        do {
            _ = try await sut.execute(request: request)
            XCTFail("Expected NetworkError.noData to be thrown")
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.noData)
        } catch {
            XCTFail("Expected NetworkError.noData but got \(type(of: error))")
        }
    }
    
    func test_execute_withInvalidJSON_shouldThrowDecodingError() async {
        // Given
        let invalidJSON = """
        {
            "data": {
                "invalid": "structure",
                "missing_required_fields": true
            }
        }
        """.data(using: .utf8)
        
        sut.responseData = invalidJSON
        let request = FetchHeroesRequset(page: 1)
        
        // When & Then
        do {
            _ = try await sut.execute(request: request)
            XCTFail("Expected NetworkError.decodingError to be thrown")
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.decodingError)
        } catch {
            XCTFail("Expected NetworkError.decodingError but got \(type(of: error))")
        }
    }
    
    func test_execute_withMalformedJSON_shouldThrowDecodingError() async {
        // Given
        let malformedJSON = "{ invalid json }".data(using: .utf8)
        sut.responseData = malformedJSON
        let request = FetchHeroesRequset(page: 1)
        
        // When & Then
        do {
            _ = try await sut.execute(request: request)
            XCTFail("Expected NetworkError.decodingError to be thrown")
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.decodingError)
        } catch {
            XCTFail("Expected NetworkError.decodingError but got \(type(of: error))")
        }
    }
    
    // MARK: - Request Type Tests
    
    func test_execute_withFetchHeroesRequest_shouldProcessCorrectly() async throws {
        // Given
        let response = makeMockHeroesResponse()
        let jsonData = createMockJSONData(response: response)
        sut.responseData = jsonData
        
        let request = FetchHeroesRequset(page: 1)
        
        // When
        let result = try await sut.execute(request: request)
        
        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result.characters.count, response.characters.count)
    }

    // MARK: - Concurrency Tests

    @MainActor
    func test_execute_withValidRequest_shouldReturnHeroes_async() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch heroes should succeed")
        let response = makeMockHeroesResponse()
        let jsonData = createMockJSONData(response: response)
        sut.responseData = jsonData
        
        let request = FetchHeroesRequset(page: 1)
        
        // When
        Task { @Sendable in
            do {
                let result = try await sut.execute(request: request)
                
                // Then
                XCTAssertEqual(result.count, response.count)
                XCTAssertEqual(result.characters.count, response.characters.count)
                XCTAssertEqual(result.characters[0].name, "A.I.M.")
                
                expectation.fulfill()
            } catch {
                XCTFail("Expected success but got error: \(error)")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

}

// MARK: - Test Helpers

extension HeroesUseCaseTests {
    private func makeMockHeroesResponse(
        count: Int = 3,
        limit: Int = 10,
        offset: Int = 0
    ) -> FetchHeroesResponse {
        let characters = [
            CharacterDataModel.mockedHero1,
            CharacterDataModel.mockedHero2,
            CharacterDataModel.mockedHero3
        ]

        return FetchHeroesResponse(
            count: count,
            limit: limit,
            offset: offset,
            characters: characters
        )
    }

    private func createMockJSONData(response: FetchHeroesResponse) -> Data {
        // Create the JSON structure that matches the expected Marvel API response format
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
