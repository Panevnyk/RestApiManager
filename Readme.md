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
 
 For RestApiManager, use the following entry in your Podfile:
 
 ```rb
 pod 'RestApiManager'
 ```
 
 Then run `pod install`.
 
 In any file you'd like to use RestApiManager in, don't forget to
 import the framework with `import RestApiManager`.
 
 ## License
 
 RestApiManager is released under an MIT license. See [License.txt](License.txt) for more information.
