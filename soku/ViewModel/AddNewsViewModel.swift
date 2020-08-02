//
//  AddNewsViewModel.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/02.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

enum NewsSections : Int, CaseIterable {
    
    case famous1
    case famous2
    case url
    
    var title : String {
        switch self {
        case .famous1 :
            return "一人目"
        case .famous2 :
            return "2人目"
        case .url :
            return "関連URL"
        default:
            break
        }
    }
    
}

struct AddNewsViewModel {
    
    
}
