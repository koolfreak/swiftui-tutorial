//
//  DocumentDetailsView.swift
//  SwiftUIProject
//
//  Created by Emmanuel Nollase on 6/18/22.
//

import SwiftUI

struct DocumentDetailsView: View {
    
    @Environment(\.dismiss) private var dismiss
//    @Environment(\.presentationMode) private var presentationMode
    
    @Binding var showDocumentsDetail: Bool
    
    
    var body: some View {
        VStack {
            Text("Hello world from documents details example")
            Button("Dismis via binding"){
                showDocumentsDetail.toggle()
            }
            Button("Dismicc via Environment variable") {
                dismiss()
            }
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .navigationBarHidden(true)
    }
}

struct DocumentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentDetailsView(showDocumentsDetail: .constant(true))
    }
}
