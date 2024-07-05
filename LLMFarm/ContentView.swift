//
//  ContentView.swift
//  ChatUI
//
//  Created by Shezad Ahamed on 03/08/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tabSelection = 0
    @Binding var chat_selected: Bool
    @Binding var model_name: String
    @Binding var chat_name: String
    @Binding var title: String
    
    var body: some View {
        
        //Bottom tab
        TabView(selection: $tabSelection)  {
            
            //Chat
            ChatListView(tabSelection: $tabSelection,chat_selected: $chat_selected,model_name:$model_name,chat_name:$chat_name,title: $title)
                .tabItem {
                    Image(systemName: "bubble.left.and.bubble.right")
                }
                .tag(0)

            ModelsView()
                .tabItem {
                    Image(systemName: "person.2")
                }
                .tag(2)
            //Settings
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                }
                .tag(3)
        }
        .accentColor(Color("color_primary"))
    }
}
