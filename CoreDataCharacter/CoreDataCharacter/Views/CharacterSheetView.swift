import SwiftUI

struct CharacterSheetView: View {
        
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    var editedCharacter: Character?
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Nome", text: $name)
                .onAppear {
                    if let character = editedCharacter {
                        name = character.name ?? ""
                    }
                }
                Button("Salvar") {
                    
                    if let character = editedCharacter {
                        character.name = name
                    } else {
                        let character = Character(context: managedObjectContext)
                        character.name = name
                        // outros atributos
                    }
                    try? managedObjectContext.save()
                    
                    dismiss()
                }
            }
            .padding(.top, 20)
            .ignoresSafeArea(.all)
            .navigationTitle(editedCharacter != nil ? "Personagem" : "Novo Personagem")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    CharacterSheetView()
}
