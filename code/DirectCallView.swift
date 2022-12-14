import SwiftUI

struct DirectCallView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @EnvironmentObject var callingViewModel: CallingViewModel

    private var selectedAnchor: Alignment = .topLeading

    var body: some View {
        ZStack {
            if !callingViewModel.remoteVideoStreamModels.isEmpty {
                StreamView(remoteVideoStreamModel: callingViewModel.remoteVideoStreamModels.first!)
            } else {
                Rectangle()
                    .edgesIgnoringSafeArea(.all)
            }
            VStack {
                GeometryReader { geometry in
                    if callingViewModel.localVideoStreamModel != nil {
                        callingViewModel.localVideoStreamModel?.videoStreamView
                            .cornerRadius(16)
                            .frame(width: geometry.size.width / 3, height: geometry.size.height / 3)
                            .padding([.top, .leading], 30)
                    } else {
                        Rectangle()
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .cornerRadius(16)
                            .frame(width: geometry.size.width / 3, height: geometry.size.height / 3)
                            .padding([.top, .leading], 30)
                    }
                }
                Spacer()
                HStack {
                    Button(action: { callingViewModel.toggleVideo() }, label: {
                        HStack {
                            Spacer()
                            if callingViewModel.isLocalVideoStreamEnabled {
                                Image(systemName: "video")
                                    .padding()
                            } else {
                                Image(systemName: "video.slash")
                                    .padding()
                            }
                            Spacer()
                        }
                    })
                    Button(action: { callingViewModel.mute() }, label: {
                        HStack {
                            Spacer()
                            if callingViewModel.isMicrophoneMuted {
                                Image(systemName: "speaker.slash")
                                    .padding()
                            } else {
                                Image(systemName: "speaker.wave.2")
                                    .padding()
                            }
                            Spacer()
                        }
                    })
                    Button(action: { callingViewModel.endCall() }, label: {
                        HStack {
                            Spacer()
                            Image(systemName: "phone.down")
                                .foregroundColor(.red)
                                .padding()
                            Spacer()
                        }
                    })
                }
            }
            .font(.largeTitle)
        }
    }
}

struct DirectCall_Previews: PreviewProvider {
    static var previews: some View {
        DirectCallView()
            .environmentObject(AuthenticationViewModel())
            .environmentObject(CallingViewModel())
    }
}