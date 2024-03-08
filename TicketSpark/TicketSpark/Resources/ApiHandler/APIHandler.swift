//
//  APIHandler.swift
//  TicketSpark
//
//  Created by Apple on 15/02/24.
//

import UIKit
public enum MethodType: String {
    case POST, GET, PUT, DELETE
}
public enum APIName: String {
    //MARK: - SIGNUP
    case SignUp = "/auth/user/sign-up/"
    case SignUpEmailSendOTP = "/auth/user/sign-up/send/email/otp/"
    case SignUpEmailVerifyOTP = "/auth/user/sign-up/verify/email/otp/"
    case SignUpMobileSendOTP = "/auth/user/sign-up/send/mobile/otp/"
    case SignUpMobileVerifyOTP = "/auth/user/sign-up/verify/mobile/otp/"
    
    //MARK: - SIGNIN
    case SignInEmail = "/auth/user/login/"
    case SignInMobileNumber = "/auth/user/mobile-login/"
    case SignInSendOTP = "/auth/user/mobile-login/send-otp/"
    
    //MARK: - FORGOT PASSWORD
    case ForgotPasswordSendLink = "/auth/user/forgot-password/send-link/"
    case ResetPasswordLink = "/auth/user/forgot-password/"
    case ForgotPasswordSendEmailOTP = "/auth/user/forgot-password/send/email/otp/"
    case ForgotPasswordVerifyOTP = "/auth/user/forgot-password/verify/email/otp/"
    
    //MARK: - ORGANIZATION
    case CreateOrganization = "/organization/create/organization/"
    case UpdateOrganization = "/organization/about/info/organization/"
    case GetAllCountry = "/default/data/all/country/"
    
