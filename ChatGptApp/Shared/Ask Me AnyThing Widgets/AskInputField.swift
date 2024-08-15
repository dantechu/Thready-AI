//
//  AskInputField.swift
//  ChatGptApp
//
//  Created by Hamza Butt on 4/10/23.
//


// AskInputField

// AskInputField_Previews

import SwiftUI
import SwiftOpenAI
@available(watchOS 8.0, *)
struct AskInputField: View {
    @State private var voiceViewModel: VoiceViewModel = VoiceViewModel(service: OpenAIServiceFactory.service(aiproxyPartialKey: "v2|3818e635|S4ipxjdvEsscAnSY", aiproxyServiceURL: "https://api.aiproxy.pro/058d45fb/757e6601"))
    @Binding var askMeInput: String
    @Binding var isInteractingWithChatGPT:Bool
    @FocusState var isTextFieldFocused: Bool
    @Binding var isListening:Bool
    @Binding var isChatAi:Bool
    var isMessageEmpty: Bool
    var sendTapped:(()->Void)?
    var settingsTapped:(()->Void)?
    var personaTapped:(()->Void)?
    var recordTapped:(()->Void)?
    
    let isWatchOS = currentPlatform == .watchOS
    @AppStorage(SELECTEDCOLORVALUE) private var PRIMARYCOLORVALUE:Int = 0

    
    var body: some View{
        
        if isWatchOS {
            
            
            VStack(spacing: isMessageEmpty ? 20 : 10) {
                if isMessageEmpty {
                    ZStack{
                        getGifIcon()
                        HStack(alignment: .top,spacing: 5){
                            personaIcon()
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color.clear)
                            
                            
                            getSettingButton()
                            
                            
                        }
                    }
                    
                   
                }
                
                HStack(alignment: isWatchOS ? .center : .bottom, spacing: 10) {
                    getTextInputTextField()
                    if !askMeInput.isEmpty {
                        sendBtn()
                            .transition(AnyTransition.opacity.animation(.linear(duration: 0.3)))
                    }
                    
                }
                
            }.onAppear {
                speectToText()
            }
            
            
            
        }else{
            
            
            VStack(spacing: isMessageEmpty ? 0 : 100) {
                if isMessageEmpty {
                    
                    HStack(alignment:.top,spacing: 15){
                        if isChatAi {
                            personaIcon()
                        }
                        getGifIcon()
                        getSettingButton()
                    }.padding(.bottom,20)
                   
                }
                
                HStack(alignment: .center, spacing: 10) {
                    getTextInputTextField()
                    if !askMeInput.isEmpty {
                        sendBtn()
                            .transition(AnyTransition.opacity.animation(.linear(duration: 0.3)))
                    }
                    
                    if askMeInput.isEmpty || isListening {
                        LongPressToActionButton(voiceViewModel: voiceViewModel)

                    }
                }
                .padding(.horizontal, 16)
            }.onAppear {
                speectToText()
            }
        }
    }
    
    
    func speectToText() {
        if !voiceViewModel.speechText.isEmpty {
            askMeInput = voiceViewModel.speechText
        }
    }
    
    
    func getTextInputTextField() -> AnyView{
        
        if isWatchOS{
            
            return AnyView(
                TextField(isMessageEmpty ?  "Ask Me Anything" : "Reply", text: $askMeInput, axis: .vertical)
                    .foregroundColor(.white)
                    .accentColor(Color.getCurrentColor(PRIMARYCOLORVALUE))
                    .font(.system(size: 10, weight: .bold))
                    .colorScheme(.dark)
                    .opacity(1)
                    .disabled(isInteractingWithChatGPT)
                    .frame(height: 20) // set the height to 20 pixels
                    .onSubmit {
                        sendTapped?()
                    }
            )
            
            
        }else{
            
            return AnyView(
                
                TextField(isMessageEmpty ?  getPlaceholderText() : getReplyPlaceholderText(), text: $askMeInput, axis: .vertical)
                    .focused($isTextFieldFocused)
                    .lineLimit(1...5)
                    .padding(10)
                    .foregroundColor(.white)
                    .accentColor(Color.getCurrentColor(PRIMARYCOLORVALUE))
                    .font(.system(size: 18, weight: .bold))
                    .colorScheme(.dark)
                    .opacity(1)
                    .disabled(isInteractingWithChatGPT)
                    .frame(minHeight: 50)
                    .background(Color.TEXTFIELDBGCOLOR)
                    .cornerRadius(8)
                    
                

                
                
            )
            
            
            
            
        }
        
        
    }
    
    func getPlaceholderText()->String {
        return isChatAi ? "Ask Me Anything" : "Type to generate an image"
    }
    func getReplyPlaceholderText()->String {
        return isChatAi ? "Reply" : "Type to generate an image"
    }
    func sendBtn() -> AnyView {
        if isWatchOS {
            return AnyView(Text(""))
        }
        else{
            
            return AnyView(
                
                ZStack{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.getCurrentColor(PRIMARYCOLORVALUE))
                        .frame(width: 50,height: 50)
                    
                    Button {
                        sendTapped?()
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 22, weight: .bold))
                    }
                    
                }
                
                
            )
            
        }
        
        
        
        
        
        
        
        
    }
    
    
    func getGifIcon() -> some View{
        
        #if os(iOS)
        // For iOS (mobile)
        GifImageMobile("smiling")
            .frame(width: 100, height: 100)
            .border(Color.black)
        
        #elseif os(watchOS)
        GifImageWatch()

        
        #else
        Text("Unsupported platform")
        #endif
        
        
    }
    
    
    func personaIcon()-> some View{
#if os(iOS)
        
        Image(systemName: "person.badge.clock")
            .resizable()
            .frame(width: 40,height: 40)
            .foregroundColor(.white)
            .onTapGesture {
                personaTapped?()
            }
        
#elseif os(watchOS)
        
        Image(systemName: "person.badge.clock")
            .resizable()
            .frame(width: 20,height: 20)
            .foregroundColor(.white)
            .onTapGesture {
                personaTapped?()
            }
        
        
#else
        Text("Unsupported platform")
#endif
        
        
    }
    
    func micIcon()-> some View{
#if os(iOS)
        Image(systemName: "mic.circle")
            .resizable()
            .frame(width: 40,height: 40)
            .foregroundColor(.white)
            .onTapGesture {
                recordTapped?()
            }
        
#elseif os(watchOS)
        
        Image(systemName: "mic.circle")
            .resizable()
            .frame(width: 20,height: 20)
            .foregroundColor(.white)
            .onTapGesture {
                recordTapped?()
            }
        
        
#else
        Text("Unsupported platform")
#endif
        
        
    }
    
    
    
    func getSettingButton()-> some View{
        Button {
            settingsTapped?()
        } label: {
            
            
#if os(iOS)
            
            Image(systemName: "gearshape.fill")
                .foregroundColor(.white)
                .font(.system(size: 30))
            
#elseif os(watchOS)
            
            Image(systemName: "gearshape.fill")
                .foregroundColor(.white)
                .font(.system(size: 15))
            
            
#else
            Text("Unsupported platform")
#endif
            
            
            
        }
        .buttonStyle(PlainButtonStyle())
        
    }
}



