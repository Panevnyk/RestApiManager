 <p align="center">  
 <img src="https://github.com/Panevnyk/RestApiManager/blob/master/Images/satellite-dish.png?raw=true" width="180"> 
 </p>
 
 # RestApiManager
 - *Decouple URLSession logic from endpoints*
 - *Automapping of response objects*
 - *Responce types: Object, Array, String, CustomResponseSerializer*
 - *Easy work with multipart requests*
 - *Cool request, response printing in console*
 - *Auto show load indicator*
 - *Auto show error alert*
 - *Possibility to set a unique Error Type for each request (ResultWithET<T, ET>, where T - Response type, ET - Error Type)*
 
 ## CocoaPods
 
 Add the following line to your Podfile:
 
 ```rb
 pod 'RestApiManager'
 ```
 
 ## Usage
 
 #### Instance
 
 For use RestApiManager, you can simply create URLSessionRAMDIContainer, and inject it to RestApiManager instance.
 In URLSessionRAMDIContainer you can customize (errorType, urlSession, jsonDecoder, restApiAlert, restApiActivityIndicator, printRequestInfo) properties.
 
 ```swift
 let urlSessionRAMDIContainer = URLSessionRAMDIContainer(errorType: ExampleRestApiError.self, printRequestInfo: true)
 let restApiManager: RestApiManager = URLSessionRestApiManager(urlSessionRAMDIContainer: urlSessionRAMDIContainer)
 ```
 
 #### Create method
 
 For create API method you should realize RestApiMethod and ParametersProtocol protocols.
 
 ```swift
 enum QuestionsRestApiMethods: RestApiMethod {
    // Method
    case getQuestions(QuestionsRestApiParameters)
 
    // URL
    private static let getQuestionsUrl = "questions"
 
    // RestApiData
    var data: RestApiData {
        switch self {
        case .getQuestions(let parameters):
            return RestApiData(url: RestApiConstants.baseURL + QuestionsRestApiMethods.getQuestionsUrl,
                               httpMethod: .get,
                               parameters: parameters,
                               keyPath: RestApiConstants.items)
        }
    }
 }
 ```
 
 ```swift
 struct QuestionsRestApiParameters: ParametersProtocol {
    let order = "desc"
    let sort = "votes"
    let site = "stackoverflow"
 
    var parametersValue: Parameters {
        let parameters: [String: Any] = [
            RestApiConstants.order: order,
            RestApiConstants.sort: sort,
            RestApiConstants.site: site
        ]
 
        return parameters
    }
 }
 ```
 
 #### Call
 
 For create API call, you should create RestApiMethod instance. And send request using some of existing "call" method of RestApiManager.
 
 Create RestApiMethod instance
 
 ```swift
 private let questionsParameters = QuestionsRestApiParameters()
 private let getQuestionsMethod: QuestionsRestApiMethods = .getQuestions(questionsParameters)
 ```
 
 Array response call
 
 ```swift   
 func simpleCall() {
    restApiManager.call(method: getQuestionsMethod) { (result: Result<[StackoverflowItemModel]>) in
        switch result {
        case .success(let obj):
            // some action with success result
        case .failure(let error):
            // some action with failure result
        }
    }
 }
 ```
 
 Call with autoshow indicator and errorAlert
 
 ```swift
 func simpleCallWithIndicatorAndErrorAlert() {
    restApiManager.call(method: getQuestionsMethod, 
                        indicator: true,
                        errorAlert: true) 
    { (result: Result<[StackoverflowItemModel]>) in
        switch result {
        case .success(let obj):
            // some action with success result
        case .failure(let error):
            // some action with failure result
        }
    }
 }
 ```
 
 #### Error handling
 
 For error handling you can use our DefaultRestApiError.
 Or create your own error handling realization. For this, you should implement RestApiError protocol in your class, and inject it in URLSessionRAMDIContainer.
 
 In "handle" method of RestApiError protocol you should realize error parsing method that will return your optional class instance. If you return nil this means that you request will return success response.
 
 ```swift
 final class ExampleRestApiError: RestApiError {
    // MARK: - Properties
    var code: Int
    var details: String
 
    // MARK: - Inits
    convenience init() {
        self.init(code: 0)
    }
 
    convenience init(error: Error) {
        let nsError = error as NSError
        self.init(code: nsError.code, details: nsError.localizedDescription)
    }
 
    convenience init(code: Int) {
        self.init(code: code, details: "")
    }
 
    init(code: Int, details: String) {
        self.code = code
        self.details = details
    }
 
    // MARK: - Handle
 
    /// method for handle error by response, if parse to Error success, method will be return Error
    ///
    /// - Parameters:
    ///   - error: Error?
    ///   - urlResponse: URLResponse?
    ///   - data: Data? for parsing to Error
    /// - Returns: ExampleRestApiError
    static func handle(error: Error?, urlResponse: URLResponse?, data: Data?) -> ExampleRestApiError? {
        if let error = error {
            return ExampleRestApiError(error: error)
        } else if let data = data {
            guard !data.isEmpty else {
                return nil
            }
 
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject],
                    let code = json[RestApiConstants.code] as? Int,
                    let message = json[RestApiConstants.message] as? String {
            
                    let error = ExampleRestApiError(code: code, details: message)   
                        return error    
                } else {
                    return nil
                }
            } catch let error as NSError {
                return ExampleRestApiError(error: error)
            }
        } else {
            return ExampleRestApiError.unknown
        }
    }
 }
 ```
 
 ```swift
 let urlSessionRAMDIContainer = URLSessionRAMDIContainer(errorType: ExampleRestApiError.self)
 let restApiManager: RestApiManager = URLSessionRestApiManager(urlSessionRAMDIContainer: urlSessionRAMDIContainer)
 ```
 
 #### Autoshow error alert
 
 For autoshow error alert you should set in "call" method "indicator" property as "true".
 You can use our DefaultRestApiAlert class for show alert.
 Or create your own alert realization. For this, you should implement RestApiAlert protocol in your class, and inject it in URLSessionRAMDIContainer.
 

 ```swift
 public class ExampleRestApiAlert: RestApiAlert {
    /// init
    public init() {}
 
     /// show
     ///
     /// - Parameter error: RestApiError
     public func show(error: RestApiError) {
        show(title: "Error", message: error.details, completion: nil)
     }
 
     /// show
     ///
     /// - Parameters:
     ///   - title: title of UIAlertController
     ///   - message: message of UIAlertController
     ///   - completion: completion of UIAlertController
     public func show(title: String, message: String, completion: (() -> Void)?) {
     
         guard let rootViewController = UIApplication.presentationViewController else {
            return
         }
         
         let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
         let okAction = UIAlertAction(title: "Ok", style: .default, handler: { [unowned self] _ in
            completion?()
         })
         alert.addAction(okAction)
         rootViewController.present(alert, animated: true, completion: nil)
     }
 }
 ```
 
 #### Autoshow load indicator
 
 For autoshow load indicator you should set in "call" method "indicator" property as "true".
 You can use our DefaultRestApiActivityIndicator class for show indicator.
 Or create your own indicator view realization. For this, you should implement RestApiActivityIndicator protocol in your class, and inject it in URLSessionRAMDIContainer.
 
 ```swift
 func show()
 func show(onView view: UIView)
 func hide()
 ```
 
 ## Example target
 
 You can check more functionality of RestApiManager in [Example](Example) target.
 
 ## License
 
 RestApiManager is released under an MIT license. See [License](LICENSE.txt) for more information.

