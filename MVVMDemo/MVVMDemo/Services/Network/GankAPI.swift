//
//  NetworkService.swift
//  Gank
//
//  Created by Maru on 2016/12/5.
//  Copyright © 2016年 Maru. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum GankAPI {

    enum GankCategory: String {

        case all      = "all"
        case android  = "Android"
        case iOS      = "iOS"
        case video    = "休息视频"
        case welfare  = "福利"
        case resource = "拓展资源"
        case frontEnd = "前端"
        case mass     = "瞎推荐"
        case app      = "App"

        static func mapCategory(with hashValue: Int) -> GankCategory {
            switch hashValue {
            case 0:
                return .all
            case 1:
                return .android
            case 2:
                return .iOS
            case 3:
                return .video
            case 4:
                return .welfare
            case 5:
                return .resource
            case 6:
                return .frontEnd
            case 7:
                return .mass
            case 8:
                return .app
            default:
                return .all
            }
        }
    }

    case data(type: GankCategory, size: Int64, index: Int64)
}

extension GankAPI: TargetType {
    var headers: [String : String]? {
        return SessionManager.defaultHTTPHeaders
    }

    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }


    var baseURL: URL { return URL(string: "http://gank.io")! }

    var path: String {
        switch self {
        case .data(let type, let size, let index):
            return "/api/data/\(type.rawValue)/\(size)/\(index)"
        }
    }

    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }

    var sampleData: Data {
        return "this is a sample data".utf8EncodedData
    }

    var parameters: [String : Any]? {
        return nil
    }

    var task: Task {
        switch self {
        case .data(_, _, _):
            return .requestPlain
        }
    }
}

let gankApi = Provider<GankAPI>()

class Provider<Target> where Target: Moya.TargetType {
    
    let provider: MoyaProvider<Target>
    
    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
         manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
         plugins: [PluginType] = [NetworkLoggerPlugin()],
         trackInflights: Bool = false) {
        
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: manager, plugins: plugins, trackInflights: trackInflights)
    }
    
}

// MARK: - Helpers

private extension String {

    var utf8EncodedData: Data {
        return self.data(using: .utf8)!
    }
}
