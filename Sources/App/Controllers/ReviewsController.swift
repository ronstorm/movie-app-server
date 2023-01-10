//
//  ReviewsController.swift
//  
//
//  Created by Amit Sen on 07.01.23.
//

import Vapor

class ReviewsController {
    
    func create(_ req: Request) throws -> EventLoopFuture<Review> {
        
        let review = try req.content.decode(Review.self)
        return review.save(on: req.db).map { review }
    }
}
