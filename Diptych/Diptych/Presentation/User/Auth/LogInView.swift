//
//  LogInView.swift
//  Diptych
//
//  Created by HAN GIBAEK on 2023/07/13.
//

import SwiftUI

struct LogInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var userViewModel: UserViewModel
    var body: some View {
        ZStack {
            Color.offWhite
                .ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(height: 124)
                Text("로그인")
                    .font(.pretendard(.light, size: 28))
                Spacer()
                //                        .frame(height: 138)
                VStack(spacing: 37) {
                    VStack(alignment: .leading) {
                        TextField("이메일", text: $email)
                            .font(.pretendard(.light, size: 18))
                            .foregroundColor(.darkGray)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                        Divider()
                    }
                    VStack(alignment: .leading) {
                        SecureField("비밀번호", text: $password)
                            .font(.pretendard(.light, size: 18))
                            .foregroundColor(.darkGray)
                        Divider()
                    }
                }
                .padding([.leading, .trailing], 15)
                Spacer()
                    .frame(height: 33)
                HStack {
                    Button{
                        print("pass: 아이디 찾기")
                    } label: {
                        Text("아이디 찾기")
                            .font(.pretendard(.thin, size: 15))
                            .foregroundColor(.darkGray)
                    }
                    Text("|")
                        .font(.pretendard(.thin, size: 15))
                        .foregroundColor(.darkGray)
                    Button{
                        print("pass: 비밀번호 찾기")
                    } label: {
                        Text("비밀번호 찾기")
                            .font(.pretendard(.thin, size: 15))
                            .foregroundColor(.darkGray)
                    }
                }
                Spacer()
                Button {
                    Task {
                        try await userViewModel.signInWithEmailPassword(email: email, password: password)
                    }
                } label: {
                    Text("로그인")
                        .frame(width: UIScreen.main.bounds.width-30, height:  60)
                        .background(Color.offBlack)
                        .foregroundColor(.offWhite)
                }
//                NavigationLink(destination: EmailVerificationView()) {
//                    Text("로그인")
//                        .frame(width: UIScreen.main.bounds.width-30, height:  60)
//                        .background(Color.offBlack)
//                        .foregroundColor(.offWhite)
//                }
                Spacer()
                    .frame(height: 47)
            }
            .ignoresSafeArea()
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
            .environmentObject(UserViewModel())
    }
}
