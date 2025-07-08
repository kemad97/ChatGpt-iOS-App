import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        NavigationView {
            
          
                VStack(spacing: 0) {
                    if viewModel.messages.isEmpty {
                        ZStack{
                            Text("What's on the agenda today?")
                                .frame(maxWidth: .infinity, maxHeight: 1000, alignment: .center)
                                .foregroundColor(.gray)
                        }
                    }
                    
                  
                    
                    ScrollView {
                        VStack {
                            
                            Spacer() // Push content to bottom
                            ForEach(viewModel.messages) { message in
                                Text(message.content)
                                    .padding()
                                    .background(message.isUser ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                                    .frame(maxWidth: .infinity, alignment: message.isUser ? .trailing : .leading)
                                    .padding(.horizontal)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .overlay(
                        Group {
                            if viewModel.isLoading {
                                ProgressView()
                            }
                        }
                    )
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    HStack {
                        TextField("Enter your prompt", text: $viewModel.prompt)
                            .lineLimit(20)
                        
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading)
                        
                        
                        Button(action: {
                            Task {
                                await viewModel.sendPrompt()
                            }
                        }) {
                            Image(systemName: "paperplane.fill")
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(viewModel.isLoading ? Color.gray : Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .disabled(viewModel.isLoading)
                        .padding(.trailing)
                    }
                    .padding(.vertical, 8)
                    .background(Color(.systemBackground))
                    .padding(.bottom, keyboardHeight) // Adjust for keyboard
                }
            
            .navigationTitle("ChatGPT App")
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
