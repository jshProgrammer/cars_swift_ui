//
//  LoginScreen.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 12.02.25.
//

import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject var authenticationViewModel: AuthViewModel
    @State private var activeIntro: PageIntro = pageIntros[0]
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            IntroView(intro: $activeIntro, size: size)
                
        }
    }
}

struct IntroView: View {
    @EnvironmentObject var authenticationViewModel: AuthViewModel
    
    @Binding var intro: PageIntro
    @State var showView: Bool = false
    @State var hideWholeView: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State private var showAlertWrongCredentials: Bool = false
        
    
    var size: CGSize
    
    var body: some View {
        NavigationStack {
            /*NavigationLink(
                destination: LoggedInScreen(),
                isActive: $navigateToLoggedInScreen
            ) {
                EmptyView()
            }*/
            
            VStack {
                Spacer(minLength: 40)
                
                GeometryReader {
                    let size = $0.size
                    
                    Image(intro.introImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.width)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                }
                .offset(y: showView ?  0 : -size.height / 2)
                .opacity(showView ? 1 : 0)
                
                
                VStack {
                    Spacer(minLength: (pageIntros.firstIndex(of: intro) == pageIntros.count - 1) ? 40 : 80)
                    Text(intro.title)
                        .font(.title)
                        .bold()
                    
                    
                    if intro.lastScreen {
                        VStack(spacing: 20) {
                            LoginTextFieldView(text: $email, hint: "Email", icon: Image(systemName: "mail"))
                            LoginTextFieldView(text: $password, hint: "Password", icon: Image(systemName: "key"), isPassword: true)
                        }
                    }
                    
                    Spacer(minLength: 20)
                    
                    Group {
                        
                        LoginCustomIndicatorView(totalPages: pageIntros.count, currentPage: pageIntros.firstIndex(of: intro) ?? 0)
                        
                        Spacer(minLength: 20)
                        
                        Button(action: {
                            if intro.lastScreen {
                                Task {
                                    let success = await authenticationViewModel.signInWithEmailPassword(email: email, password: password)
                                    if success {
                                        print("Login erfolgreich")
                                    } else {
                                        showAlertWrongCredentials = true
                                        print("Login fehlgeschlagen")
                                    }
                                }
                            } else {
                                changeIntro()
                            }
                        }) {
                            Text(intro.lastScreen ? "Done" : "Next")
                                .frame(width: size.width * 0.35)
                                .foregroundColor(.white)
                                .padding()
                                .background {
                                    Capsule()
                                        .foregroundColor(Color.black.opacity(0.6))
                                }
                        }
                    }.frame(alignment: .center)
                }
                .offset(y: showView ? 0 : size.height / 2)
                .opacity(showView ? 1 : 0)
            }
            .onAppear() {
                withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0).delay(0.1)) {
                    showView = true
                }
            }
            .overlay(alignment: .topLeading) {
                if intro != pageIntros.first {
                    Button {
                        changeIntro(goBack: true)
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .contentShape(Rectangle())
                    }
                }
            }
            .padding()
            .offset(y: hideWholeView ? size.height : 0)
            .opacity(hideWholeView ? 0 : 1)
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { output in
                if let info = output.userInfo, let height = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
                    keyboardHeight = height
                }
            }
            .ignoresSafeArea(.keyboard, edges: .all)
            .offset(y: -keyboardHeight)
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification), perform: { _ in
                keyboardHeight = 0
            })
            .animation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0), value: keyboardHeight)
            .alert(isPresented: $showAlertWrongCredentials, content: {
                Alert(title: Text("Login failed"), message: Text("It seems as if your credentials are incorrect or the server is not working properly"), dismissButton: .default(Text("Try again")))
            })
            
        }
    }
    
    func changeIntro(goBack: Bool = false) {
        withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0).delay(0.1)) {
            hideWholeView = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if let index = pageIntros.firstIndex(of: intro){
                if(goBack) { intro = pageIntros[index - 1] }
                else if(index != pageIntros.count - 1) { intro = pageIntros[index + 1] }
                else { intro = pageIntros[pageIntros.count - 1] }
            }
            
            hideWholeView = false
            showView = false
            
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0).delay(0.1)) {
                showView = true
            }
        }
    }
}

#Preview {
    LoginScreen()
        .environmentObject(AuthViewModel())
}
