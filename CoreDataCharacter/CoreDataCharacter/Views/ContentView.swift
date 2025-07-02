import SwiftUI
import CoreData

import SwiftUI

struct ContentView: View  {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Character.entity(), sortDescriptors: []) var characters: FetchedResults<Character>
    
    @State private var showAddScreen = false
    @State private var editCharacter: Character?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(characters, id: \.id) { character in
                    Button {
                        editCharacter = character
                    } label: {
                        HStack {
                            Text(character.name ?? "")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                    .foregroundStyle(Color.primary)
                }
                .onDelete(perform: deleteCharacter)
            }.navigationTitle("Guildas")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        editCharacter = nil
                        showAddScreen = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showAddScreen) {
                CharacterSheetView()
                    .environment(\.managedObjectContext, managedObjectContext)
            }
            .sheet(item: $editCharacter) { character in
                CharacterSheetView(editedCharacter: character)
                    .environment(\.managedObjectContext, managedObjectContext)
            }
        }
    }
    
    func deleteCharacter(at offsets: IndexSet) {
        offsets.forEach { index in
            let obj = characters[index]
            managedObjectContext.delete(obj)
        }
        try? managedObjectContext.save()
    }
}

#Preview {
    ContentView()
}
