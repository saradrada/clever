//
//  MultipleSelectionList.swift
//  Clever

import SwiftUI

struct MultipleSelectionList: View {
    @State private var items: [File]
    @State private var selections: [File]
    var onComplete: ([File]) -> Void

    init(items: [File], initialSelections: [File], onComplete: @escaping ([File]) -> Void) {
        self.items = items
        self._selections = State(initialValue: initialSelections)
        self.onComplete = onComplete
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    Button {
                        if selections.contains(item) {
                            selections.removeAll(where: { $0 == item })
                        } else {
                            selections.append(item)
                        }
                    } label: {
                        HStack {
                            Text(item.name)
                            if selections.contains(item) {
                                Spacer()
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
            .navigationBarItems(trailing: Button("Done") {
                onComplete(selections)
            })
        }
    }
}


#Preview {
    MultipleSelectionList(items: [File(name: "Name", type: "pdf", file_id: "123232")], initialSelections: []) {_ in 
        
    }
}
