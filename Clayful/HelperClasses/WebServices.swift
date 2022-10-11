//
//  WebServices.swift
//  Clayful
//
//  Created by TajinderMohal on 12/05/22.
//

import UIKit
import Alamofire

class WebServices {
    
    static var shared: WebServices {
        return WebServices()
    }
    fileprivate init(){}
    
    //MARK:- Post Data API Interaction
    func postData(_ urlStr: String, params: [String:Any], showIndicator: Bool,methodType: HTTPMethod,viewCont: UIViewController,completion: @escaping (_ response: ResponseHandle) -> Void) {
        if NetworkReachabilityManager()!.isReachable {
            if showIndicator {
                CommonMethod.shared.showActivityIndicator()
            }
            debugPrint("URL:- ",urlStr)
            debugPrint("Params:- ", params)
             debugPrint("Headers:- ",headers())
            AF.request(urlStr, method: methodType, parameters: params, encoding: JSONEncoding.default, headers: HTTPHeaders(headers())).responseJSON { response in
                DispatchQueue.main.async {
                    if showIndicator {
                        CommonMethod.shared.hideActivityIndicator()
                    }
                    if response.data != nil && response.error == nil {
                        if let JSON = response.value as? NSDictionary {
                            debugPrint("JSON:- ", JSON)
                            debugPrint("JSON String:- ", NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? "")
                            if response.response?.statusCode == 200 {
                                completion(ResponseHandle(data: response.data!, JSON: JSON, message: self.getErrorMsg(JSON),isSuccess: true))
                            } else {
                                CommonMethod.shared.hideActivityIndicator()
                                completion(ResponseHandle(data: response.data!, JSON: JSON, message: self.getErrorMsg(JSON), isSuccess: false, statusCode: response.response?.statusCode ?? 204))
                            }
                        } else {
                            CommonMethod.shared.hideActivityIndicator()
                            self.statusHandler(response, currentCont: viewCont)
                        }
                    } else if response.response?.statusCode == 200 {
                        completion(ResponseHandle(data: response.data!, JSON: [:], message: "",isSuccess: true))
                        
                    } else {
                        CommonMethod.shared.hideActivityIndicator()
                        self.statusHandler(response,currentCont: viewCont)
                    }
                }
            }
        } else {
            CommonMethod.shared.hideActivityIndicator()
            CommonMethod.shared.openSettingApp()
        }
    }
    
    //MARK:- Get Data API Interaction
    func getData(_ urlStr: String, showIndicator: Bool, viewCont: UIViewController, completion: @escaping(_ response: ResponseHandle) -> Void) {
        if NetworkReachabilityManager()!.isReachable {
            if showIndicator {
                CommonMethod.shared.showActivityIndicator()
            }
            debugPrint("URL:- ",urlStr)
            debugPrint("Headers:- ",headers())
            AF.request(urlStr, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HTTPHeaders(headers())).responseJSON { response in
                DispatchQueue.main.async {
                    CommonMethod.shared.hideActivityIndicator()
                    if response.data != nil && response.error == nil {
                        if let JSON = response.value as? NSDictionary {
                            debugPrint("JSON:- ", JSON)
                            debugPrint("JSON String:- ", NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? "")
                            if response.response?.statusCode == 200 {
                                completion(ResponseHandle(data: response.data!, JSON: JSON, message: self.getErrorMsg(JSON),isSuccess: true))
                            } else {
                                completion(ResponseHandle(data: response.data!, JSON: JSON, message: self.getErrorMsg(JSON),isSuccess: false))
                            }
                        } else {
                            self.statusHandler(response,currentCont: viewCont)
                        }
                    } else if response.response?.statusCode == 200 {
                        completion(ResponseHandle(data: response.data!, JSON: [:], message: "",isSuccess: true))
                    } else {
                        self.statusHandler(response,currentCont: viewCont)
                    }
                }
            }
        } else {
            CommonMethod.shared.hideActivityIndicator()
            CommonMethod.shared.openSettingApp()
        }
    }
    
