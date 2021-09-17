//
//  ContentView.swift
//  Classic05
//
//  Created by kai wen chen on 2021/9/17.
//

import SwiftUI

struct ContentView: View {
    
    @State var demo = msgs
    @State var speak = ""
    
    @State var onOff = true
    
    var body: some View {
        VStack {
            List(demo){ item in
                if (item.isMyTalk == false) {
                    LeftMsg(item: item.speak)
                }else{
                    RightMsg(item: item.speak)
                }
                
            }
            HStack {
                TextField("內容", text: $speak)
                GradientButton(text: "送出對話") {
                    print("debug")
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct RightMsg: View {

    var item:String
    
    var body: some View {
        HStack {
            Spacer()
            HStack{
                Text("\(item)")
                Image("Head")
                    .resizable()
                    .frame(width: 60, height: 60, alignment: .center)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct LeftMsg: View {
    
    var item:String
    
    var body: some View {
        HStack{
            Image(systemName: "faceid")
                .font(.system(size: 40))
            Text("\(item)")
        }
    }
}


struct msg:Identifiable {
    var id = UUID()
    var speak:String
    var isMyTalk = false
}

let msgs = [msg(speak: "你好 !")]

struct GradientButton: View {
    
    var text:String
    
    var complete:()->Void
    
    var body: some View {
        Button(action: {
            complete()
        }, label: {
            GeometryReader(content: { geometry in
                ZStack{
                    AngularGradient(gradient: Gradient(colors: [Color.red, Color.blue]), center: .center, angle: .degrees(0))
                        .blendMode(.overlay)
                        .blur(radius: 8.0)
                        .mask(
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: geometry.size.width, height: 50)
                                .blur(radius: 8.0)
                        )
                    GradientText(text: text)
                        .font(.headline)
                        .frame(width: geometry.size.width - 16, height: 50)
                        .background(Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)).opacity(0.9))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white,lineWidth: 1.9)
                                .blendMode(.normal)
                                .opacity(0.7)
                        )
                        .cornerRadius(16)
                    
                }
            })
        })
    }
}


struct GradientText: View {
    
    var text:String
    
    var body: some View {
        Text(text)
            .linearGradientBackground(colors: [Color(#colorLiteral(red: 0.9857622981, green: 0.2952255011, blue: 0.5630879998, alpha: 1)),Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))])
    }
}

extension View{
    func angularGradientGlow(colors: [Color]) -> some View {
        self.overlay(AngularGradient(gradient: Gradient(colors: colors), center: .center, angle: .degrees(0.0)))
            .mask(self)
    }
    
    func linearGradientBackground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing))
            .mask(self)
    }
}
