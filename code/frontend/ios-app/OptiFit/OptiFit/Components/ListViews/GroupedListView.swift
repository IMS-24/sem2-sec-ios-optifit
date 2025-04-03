import SwiftUI

struct GroupedListView<Item, Content: View>: View {
    let groupedItems: [String: [Item]]
    let onLoadMore: () -> Void
    /// The content closure provides:
    /// - The current group key (a String),
    /// - The array of items for that group,
    /// - And the onLoadMore closure
    let content: (String, [Item], @escaping () -> Void) -> Content

    /// Sort the group keys in descending order.
    private var sortedGroups: [String] {
        groupedItems.keys.sorted(by: >)
    }

    var body: some View {
        ForEach(sortedGroups, id: \.self) { group in
            Section(
                header: Text(group)
                    .font(.headline)
                    .foregroundColor(Color(.primaryText))
            ) {
                content(group, groupedItems[group] ?? [], onLoadMore)
            }
        }
    }
}
