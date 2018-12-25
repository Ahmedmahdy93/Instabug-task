//
//  Result.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/21/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation
enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}
