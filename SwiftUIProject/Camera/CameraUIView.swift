//
//  CameraUIView.swift
//  SwiftUIProject
//
//  Created by Emmanuel Nollase on 7/8/22.
// https://www.youtube.com/watch?v=8hvaniprctk
import AVFoundation
import SwiftUI

struct CameraUIView: View {
    var body: some View {
        CameraView()
    }
}

struct CameraView: View {
    
    @StateObject var cameraViewModel = CameraViewModel()
    @State private var isFlashOn = false
    @State private var moveUpDown = 0
    
    var body: some View {
        
        ZStack {
            // camera preview
            CameraPreview(camera: cameraViewModel)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                // TODO Progress indicator here animated
                if cameraViewModel.isTaken {
                    
                    //ZStack(alignment: .center) {
                        /*RoundedRectangle(cornerRadius: 5)
                                .frame(maxWidth: .infinity, minHeight: 5)
                            .foregroundColor(Color.red)
                            .shadow(radius: 5)
                            .offset(y: CGFloat(moveUpDown))
                            .animation(Animation.easeOut(duration: 0.75).repeatCount(100, autoreverses: true))
                            .task {
                                moveUpDown = -25
                            }*/
                        LottieView(animationRes: "receipt-scanning").frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        
                    //}.frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                Spacer()
                HStack {
                    if cameraViewModel.isTaken {
                        Button(action: {
                            cameraViewModel.savePicture()
                        }, label: {
                            Text("Save")
                                .foregroundColor(Color.black)
                                .fontWeight(.semibold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.white)
                                .clipShape(Capsule())
                        }).padding(.leading)
                        Spacer()
                        Button(action: {
                            cameraViewModel.retakePicture()
                        }, label: {
                           Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        }).padding(.trailing, 10)
                    }else{
                        Button(action: {
                            cameraViewModel.takePicture()
                            moveUpDown = 600
                        }, label: {
                            ZStack {
                                Circle().fill(Color.white).frame(width: 65, height: 65)
                                
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 75, height: 75)
                            }
                        })
                    }
                }
                .frame(height: 75)
            }
        }
        .onAppear(perform: {
            cameraViewModel.check()
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isFlashOn = !isFlashOn
                    cameraViewModel.toggleFlash(isOn: isFlashOn)
                }, label: {
                    Image(systemName: isFlashOn ? "bolt.fill" : "bolt.slash.fill")
                         .foregroundColor(.black)
                         .padding(.vertical, 5)
                         .padding(.horizontal, 10)
                         .background(Color.white)
                         .clipShape(Capsule())
                })
            }
        }
        
    }
    
}

struct CameraPreview: UIViewRepresentable {
    
    @ObservedObject var camera: CameraViewModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        camera.session.startRunning()
        
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

struct CameraUIView_Previews: PreviewProvider {
    static var previews: some View {
        CameraUIView()
    }
}
