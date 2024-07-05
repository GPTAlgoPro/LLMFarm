//
//  SettingsView.swift
//  LLMFarm
//
//  Created by guinmoon on 01.11.2023.
//

import SwiftUI


struct SettingsView: View {
    @EnvironmentObject var fineTuneModel: FineTuneModel
    let app_version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    @Binding var current_detail_view_name:String?
    @State var settings_menu_items = [
        ["icon":"square.stack.3d.up.fill","value":"Models","name":"Models"],
//        ["icon":"square.stack.3d.up.fill","value":"LoRA","name":"LoRA Adepters"],
//        ["icon":"square.stack.3d.up.fill","value":"Settings","name":"App Settings"]
    ]

    var body: some View {
        NavigationStack {
            //            Color("color_bg").edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 5){
                HStack{
                    Text("Settings")
                        .fontWeight(.semibold)
                        .font(.title2)
                }
                .padding(.top)
                .padding(.horizontal)
                
                VStack(){
                    List(){
                        NavigationLink("Manage models"){
                            ModelsView("models")
                        }
                        NavigationLink("Download models"){
                            DownloadModelsView()
                        }
                        NavigationLink("LoRA Adapters"){
                            ModelsView("lora_adapters")
                        }
                        NavigationLink("Fine Tune"){
                            FineTuneView().environmentObject(fineTuneModel)
                        }
                        NavigationLink("Merge Lora"){
                            ExportLoraView().environmentObject(fineTuneModel)
                        }
//                        ForEach(settings_menu_items, id: \.self) { settings_menu_item in
//                            NavigationLink(settings_menu_item["value"]!){
////                                ModelsView()
//                                SettingsMenuItem(icon:settings_menu_item["icon"]!,name:settings_menu_item["name"]!,current_detail_view_name:$current_detail_view_name)
//                            }
//                        }
                    }
                    .frame(maxHeight: .infinity)
                    .listStyle(InsetListStyle())
                }
                
                Divider()
                VStack{
                    HStack{
                        Image("llama_cute")
                            .resizable()
                            .font(.system(size: 40))
                            .frame(width: 72, height: 72)
                            .cornerRadius(9)
                    }
                    .buttonStyle(.borderless)
                    .controlSize(.large)
                    Divider()
                    Text("大模型农场 v\(app_version)\n作者：孙凯（基于LLFarm）, 2024-7-4")
//                        .foregroundColor(.accentColor)
                        .font(.footnote)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity,alignment: .center)
            }
        }
        .navigationTitle("Settings")
    }
}
