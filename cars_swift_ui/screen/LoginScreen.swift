//
//  LoginScreen.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 12.02.25.
//

import SwiftUI
import GoogleSignIn

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
    @State private var showAlertErrorSignUp: Bool = false
    @State private var errorMessageSignUp: String = ""
    
    var size: CGSize
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer(minLength: 40)
                
                GeometryReader {
                    let size = $0.size
                    
                    Image(intro.introImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: (intro.lastScreenSignUp || intro.lastScreenLogIn ? size.width * 0.5 : size.width), height: (intro.lastScreenSignUp || intro.lastScreenLogIn ? size.width * 0.5 : size.width))
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                        .frame(maxWidth: .infinity)
                }
                .offset(y: showView ?  0 : -size.height / 2)
                .opacity(showView ? 1 : 0)
                
                
                VStack {
                    Spacer(minLength: (pageIntros.firstIndex(of: intro) == pageIntros.count - 1) ? 40 : 80)
                    Text(intro.title)
                        .font(.title)
                        .bold()
                    
                    //TODO: add name for signing up with email and password
                    //TODO: experience is cut on device
                                        
                    if intro.lastScreenLogIn || intro.lastScreenSignUp {
                        VStack(spacing: 20) {
                            LoginTextFieldView(text: $email, hint: "Email", icon: Image(systemName: "mail"))
                            LoginTextFieldView(text: $password, hint: "Password", icon: Image(systemName: "key"), isPassword: true)
                            
                            Text("\nAlternatively with your desired service")
                            
                            //TODO: add sign in with apple
                            
                            HStack(spacing: 30) {
                                LogInButtonView(imageName: "google_logo") {
                                    //TODO: perhaps extract in method/viewcontroller
                                    Task {
                                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                              let rootViewController = windowScene.windows.first?.rootViewController else {
                                            print("Fehler: Root View Controller nicht gefunden.")
                                            return
                                        }

                                        let (success, error) = await authenticationViewModel.signInWithGoogle(presentingViewController: rootViewController)
                                                    
                                        if !success {
                                            showAlertErrorSignUp = true
                                            errorMessageSignUp = error
                                        }
                                    }
                                        
                                }
                                LogInButtonView(systemImageName: "apple.logo") {
                                    print("test")
                                }
                                LogInButtonView(imageName:"github_logo") {
                                    Task {
                                        let (success, error) = await authenticationViewModel.signInWithGithub()
                                        if !success {
                                            showAlertErrorSignUp = true
                                            errorMessageSignUp = error
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer(minLength: 20)
                    
                    Group {
                        
                        LoginCustomIndicatorView(totalPages: pageIntros.count, currentPage: intro.lastScreenLogIn ? pageIntros.count - 2 : pageIntros.firstIndex(of: intro) ?? 0)
                        
                        Spacer(minLength: 20)
                        
                        if intro.decisionSignUpOrLogIn {
                            HStack {
                                Button {
                                    changeIntro()
                                } label: {
                                    customButton(text: "Sign up")
                                }
                                
                                Button {
                                    changeIntro(showLogIn: true)
                                } label: {
                                    customButton(text: "Log in")
                                }
                            }
                        } else {
                            Button(action: {
                                if intro.lastScreenLogIn {
                                    Task {
                                        let success = await authenticationViewModel.signInWithEmailPassword(email: email, password: password)
                                       if !success {
                                            showAlertWrongCredentials = true
                                            print("Login fehlgeschlagen")
                                        }
                                    }
                                } else if intro.lastScreenSignUp {
                                    Task {
                                        let (success, errorMsg) = await authenticationViewModel.signUpWithEmailPassword(email: email, password: password)
                                        if !success {
                                            errorMessageSignUp = errorMsg
                                            showAlertErrorSignUp = true
                                            print("Login fehlgeschlagen")
                                        }
                                    }
                                } else {
                                    changeIntro()
                                }
                            }) {
                                customButton(text: intro.lastScreenLogIn || intro.lastScreenSignUp ? "Done" : "Next")
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
            .alert(isPresented: $showAlertErrorSignUp, content: {
                Alert(title: Text("Sign up failed"), message: Text("Sign up was not possible due to the following error\n\(errorMessageSignUp)"), dismissButton: .default(Text("Try again")))
            })
        }
    }
    
    func customButton(text: String) -> some View {
        Text(text)
            .frame(width: size.width * 0.35)
            .foregroundColor(.white)
            .padding()
            .background {
                Capsule()
                    .foregroundColor(Color("contrastColor").opacity(0.6))
            }
    }
    
    //TODO: shouldn´t this be in a ViewModel?!
    func changeIntro(goBack: Bool = false, showLogIn: Bool = false) {
        withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0).delay(0.1)) {
            hideWholeView = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            
         
            
            if let index = pageIntros.firstIndex(of: intro){
                if(goBack) {
                    if(index == pageIntros.count - 1) {intro = pageIntros[index - 2]}
                    else {intro = pageIntros[index - 1]}
                }
                else if(index != pageIntros.count - 1) {
                    if(showLogIn) {
                        intro = pageIntros[pageIntros.count - 1]
                    } else {
                        intro = pageIntros[index + 1]
                    }
                }
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