    //MARK:- Upload Image API Interaction
    func uploadImage(_ parameters:[String:AnyObject],parametersImage:[String:UIImage],videoUrl:URL?,videoParam: String,addImageUrl:String, showIndicator: Bool,methodType: HTTPMethod, viewCont: UIViewController,documentParam:[String:Data],completion:@escaping(_ response: ResponseHandle) -> Void) {
        if NetworkReachabilityManager()!.isReachable {
            if showIndicator {
                CommonMethod.shared.showActivityIndicator()
            }
            debugPrint("URL:- ",addImageUrl)
            debugPrint("Params:- ", parameters)
            debugPrint("Params Image:- ", parametersImage)
            debugPrint("Params Document:- ", documentParam)
            debugPrint("Header:- ", headers())
            AF.upload(multipartFormData: { multipartFormData in
                for (key, val) in parameters {
                    multipartFormData.append(val.data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
                for (key, val) in parametersImage {
                    let timeStamp = Date().timeIntervalSince1970 * 1000
                    let fileName = "image\(timeStamp).png"
                    guard let imageData = val.jpegData(compressionQuality: 0.5) else {
                        return
                    }
                    multipartFormData.append(imageData, withName: key, fileName: fileName , mimeType: "image/png")
                }
                if videoUrl != nil {
                    let videoFileName = "video\(Date().timeIntervalSince1970 * 1000).mp4"
                    multipartFormData.append(videoUrl!, withName: videoParam, fileName: videoFileName, mimeType: "video/mp4")
                }
                for (key, value) in documentParam {
                    let timeStamp = Date().timeIntervalSince1970 * 1000
                    let fileName = "pdfFile\(timeStamp).pdf"
                    multipartFormData.append(value, withName: key, fileName: fileName, mimeType:"application/pdf")
                }
            },to: addImageUrl,method: methodType, headers: HTTPHeaders(headers())).responseJSON { response in
                CommonMethod.shared.hideActivityIndicator()
                if response.data != nil && response.error == nil {
                    if let JSON = response.value as? NSDictionary {
                        debugPrint("JSON:- ", JSON)
                        debugPrint("JSON String:- ", NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? "")
                        if response.response?.statusCode == 200 {
                            completion(ResponseHandle(data: response.data!, JSON: JSON, message: self.getErrorMsg(JSON),isSuccess: true))
                        } else {
                            completion(ResponseHandle(data: response.data!, JSON: JSON, message: self.getErrorMsg(JSON),isSuccess: false))
                        }
                    } else {
                        self.statusHandler(response,currentCont: viewCont)
                    }
                } else if response.response?.statusCode == 200 {
                    completion(ResponseHandle(data: response.data!, JSON: [:], message: "",isSuccess: true))
                } else {
                    self.statusHandler(response,currentCont: viewCont)
                }
            }
        } else {
            CommonMethod.shared.hideActivityIndicator()
            CommonMethod.shared.openSettingApp()
        }
    }
    
    //MARK:- Error Handling Methos
    func statusHandler(_ response:AFDataResponse<Any>,currentCont: UIViewController) {
        var messageStr = String()
        if let code = response.response?.statusCode {
            if let JSON = response.value as? NSDictionary {
                messageStr = getErrorMsg(JSON)
                switch code {
                case 400:
                    currentCont.displayAlertMessage(messageStr)
                case 401:
                    currentCont.displayAlertMessageWithOk(messageStr) {
                        DispatchQueue.main.async {
                            RootControllerMethod.shared.rootWithoutDrawer(ContollerName.loginVC, storyBoardType: .login)
                        }
                    }
                case 404:
                    currentCont.displayAlertMessage(messageStr)
                case 500:
                    currentCont.displayAlertMessage(messageStr)
                case 408:
                    currentCont.displayAlertMessage(messageStr)
                case 426:
                    currentCont.displayAlertMessage(messageStr)
                default:
                    currentCont.displayAlertMessage(messageStr)
                }
            } else {
                if response.data != nil {
                    messageStr = (NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? "") as String
                    messageStr = messageStr == "" ? AppAlerts.titleValue.serverNotResponding : messageStr
                } else {
                    if response.error != nil {
                        messageStr = response.error?.localizedDescription ?? AppAlerts.titleValue.serverNotResponding
                    } else {
                        messageStr = AppAlerts.titleValue.serverNotResponding
                    }
                }
                currentCont.displayAlertMessage(messageStr)
            }
        } else {
            if response.data != nil {
                messageStr = (NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? "") as String
                messageStr = messageStr == "" ? AppAlerts.titleValue.serverNotResponding : messageStr
            } else {
                if response.error != nil {
                    messageStr = response.error?.localizedDescription ?? AppAlerts.titleValue.serverNotResponding
                } else {
                    messageStr = AppAlerts.titleValue.serverNotResponding
                }
            }
            currentCont.displayAlertMessage(messageStr)
        }
    }
    
    //MARK:- Get Error Message
    func getErrorMsg(_ json: NSDictionary) -> String {
        var msgStr = String()
        if let errorMsg = json["error"] as? String {
            msgStr = errorMsg
        } else if let errorMessage = json["message"] as? String {
            msgStr = errorMessage
        } else {
            msgStr = AppAlerts.titleValue.serverNotResponding
        }
        return msgStr
    }
}