    //MARK: - CREATE EVENT
    case CreateEvent = "/event/create/event/"
    case GetTimeZone = "/default/data/time-zone/list/"
    case SpecificCountry = "/default/data/specific/country/"
    case GetEventList = "/event/event-type/list/"
    case GetStates = "/default/data/state/"
    
}
// MARK: - EmptyModel
struct EmptyModel: Codable {
}
public enum GroupApiName: String {
    case auth = "auth"
}
struct ResponseCode {
    static let success = 200
    static let sessionExpire = 401
    static let serverError = 500
}
class APIHandler: NSObject {
    static var shared = APIHandler()
    private override init() {}
    private let session = URLSession.shared
   // let baseURL = "http://13.235.115.189"
    let baseURL = "https://dev.api.myticketpartner.com"
    
    
    func executeRequestWith<T: Decodable, U: Encodable>(of type: T.Type = T.self, apiName: APIName, parameters: U?, methodType: MethodType,  authRequired: Bool = true, resetTokenKey: Bool? = false, resetKey: String? = "",  complition: @escaping(Result<ResponseModal<T>, Error>) -> Void) {
        
        var finalURL = baseURL + apiName.rawValue
        
//        if methodType == .GET{
//            if let URL = getURL, URL != ""  {
//                finalURL = baseURL + URL
//            }
//        }else if methodType == .POST && parameters == nil{
//            if let URL = getURL, URL != ""  {
//                finalURL = baseURL + URL
//            }
//        }
        
        guard var requestURL = URL(string: finalURL) else {
            complition(.failure("Incorrect request URL"))
            return
        }
      finalURL = finalURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        if methodType == .GET{
            if parameters != nil {
                    let param = try? JSONEncoder().encode(parameters!)
                    do {
                        let json = try JSONSerialization.jsonObject(with: param!, options: []) as? [String : Any]
                        var queryItems = [URLQueryItem]()
                        for (key, value) in json! {
                            let queryItem = URLQueryItem(name: key, value: "\(value)")
                            queryItems.append(queryItem)
                        }
                        requestURL = self.createURL(withBaseURL: requestURL, queryItems: queryItems) ?? requestURL
                        //requestURL.appending(queryItems: queryItems)
                        
                    } catch {
                        print("errorMsg")
                    }
            }
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = methodType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userData)
        
        if authRequired, let token = userModel?.accessToken {
            print("userModel?.accessToken........ ",userModel!.accessToken! )
            request.setValue("Bearer "+token, forHTTPHeaderField: "Authorization")
        }
        
        //FOR RESET PASSWORD
        if resetTokenKey ?? false, let token = resetKey {
            print("resetTokenKey........ ",token )
            request.setValue("Bearer "+token, forHTTPHeaderField: "Authorization")
        }
        if methodType == .POST{
            if parameters != nil {
                let param = try? JSONEncoder().encode(parameters!)
                request.httpBody = param
            }
        }
        debugPrint("finalURL is \(finalURL)")
        debugPrint("parameters is \(String(describing: parameters))")
        print("\(request.httpMethod ?? "") \(request.url!)")
        let str = String(decoding: request.httpBody ?? Data(), as: UTF8.self)
        print("BODY \n \(str)")
        print("HEADERS \n \(request.allHTTPHeaderFields ?? [:])")
        
        session.dataTask(with: request) { data, response, error in
            var httpStatusCode = 0
            if let httpResponse = response as? HTTPURLResponse {
                httpStatusCode = httpResponse.statusCode
            }
            if error != nil {
                complition(.failure(error?.localizedDescription ?? "Something went wrong"))
            } else {
                if httpStatusCode == 401 {
                    // Refresh Token
                    if let fbData = data {
                        let message = String(decoding: fbData, as: UTF8.self)
                        complition(.failure(message))
                    } else {
                        let message = response?.url?.lastPathComponent
                        complition(.failure("API \(message ?? "") Invalid Response."))
                    }
                } else if httpStatusCode == 200, let data = data {
                    let JSON = self.nsdataToJSON(data: data as NSData)
                    if let json = JSON {
                        print("----------------JSON in APIClient", json)
                    }
                    do {
                        let responseModel = try JSONDecoder().decode(ResponseModal<T>.self, from: data)
                        complition(.success(responseModel))
                    }
                    catch {
                        print(error)
                    }
                } else {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        complition(.failure(json["message"] as? String ?? "something went wrong"))
                    } catch {
                        complition(.failure("Unable to get json."))
                    }
                }
            }
        }.resume()
    }
    
    func executeRequestWithMultipartData<T: Codable>(of type: T.Type = T.self, apiName: APIName, parameters: AddOrganizerRequest?, methodType: MethodType,  authRequired: Bool = true, resetTokenKey: Bool? = false, resetKey: String? = "", body: Data, complition: @escaping(Result<ResponseModal<T>, Error>) -> Void) {
        let finalURL = baseURL + apiName.rawValue
        guard let requestURL = URL(string: finalURL) else {
            complition(.failure("Incorrect request URL"))
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = methodType.rawValue
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = body
        
        let userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userData)
        
        if authRequired, let token = userModel?.accessToken {
            print("userModel?.accessToken........ ",userModel!.accessToken! )
            request.setValue("Bearer "+token, forHTTPHeaderField: "Authorization")
        }
        
        //FOR RESET PASSWORD
        if resetTokenKey ?? false, let token = resetKey {
            print("resetTokenKey........ ",token )
            request.setValue("Bearer "+token, forHTTPHeaderField: "Authorization")
        }
        
        debugPrint("finalURL is \(finalURL)")
        debugPrint("parameters is \(String(describing: parameters))")
        print("\(request.httpMethod ?? "") \(request.url!)")
        let str = String(decoding: request.httpBody ?? Data(), as: UTF8.self)
        print("BODY \n \(str)")
        print("HEADERS \n \(request.allHTTPHeaderFields ?? [:])")
        
        session.dataTask(with: request) { data, response, error in
            var httpStatusCode = 0
            if let httpResponse = response as? HTTPURLResponse {
                httpStatusCode = httpResponse.statusCode
            }
            if error != nil {
                complition(.failure(error?.localizedDescription ?? "Something went wrong"))
            } else {
                if httpStatusCode == 401 {
                    // Refresh Token
                    if let fbData = data {
                        let message = String(decoding: fbData, as: UTF8.self)
                        complition(.failure(message))
                    } else {
                        let message = response?.url?.lastPathComponent
                        complition(.failure("API \(message ?? "") Invalid Response."))
                    }
                } else if httpStatusCode == 200, let data = data {
                    let JSON = self.nsdataToJSON(data: data as NSData)
                    if let json = JSON {
                        print("----------------JSON in APIClient", json)
                    }
                    do {
                        let responseModel = try JSONDecoder().decode(ResponseModal<T>.self, from: data)
                        complition(.success(responseModel))
                    }
                    catch {
                        print(error)
                    }
                } else {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        complition(.failure(json["message"] as? String ?? "something went wrong"))
                    } catch {
                        complition(.failure("Unable to get json."))
                    }
                }
            }
        }.resume()
    }
    
    func executeRequestWithMultipartData1<T: Decodable>(of type: T.Type = T.self, apiName: APIName, methodType: MethodType,  authRequired: Bool = true, resetTokenKey: Bool? = false, resetKey: String? = "", body: Data, complition: @escaping(Result<ResponseModal<T>, Error>) -> Void) {
        let finalURL = baseURL + apiName.rawValue
        guard let requestURL = URL(string: finalURL) else {
            complition(.failure("Incorrect request URL"))
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = methodType.rawValue
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = body
        
        let userModel = UserDefaultManager.share.getModelDataFromUserDefults(userData: SignInAuthModel.self, key: .userData)
        
        if authRequired, let token = userModel?.accessToken {
            print("userModel?.accessToken........ ",userModel!.accessToken! )
            request.setValue("Bearer "+token, forHTTPHeaderField: "Authorization")
        }
        
        //FOR RESET PASSWORD
        if resetTokenKey ?? false, let token = resetKey {
            print("resetTokenKey........ ",token )
            request.setValue("Bearer "+token, forHTTPHeaderField: "Authorization")
        }
        
        debugPrint("finalURL is \(finalURL)")
        print("\(request.httpMethod ?? "") \(request.url!)")
        let str = String(decoding: request.httpBody ?? Data(), as: UTF8.self)
        print("BODY \n \(str)")
        print("HEADERS \n \(request.allHTTPHeaderFields ?? [:])")
        
        session.dataTask(with: request) { data, response, error in
            var httpStatusCode = 0
            if let httpResponse = response as? HTTPURLResponse {
                httpStatusCode = httpResponse.statusCode
            }
            if error != nil {
                complition(.failure(error?.localizedDescription ?? "Something went wrong"))
            } else {
                if httpStatusCode == 401 {
                    // Refresh Token
                    if let fbData = data {
                        let message = String(decoding: fbData, as: UTF8.self)
                        complition(.failure(message))
                    } else {
                        let message = response?.url?.lastPathComponent
                        complition(.failure("API \(message ?? "") Invalid Response."))
                    }
                } else if httpStatusCode == 200, let data = data {
                    let JSON = self.nsdataToJSON(data: data as NSData)
                    if let json = JSON {
                        print("----------------JSON in APIClient", json)
                    }
                    do {
                        let responseModel = try JSONDecoder().decode(ResponseModal<T>.self, from: data)
                        complition(.success(responseModel))
                    }
                    catch {
                        print(error)
                    }
                } else {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                        complition(.failure(json["message"] as? String ?? "something went wrong"))
                    } catch {
                        complition(.failure("Unable to get json."))
                    }
                }
            }
        }.resume()
    }
    
    func createURL(withBaseURL baseURL: URL, queryItems: [URLQueryItem]) -> URL? {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems

        return components?.url
    }
    
    func nsdataToJSON(data: NSData) -> AnyObject? {
        do {
            return try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) as AnyObject
        } catch let myJSONError {
            debugPrint(myJSONError)
        }
        return nil
    }
}
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
