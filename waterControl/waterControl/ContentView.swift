import SwiftUI

struct ContentView: View {
    
    static var shared = ContentView()
    
    @State var quantidadeDesejada = "1000"
    @State var quantidadeConsumida = "500"
    
    
    var body: some View {
        VStack {
            HStack{
                Text("Water Control!")
                Image("logoApp")
                    .resizable()
                    .frame(width: 80, height: 80)
            }
            VStack{
                Text("Digite a quantidade de água que você deseja beber hoje:")
                TextField("Exemplo 3000mL", text: $quantidadeDesejada)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("blue"))
                    .cornerRadius(20)
                    .foregroundColor(.black)
                    .lineLimit(1)
            }
            .padding(.bottom, 20)
            VStack (alignment: .leading){
                Text("Digite a quantidade de água que você já bebeu hoje:")
                TextField("Exemplo 1000mL", text: $quantidadeConsumida)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("blue"))
                    .cornerRadius(20)
                    .foregroundColor(.black)
                    .lineLimit(1)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(quantidadeDesejada: "3L")
    }
}
