//
//  StartSwiftUIView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 24.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI
import MessageUI

struct StartSwiftUIView: View {
    
    @EnvironmentObject var appState: AppState
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var navBarHidden = false
    
    @State var isShowingDirectionsView: Bool = false
    @State var isShowingDealingView: Bool = false
    @State var isShowingSavedResultsView: Bool = false
    @State var isShowingSettingsView: Bool = false
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView: Bool = false
    
    init() {
        Theme.currentBackgroundColor = Theme.colorChoices[UserDefaults.standard.integer(forKey: "SelectedTheme")]
        Theme.currentBackgroundColorUI = Theme.colorChoicesUI[UserDefaults.standard.integer(forKey: "SelectedTheme")]
    }
    
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    Group {
                        
                        Spacer()
                        
                        Text("Decision Poker")
                            .fontWeight(.bold)
                            .scaledFont(name: Theme.currentFont, size: 38)
                            .foregroundColor(Theme.currentTextColor)
                            .padding(.top)
                        
                        Image(Theme.startImage)
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                    
                    Spacer()
                    
                    VStack {
                        NavigationLink(destination: DirectionsSwiftUIView(), isActive: $isShowingDirectionsView) { EmptyView() }
                        
                        Button(action: {
                            self.isShowingDirectionsView = true
                        }){
                            Text("Directions")
                                .scaledFont(name: Theme.currentFont, size: 18)
                        }.buttonStyle(StartViewButtonStyle(backcolor: Theme.currentButtonBackgroundColor, forecolor: Theme.currentBackgroundColor))
                    }
                    
                    Spacer()
                    
                    VStack {
                        NavigationLink(destination: DecksSwiftUIView(), isActive: $isShowingDealingView) { EmptyView() }
                        
                        Button(action: {
                            self.isShowingDealingView = true
                        }){
                            Text("Start Dealing Decisions!")
                                .scaledFont(name: Theme.currentFont, size: 18)
                                .font(.headline)
                        }.buttonStyle(StartViewButtonStyle(backcolor: Theme.currentButtonBackgroundColor, forecolor: Theme.currentBackgroundColor))
                    }
                    
                    Spacer()
                    
                    VStack {
                        NavigationLink(destination: SavedResultsSwiftUIView(showBackButton: .constant(false)) , isActive: $isShowingSavedResultsView) { EmptyView() }
                        
                        Button(action: {
                            self.isShowingSavedResultsView = true
                        }){
                            Text("Saved Decisions")
                                .scaledFont(name: Theme.currentFont, size: 18)
                        }.buttonStyle(StartViewButtonStyle(backcolor: Theme.currentButtonBackgroundColor, forecolor: Theme.currentBackgroundColor))
                    }
                    
                    Spacer()
                    
                    VStack {
                        
                        Button(action: {
                            self.isShowingMailView.toggle()
                            print("tapped")
                        }){
                            Text("Contact Us")
                                .scaledFont(name: Theme.currentFont, size: 18)
                        }
                        .disabled(!MFMailComposeViewController.canSendMail())
                        .sheet(isPresented: $isShowingMailView) {
                            MailView(result: self.$result) 
                        }
                        .buttonStyle(StartViewButtonStyle(backcolor: Theme.currentButtonBackgroundColor, forecolor: Theme.currentBackgroundColor))
                    }
                    
                    Spacer()
                        .navigationBarTitle("", displayMode: .inline)
                }
                .navigationBarHidden(self.navBarHidden)
                .onAppear(perform: {
                    self.navBarHidden = true
                })
                .onDisappear(perform: {
                    self.navBarHidden = false
                })
                .onReceive(self.appState.$moveToRoot, perform: {moveToRoot in
                    if moveToRoot {
                        self.isShowingDealingView = false
                        self.isShowingSettingsView = false
                        self.appState.moveToRoot = false
                        
                    }
                })
                .background(Theme.currentBackgroundColor)
                
                VStack {
                    
                    Spacer()
                    
                    HStack {
                        
                        Spacer()
                        
                        Group {
                            
                        NavigationLink(destination: SettingsUIView(), isActive: $isShowingSettingsView) { EmptyView() }
                        
                        Button(action: {
                            self.isShowingSettingsView = true
                        }){
                            Image(systemName: "gear")
                                .imageScale(.large)
                        }.buttonStyle(StartViewButtonStyleCircle(backcolor: Theme.currentButtonBackgroundColor, forecolor: Theme.currentBackgroundColor))
                        .padding()
                        }
                    }
                }
            }
            
            .background(Theme.currentBackgroundColor)
            .edgesIgnoringSafeArea(.all)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
