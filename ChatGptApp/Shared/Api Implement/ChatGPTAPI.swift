//
//  ChatWidget.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/10/23.
//
import Foundation
import UIKit
import OpenAIKit

struct Response: Decodable {
    let data: [ImageURL]
}

struct ImageURL: Decodable {
    let url: String
}

enum APIError: Error {
    case unableToCreateImageURL
    case unableToConvertDataIntoImage
    case unableToCreateURLForURLRequest
}
class ChatGPTAPI: @unchecked Sendable {
    
    private let systemMessage: Message
    private let temperature: Double
    private let model: String
    let organizationName: String = "org-Ui8CUoYPhIGTXMtWIfBLEGcT"
    let openAI:OpenAIKit?
    private var apiKey: String
    private var historyList = [Message]()
    private let urlSession = URLSession.shared
    private var urlRequest: URLRequest {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        headers.forEach {  urlRequest.setValue($1, forHTTPHeaderField: $0) }
        return urlRequest
    }
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        return df
    }()
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    private var headers: [String: String] {
        [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
    }
    

    init(apiKey: String, model: String = "gpt-3.5-turbo", systemPrompt: String = "You are a helpful assistant", temperature: Double = 0.5) {
        self.apiKey = apiKey
        self.model = model
        self.systemMessage = .init(role: "system", content: systemPrompt)
        self.temperature = temperature

        /// Initialize OpenAIKit with your API Token wherever convenient in your project. Organization name is optional.
        openAI = OpenAIKit(apiToken: self.apiKey, organization: organizationName,sslCerificatePath: Bundle.main.path(forResource: "MyCert", ofType: "cer"))
    }
    
    private func generateMessages(from text: String) -> [Message] {
        var messages = [systemMessage] + historyList + [Message(role: "user", content: text)]
        
        if messages.contentCount > (4000 * 4) {
            _ = historyList.removeFirst()
            messages = generateMessages(from: text)
        }
        return messages
    }
    
    private func jsonBody(text: String, stream: Bool = true) throws -> Data {
        let request = Request(model: model, temperature: temperature,
                              messages: generateMessages(from: text), stream: stream)
        return try JSONEncoder().encode(request)
    }
    
    private func appendToHistoryList(userText: String, responseText: String) {
        self.historyList.append(.init(role: "user", content: userText))
        self.historyList.append(.init(role: "assistant", content: responseText))
    }
    
    func refreshKey(key:String) {
        self.apiKey = key
    }
    
    func sendMessageStream(text: String) async throws -> Result<AIResponseModel, Error> {
        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<Result, Error>) in
            openAI?.sendChatCompletion(newMessage: AIMessage(role: .user, content: text), previousMessages: [], model: .gptV3_5(.gptTurbo), maxTokens: 2048, n: 1, completion: { [weak self] result in
                continuation.resume(returning: result)
                
            })
        })
        
//        var urlRequest = self.urlRequest
//        urlRequest.httpBody = try jsonBody(text: text)
//        
//        let (result, response) = try await urlSession.bytes(for: urlRequest)
//        
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw "Invalid response"
//        }
//        
//        guard 200...299 ~= httpResponse.statusCode else {
//            var errorText = ""
//            for try await line in result.lines {
//                errorText += line
//            }
//            
//            if let data = errorText.data(using: .utf8), let errorResponse = try? jsonDecoder.decode(ErrorRootResponse.self, from: data).error {
//                errorText = "\n\(errorResponse.message)"
//            }
//            
//            throw "Bad Response: \(httpResponse.statusCode), \(errorText)"
//        }
//        
//        return AsyncThrowingStream<String, Error> { continuation in
//            Task(priority: .userInitiated) { [weak self] in
//                guard let self else { return }
//                do {
//                    var responseText = ""
//                    for try await line in result.lines {
//                        if line.hasPrefix("data: "),
//                           let data = line.dropFirst(6).data(using: .utf8),
//                           let response = try? self.jsonDecoder.decode(StreamCompletionResponse.self, from: data),
//                           let text = response.choices.first?.delta.content {
//                            responseText += text
//                            continuation.yield(text)
//                        }
//                    }
//                    self.appendToHistoryList(userText: text, responseText: responseText)
//                    continuation.finish()
//                } catch {
//                    continuation.finish(throwing: error)
//                }
//            }
//        }
    }

    func sendMessage(_ text: String) async throws -> String {
        var urlRequest = self.urlRequest
        urlRequest.httpBody = try jsonBody(text: text, stream: false)
        
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw "Invalid response"
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
            var error = "Bad Response: \(httpResponse.statusCode)"
            if let errorResponse = try? jsonDecoder.decode(ErrorRootResponse.self, from: data).error {
                error.append("\n\(errorResponse.message)")
            }
            throw error
        }
        
        do {
            let completionResponse = try self.jsonDecoder.decode(CompletionResponse.self, from: data)
            let responseText = completionResponse.choices.first?.message.content ?? ""
            self.appendToHistoryList(userText: text, responseText: responseText)
            return responseText
        } catch {
            throw error
        }
    }
    
    func deleteHistoryList() {
        self.historyList.removeAll()
    }
    
    func fetchImageForPrompt(_ prompt: String) async throws -> Result<ImagesResponse, Error> {
        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<Result, Error>) in
            openAI?.sendImagesRequest(prompt: prompt, size: .size512, n: 1) { [weak self] result in
                continuation.resume(returning: result)
            }
        })
        
//        let fetchImageURL = "https://api.openai.com/v1/images/generations"
//        let urlRequest = try createURLRequestFor(httpMethod: "POST", url: fetchImageURL, prompt: prompt)
//
//        let (data, response) = try await URLSession.shared.data(for: urlRequest)
//      
//        let decoder = JSONDecoder()
//        let results = try decoder.decode(Response.self, from: data)
//
//        let imageURL = results.data[0].url
//        guard let imageURL = URL(string: imageURL) else {
//            throw APIError.unableToCreateImageURL
//        }
//        
//        let (imageData, imageResponse) = try await URLSession.shared.data(from: imageURL)
//        
//        guard let image = UIImage(data: imageData) else {
//            throw APIError.unableToConvertDataIntoImage
//        }
//        
//        return image
    }
    
    private func createURLRequestFor(httpMethod: String, url: String, prompt: String) throws -> URLRequest {
        guard let url = URL(string: url) else {
            throw APIError.unableToCreateURLForURLRequest
        }
        
        var urlRequest = URLRequest(url: url)
        
        // Method
        urlRequest.httpMethod = httpMethod
        
        // Headers
        urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
       
        
        // Body
        let jsonBody: [String: Any] = [
            "prompt": "\(prompt)",
            "n": 1,
            "size": "1024x1024"
        ]
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: jsonBody)
        
        return urlRequest
    }
    
    
    func isValidAPIKey() async -> Bool {
        
        do {
            _ = try await self.sendMessageStream(text: "hello")
            return true
            
        } catch {
            return false
        }
        
    }
    
    
}

extension String: CustomNSError {
    
    public var errorUserInfo: [String : Any] {
        [
            NSLocalizedDescriptionKey: self
        ]
    }
}


