import OpenAI
import Foundation

@MainActor
class ChatViewModel: ObservableObject {
    @Published var prompt: String = ""
    @Published var messages: [ChatMessage] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let openAI = OpenAI(apiToken: Config.openAIAPIKey)

    func sendPrompt() async {
        guard !prompt.isEmpty else {
            errorMessage = "Please enter a prompt."
            return
        }

        // Add user prompt to messages
        let userMessage = ChatMessage(isUser: true, content: prompt)
        messages.append(userMessage)
        let currentPrompt = prompt
        prompt = "" // Clear input field

        isLoading = true
        errorMessage = nil

        do {
            let query = ChatQuery(
                messages: [ChatQuery.ChatCompletionMessageParam(role: .user, content: currentPrompt)!],
                model: "gpt-4o", // String for model
                temperature: 0.7 // Balanced creativity
            )
            let result = try await openAI.chats(query: query)
            if let content = result.choices.first?.message.content {
                let aiMessage = ChatMessage(isUser: false, content: content)
                messages.append(aiMessage)
            } else {
                errorMessage = "No response received."
            }
        } catch {
            errorMessage = "Error: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
