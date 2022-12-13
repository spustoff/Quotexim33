import SwiftUI

struct ViewWeber: View {
    
    @StateObject var viewModel = ViewWebModel()
    
    var body: some View {
        
        ZStack{
            
            Color("bg")
            
            WebView2(link: viewModel.link)
        }
        .ignoresSafeArea(.all)
        .onAppear{
            
            viewModel.getLink()
        }
    }
}

struct ViewWeber_Previews: PreviewProvider {
    static var previews: some View {
        ViewWeber()
    }
}
