//
//  WatchVideoModels.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 09/11/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import ObjectMapper

struct WatchVideo {
    
    struct Constants { }
    
    struct Info {
        
        struct Received {
            
            struct Project {
                let id: String
            }
        }
        
        struct Response {
            
            final class Video: Mappable {
                var videoId: String?
                
                init?(map: Map) { }
                
                func mapping(map: Map) {
                    videoId <- map["youtube_url"]
                }
            }
        }
        
        struct Model {
            
            struct Video {
                let id: String
            }
        }
        
        struct ViewModel {
            
            struct Video {
                let id: String
            }
        }
    }
    
    struct Request {
        
        struct RegisterView { }
        
        struct FetchYoutubeId { }
        
        struct RegisterViewWithId {
            let projectId: String
        }
        
        struct FetchYoutubeIdWithProjectId {
            let projectId: String
        }
    }
}
