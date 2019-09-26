//
//  RakutenTVTests.swift
//  RakutenTVTests
//
//  Created by Queen on 5.09.2019.
//  Copyright © 2019 Queen. All rights reserved.
//

import XCTest
@testable import RakutenTV


class RakutenTVTests: XCTestCase {

    
    
    override func setUp() {
        super.setUp()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAddParameters(){
        
        let params = ApiController.addParameters(ApiController.getParameters())
        
        XCTAssertEqual(params, "classification_id=6&device_identifier=ios&locale=es&market_code=es","CONNECTION PARAMETERS NOT EQUAL")
    }
    
    
    func testEmptyPromoList(){
        
        let cell = PromoContentListCell.init(frame: CGRect.zero)
        cell.listViewModel = ListViewModel(list: ListModel(dictionary: [:]))
    
        
    }
    
    func testEmptyContentList(){
        
        let cell = ContentListCell.init(frame: CGRect.zero)
        cell.listViewModel = ListViewModel(list: ListModel(dictionary: [:]))
        
    }
    
    func testScoreListView(){
    
        let cell = ScoreListCell.init(frame: CGRect.zero)
        cell.ScoreListViewModel = ScoreListViewModel(movieModel: MovieModel(dictionary: [:]))
        
    }
    
    func testGenreListCell(){
        
        let cell = GenreListCell.init(frame: CGRect.zero)
        cell.genreListViewModel = GenreListViewModel(movieModel: MovieModel(dictionary: [:]))
        
    }
    
    func testActorListCell(){
        
        let cell = ActorListCell.init(frame: CGRect.zero)
        cell.actorListViewModel = ActorListViewModel(movieModel: MovieModel(dictionary: [:]))
        
    }

    func testPlayerStreamSetup(){
        
        PlayerViewController().setPlayerInfromations(streamModel: StreamingModel(dictionary: [:]) )
        
    }
    
    
    func testDetailInformationCell(){
        
        let cell = DetailInformationCell.init(frame: CGRect.zero)
        
        let model = MovieModel(dictionary: ["classification" : ["age":7]])
        
        cell.informationViewModel = InformationViewModel(movieModel: model)
        
        XCTAssertEqual(cell.contentInfoView.labelVote.text, "")
        XCTAssertEqual(cell.contentInfoView.labelScore.text, "")
        XCTAssertEqual(cell.contentInfoView.labelYear.text, "")
        XCTAssertEqual(cell.contentInfoView.labelRestrict.text, "+7")
    }
    
    
    func testGenreCell(){
        
        let cell = GenreCell.init(frame: CGRect.zero)
        cell.genreViewModel = GenreViewModel(genreModel: GenreModel(dictionary: [:]))
        
        
        XCTAssertEqual(cell.genreTitle.text, "")
        XCTAssertEqual(cell.genreImage.image, nil)
    }
    
    func testActorCell(){
        
        let cell = ActorsCell.init(frame: CGRect.zero)
        cell.actorViewModel = ActorViewModel(actorModel: ActorModel(dictionary: [:]))
        
        XCTAssertEqual(cell.actorTitle.text, "")
        XCTAssertEqual(cell.actorImage.image, nil)
    }
    
    func testContentCell(){
        
        let cell = ContentCell.init(frame: CGRect.zero)
        cell.contentViewModel = ContentViewModel(contentModel: ContentModel(dictionary: [:]))
        
        XCTAssertEqual(cell.contentInfoView.labelVote.text, "")
        XCTAssertEqual(cell.contentInfoView.labelScore.text, "")
        XCTAssertEqual(cell.contentInfoView.labelYear.text, "")
        XCTAssertEqual(cell.imageView.image, nil)
    }
    
    func testScoreView(){
        
        let cell = ScoreView.init(frame: CGRect.zero)
        cell.scoreViewModel = ScoreViewModel(scoreModel:  ScoreModel(dictionary: [:]))
        
        XCTAssertEqual(cell.labelScore.text, "")
        XCTAssertEqual(cell.labelVote.text, "")
        XCTAssertEqual(cell.imageSource.image,nil)
        
        
        cell.scoreViewModel = ScoreViewModel(scoreModel:  ScoreModel())
        
        XCTAssertEqual(cell.labelScore.text, "")
        XCTAssertEqual(cell.labelVote.text, "")
        XCTAssertEqual(cell.imageSource.image,nil)
        
    }
}
