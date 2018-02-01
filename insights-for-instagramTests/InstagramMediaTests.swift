//
//  InstagramMediaTests.swift
//  insights-for-instagram
//
//  Created by Alex Di Mango on 20/09/2017.
//  Copyright © 2017 Alex Di Mango. All rights reserved.
//

import Quick
import Nimble
import Result
import Alamofire
@testable import insights_for_instagram
import ObjectMapper

class InstagramMediaTests: QuickSpec {
    override func spec() {
        it("create from JSON") {
            let id = "id-xyz"
            let code = "xyx"
            let imageUrl = ""
            let createdTime = Date()
            let likesCount = 4
            let commentsCount = 3
            let engagementCount = 7
            let json = ["id": id, "code": code, "image_url": imageUrl, "created_time": createdTime, "likes_count": likesCount, "comments_count": commentsCount, "engagement_count": engagementCount] as [String: Any]
            let media = InstagramMedia(JSON: json)
            expect(media?.id) == id
            expect(media?.code) == code
            expect(media?.likesCount) == 4
            expect(media?.commentsCount) == 3
            expect(media?.engagementCount) == 4 + 3
        }
}}
