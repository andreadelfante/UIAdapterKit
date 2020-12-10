# Changelog

## 0.15.0

### Breaking changes
- Remove Realm fixed version from podspec

### Enhancements
- Add better support for SwiftPM

## 0.14.0
### Breaking changes
* Bump min iOS version to 9.0.

## 0.13.1

### Enhancements
* Change some internal function to open

## 0.13.0

### Enhancements
* Add `ArrayTableViewAdapter` and `ArrayCollectionViewAdapter`
* Add `ArraySearchableTableViewAdapter` and `ArraySearchableCollectionViewAdapter`
* Add `StaticCollectionViewSection` for StaticCollectionViewAdapter
* Add ``StaticTableViewSection` for StaticTableViewAdapter

### Breaking changes
* Removed `RealmCollectionViewItem` and `RealmTableViewItem`. Now you must use respectively `CollectionViewItem` and `TableViewItem`
* All sections now implement `FilterableSection` (in Realm submodule ``RealmFilterableSection`) by default

## 0.12.1

### Enhancements
* Fix precondition crash on IndexPath if it has no section and row/item values

## 0.12.0

### Enhancements
* Add support for Swift Package Manager.

## 0.11.0

### Enhancements
* Add **willDisplay(cell:)** for TableViewItem and CollectionViewItem

## 0.10.0

### Breaking changes
* Now **onInitial()** is now renamed `onPreInitial()` for RealmTableViewSection and RealmCollectionViewSection
* Now **onUpdate()** is now renamed `onPreUpdate(deletions:insertions:modification:s)` for RealmTableViewSection and RealmCollectionViewSection

### Enhancements
* Add **onPostInitial()** for RealmTableViewSection and RealmCollectionViewSection
* Add **onPostUpdate(deletions:insertions:modifications:)** for RealmTableViewSection and RealmCollectionViewSection

## 0.9.0

### Enhancements
* Add support for Swift 5.1
* **tableViewSection(for:)** and **item(for:)** are now public in BaseTableViewAdapter
* **collectionViewSection(for:)** and **item(for:)** are now public in BaseCollectionViewAdapter

## 0.8.0

### Enhancements
* Add support for **didEndDisplayingItem** in BaseTableViewAdapter and BaseCollectionViewAdapter
* * Add support for **didEndDisplayingHeader** in BaseTableViewAdapter and BaseCollectionViewAdapter
* * Add support for **didEndDisplayingFooter** in BaseTableViewAdapter and BaseCollectionViewAdapter

## 0.7.2

### Enhancements
* Add support for **estimatedHeightForRow** in BaseTableViewAdapter

## 0.7.1

### Enhancements
* Add more checks in canEditRow (BaseTableViewAdapter)

## 0.7.0

### Enhancements
* Add support for editingStyle (.delete, .insert) in BaseTableViewAdapter (with protocol EditableTableViewItem)

### Breaking changes
* The old EditableTableViewItem is now **SwipeableTableViewItem**

## 0.6.3

### Enhancements
* Fix missing **heightForHeader** and **heightForFooter** in RealmTableViewSection #
* Add support for **headerHeight** and **footerHeight** constants in RealmTableViewSection
* Add support for **headerSize**, **footerSize**, **minimumLineSpacing** and **minimumInteritemSpacing** constants in RealmCollectionViewSection
* Add check on action in EditableTableViewItem #13

### Breaking changes
* Now **headerTitle** and **footerTitle** in RealmTableViewSection are public (prev. open)

## 0.6.2

### Enhancements
* Change headerTitle and footerTitle to open in RealmTableViewSection
* Change DefaultTableViewItem visibility to open

## 0.6.1

### Enhancements
* Fix missing open adapter functions (prev. public)

## 0.6.0

### Enhancements
* Add support for indentationLevel in UITableView items
* Results in RealmTableViewSection now are read-only outside this library
* Now adapter functions are open

## 0.5.0

### Enhancements
* Add support for filtering Realm results in UITableView and UICollectionView with RealmSearchableTableViewAdapter and RealmSearchableCollectionViewAdapter

## 0.4.0

### Enhancements
* Add support for UITableView and UICollectionView menu actions

## 0.3.1

### Enhancements
* Fix crash when using DefaultTableViewItem with StaticTableViewAdapter

## 0.3.0

### Enhancements
* Add support to UITableView editing actions

##0.2.0

### Enhancements
* Add support to Realm Adapters

## 0.1.0

Hello World!