struct IndicatorView: View {

    var progress: CGFloat
    
    let ringSize: CGFloat
    let lineWidth: CGFloat
    
    @State private var rotationAngle = -90.0
    var shouldSpin: Bool = false


    var body: some View {
        ZStack {

            // progress
            if !shouldSpin {
                // background
                Circle()
                    .stroke(
                        Color.white.opacity(0.3),
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                       
                    )
                    .frame(width: ringSize, height: ringSize)

                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        Color.white,
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                       
                    )
                    .frame(width: ringSize, height: ringSize)
                
            } else {
                Circle()
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [Color.white, Color.white.opacity(0.3)]),
                            center: .center,
                            startAngle: .degrees(0),
                            endAngle: .degrees(360)
                        ),
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                       
                    )
                    .frame(width: ringSize, height: ringSize)

                
                // round cap
                Circle()
                    .frame(width: lineWidth, height: lineWidth)
                    .foregroundColor(Color.white)
                    .offset(x: ringSize/2)
            
            }
        }
        .rotationEffect(.degrees(rotationAngle))
        .onChange(of: shouldSpin){
            if (shouldSpin) {
                rotationAngle = 0
                withAnimation(.linear(duration: 2)
                        .repeatForever(autoreverses: false)) {
                    rotationAngle = 360.0
                }
            } else {
                rotationAngle = -90
            }
        }
    }
    
}

struct LongPressToActionButton: View {
    @State private var state: ActionState = .preStart
    @State var voiceViewModel: VoiceViewModel
    let activeTime = 5.0
    @State var timeRemaining: CGFloat = .infinity

    var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    private let ringSize: CGFloat = 40
    private let lineWidth: CGFloat = 4
    @GestureState var isPressing = false


    var body: some View {
        ZStack {
            Image(systemName: state == .finish ? "checkmark" : "mic.circle")
                .padding()
                .foregroundStyle(Color.white)
                .font(.system(size: 20, weight: .bold))
                .opacity(state == .pressing ? 0.6 : 1)
                .gesture(LongPressGesture(minimumDuration: 0.01)
                            .sequenced(before: LongPressGesture(minimumDuration: .infinity))
                            .updating($isPressing) { value, states, transaction in
                                switch value {
                                case .second(true, nil):
                                    states = true
                                    voiceViewModel.startRecording()


                                default:
                                    break
                                }
                            })
                        .onChange(of: isPressing) { value in
                            if timeRemaining < 0 {
                                if state == .pressing {
                                    state = .loading
                                }
                                return
                            }
         
                            if isPressing {
                                state = .pressing
                            } else {
                                state = .preStart
                                withAnimation {
                                    timeRemaining = activeTime
                                }
                            }
                            
                            if value == false {
                                performAction()

                            }
                    }
            
//                .onLongPressGesture(minimumDuration: 2.0, perform: {
//                    // guard state == .loading else {return}
//
//                     Task {
//                         state = .loading
//                         await performAction()
//                         DispatchQueue.main.async {
//                             do {
//                                 state = .finish
//                             }catch {
//                                 state = .finish
//
//                             }
//
//                         }
//                     }
//                 }, onPressingChanged: { isPressing in
//                     
//                 })

            IndicatorView(progress: (activeTime - timeRemaining) / activeTime, ringSize: ringSize, lineWidth: lineWidth, shouldSpin: state == .loading)
        }
        .onReceive(timer, perform: { _ in
            if state == .pressing {
                if timeRemaining > 0 {
                    withAnimation {
                        timeRemaining = timeRemaining - 1
                    }
                }
            }
        })
        .onAppear {
            timeRemaining = activeTime
        }
    }
    
    func performAction()  {
        Task {
            state = .loading
            try? await voiceViewModel.stopRecording()
            state = .finish
        }
    }
}

private enum ActionState {
    case preStart
    case pressing
    case loading
    case finish
}


