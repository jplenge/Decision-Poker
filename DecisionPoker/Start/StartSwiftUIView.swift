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
    
    @State var result: Result<MFMailComposeResult, Error>?
    @State var isShowingMailView: Bool = false
    
    init() {
        theme.currentBackgroundColor = theme.colorChoices[UserDefaults.standard.integer(forKey: "SelectedTheme")]
        theme.currentBackgroundColorUI = theme.colorChoicesUI[UserDefaults.standard.integer(forKey: "SelectedTheme")]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Group {
                        
                        Spacer()
                        
                        Text("Decision Poker")
                            .fontWeight(.bold)
                            .scaledFont(name: theme.currentFont, size: 38)
                            .foregroundColor(theme.currentTextColor)
                            .padding(.top)
                        
                        Image(theme.startImage)
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                    
                    Spacer()
                    
                    VStack {
                        NavigationLink(destination: DirectionsSwiftUIView(), isActive: $isShowingDirectionsView) { EmptyView() }
                        
                        Button(action: {
                            self.isShowingDirectionsView = true
                        }, label: {
                            Text("Directions")
                                .scaledFont(name: theme.currentFont, size: 18)
                        })
                        .buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
                    }
                    
                    Spacer()
                    
                    VStack {
                        NavigationLink(destination: DecksSwiftUIView(), isActive: $isShowingDealingView) { EmptyView() }
                        
                        Button(action: {
                            self.isShowingDealingView = true
                        }, label: {
                            Text("Start Dealing Decisions!")
                                .scaledFont(name: theme.currentFont, size: 18)
                                .font(.headline)
                        })
                        .buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
                    }
                    
                    Spacer()
                    
                    VStack {
                        NavigationLink(destination: SavedResultsSwiftUIView(showBackButton: .constant(false)),
                                       isActive: $isShowingSavedResultsView) { EmptyView() }
                        
                        Button(action: {
                            self.isShowingSavedResultsView = true
                        }, label: {
                            Text("Saved Decisions")
                                .scaledFont(name: theme.currentFont, size: 18)
                        })
                        .buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
                    }
                    
                    Spacer()
                    
                    VStack {
                        
                        Button(action: {
                            self.isShowingMailView.toggle()
                            print("tapped")
                        }, label: {
                            Text("Contact Us")
                                .scaledFont(name: theme.currentFont, size: 18)
                        })
                        .disabled(!MFMailComposeViewController.canSendMail())
                        .sheet(isPresented: $isShowingMailView) {
                            MailView(result: self.$result) 
                        }
                        .buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
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
                
                VStack {
                    
                    Spacer()
                    
                    HStack {
                        
                        Spacer()
                        
                        Group {
                            
                        NavigationLink(destination: SettingsUIView(), isActive: $isShowingSettingsView) { EmptyView() }
                        
                        Button(action: {
                            self.isShowingSettingsView = true
                        }, label: {
                            Image(systemName: "gear")
                                .imageScale(.large)
                        })
                        .buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
                        .padding()
                        }
                    }
                }
            }
            .background(theme.currentBackgroundColor)
            .edgesIgnoringSafeArea(.all)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct StartSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        StartSwiftUIView().environmentObject(AppState())
    }
}
