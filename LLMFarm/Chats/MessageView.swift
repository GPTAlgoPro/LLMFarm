//
//  MessageView.swift
//  AlpacaChatApp
//
//  Created by Yoshimasa Niwa on 3/20/23.
//

import SwiftUI
import MarkdownUI


struct MessageView: View {
    var message: Message

    private struct SenderView: View {
        var sender: Message.Sender
        var current_model = "LLM"
        
        var body: some View {
            switch sender {
            case .user:
                HStack{
                    Image("sk")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .cornerRadius(6)
                    Text("You")
                        .font(.caption)
                        .foregroundColor(.accentColor)
                }
            case .system:
                HStack{
                    Image("ava0")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .cornerRadius(6)
                    Text("Bot")
                        .font(.caption)
                        .foregroundColor(.accentColor)
                }
            }
        }
    }

    private struct MessageContentView: View {
        var message: Message

        var body: some View {
            switch message.state {
            case .none:
                ProgressView()

            case .error:
                Text(message.text)
                    .foregroundColor(Color.red)
                    .textSelection(.enabled)

            case .typed:
                VStack(alignment: .leading) {
                    if message.header != ""{
                        Text(message.header)
                            .font(.footnote)
                            .foregroundColor(Color.gray)
                    }
                    MessageImage(message: message)
                    Text(LocalizedStringKey(message.text))
                        .textSelection(.enabled)
                }

            case .predicting:
                HStack {
                    Text(message.text).textSelection(.enabled)
                    ProgressView()
                        .padding(.leading, 3.0)
                        .frame(maxHeight: .infinity,alignment: .bottom)
                }.textSelection(.enabled)

            case .predicted(totalSecond: let totalSecond):
                VStack(alignment: .leading) {
//                    Text(LocalizedStringKey(message.text)).textSelection(.enabled)
                    Markdown(message.text)
                        .markdownBlockStyle(\.codeBlock) { label in
                            ScrollView(.vertical) {
                                label
                                  .relativeLineSpacing(.em(0.25))
                                  .markdownTextStyle {
                                    FontFamilyVariant(.monospaced)
                                    FontSize(.em(0.85))
                                      ForegroundColor(.green)
                                  }
                                  .padding()
                              }
                            .background(Color(.black))
                              .clipShape(RoundedRectangle(cornerRadius: 10))
                              .markdownMargin(top: .zero, bottom: .em(0.8))
                            }
                        .textSelection(.enabled)
//                        .markdownTheme(.docC)
                    Text(String(format: "%.2f ses, %.2f t/s", totalSecond,message.tok_sec))
                        .font(.footnote)
                        .foregroundColor(Color.gray)
                }.textSelection(.enabled)
            }
        }
    }

    var body: some View {
        HStack {
            if message.sender == .user {
                Spacer()
            }

            VStack(alignment: .leading, spacing: 6.0) {
                SenderView(sender: message.sender)
                MessageContentView(message: message)
                    .padding(12.0)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(12.0)
            }

            if message.sender == .system {
                Spacer()
            }
        }
    }
}
