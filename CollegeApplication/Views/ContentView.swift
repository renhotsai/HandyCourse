//
//  ContentView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/2/8.
//




import SwiftUI

struct ContentView: View {
    
    @State private var rootScreen : RootScreen = .Login
    @State private var user : User = Student(name: "Amy", username: "amy", password: "amy", email: "amy@gmail.com", address: "30 SodaStream Rd.", phoneNumber: "2346451234")
    var body: some View {
        NavigationStack{
            switch(rootScreen){
            case .Login:
                LoginView(rootScreen: $rootScreen)
            case .Main:
                HomeView(rootScreen: $rootScreen).environmentObject(user)
            }
        }//NavigationView
        
    }

}

#Preview {
    ContentView()
}
