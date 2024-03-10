//
//  ContentView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/8.
//




import SwiftUI

struct ContentView: View {
   
    private let fireDBHelper = FireDBHelper.getInstance()
    var fireAuthHelper = FireAuthHelper()
    
    @State private var rootScreen : RootScreen = .Login
    var body: some View {
        NavigationStack{
            switch(rootScreen){
            case .Login:
                LoginView(rootScreen: $rootScreen)
                    .environmentObject(fireDBHelper)
                    .environmentObject(fireAuthHelper)
            case .Main:
                HomeView(rootScreen: $rootScreen)
                    .environmentObject(fireDBHelper)
                    .environmentObject(fireAuthHelper)
            case .SignUp:
                SignInView(rootScreen: $rootScreen)
                    .environmentObject(fireDBHelper)
                    .environmentObject(fireAuthHelper)
            }
        }//NavigationView
        
        
    }

}

#Preview {
    ContentView()
}
