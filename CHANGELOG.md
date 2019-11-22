0.9.0 Release notes (2019-11-22)
=============================================================
### Enhancements
* Add support for Swift 5.1
* `tableViewSection(for:)` and `item(for:)` are now public in BaseTableViewAdapter
* `collectionViewSection(for:)` and `item(for:)` are now public in BaseCollectionViewAdapter

0.8.0 Release notes (2019-06-26)
=============================================================
### Enhancements
* Add support for **didEndDisplayingItem** in BaseTableViewAdapter and BaseCollectionViewAdapter
* * Add support for **didEndDisplayingHeader** in BaseTableViewAdapter and BaseCollectionViewAdapter
* * Add support for **didEndDisplayingFooter** in BaseTableViewAdapter and BaseCollectionViewAdapter

0.7.2 Release notes (2019-06-25)
=============================================================
### Enhancements
* Add support for **estimatedHeightForRow** in BaseTableViewAdapter

0.7.1 Release notes (2019-06-25)
=============================================================
### Enhancements
* Add more checks in canEditRow (BaseTableViewAdapter)

0.7.0 Release notes (2019-06-25)
=============================================================
### Enhancements
* Add support for editingStyle (.delete, .insert) in BaseTableViewAdapter (with protocol EditableTableViewItem)

### Breaking changes
* The old EditableTableViewItem is now **SwipeableTableViewItem**

0.6.3 Release notes (2019-06-24)
=============================================================
### Enhancements
* Fix missing **heightForHeader** and **heightForFooter** in RealmTableViewSection #
* Add support for **headerHeight** and **footerHeight** constants in RealmTableViewSection
* Add support for **headerSize**, **footerSize**, **minimumLineSpacing** and **minimumInteritemSpacing** constants in RealmCollectionViewSection
* Add check on action in EditableTableViewItem #13

### Breaking changes
* Now **headerTitle** and **footerTitle** in RealmTableViewSection are public (prev. open)

0.6.2 Release notes (2019-06-24)
=============================================================
### Enhancements
* Change headerTitle and footerTitle to open in RealmTableViewSection
* Change DefaultTableViewItem visibility to open

0.6.1 Release notes (2019-06-24)
=============================================================
### Enhancements
* Fix missing open adapter functions (prev. public)

0.6.0 Release notes (2019-06-21)
=============================================================
### Enhancements
* Add support for indentationLevel in UITableView items
* Results in RealmTableViewSection now are read-only outside this library
* Now adapter functions are open

0.5.0 Release notes (2019-06-21)
=============================================================
### Enhancements
* Add support for filtering Realm results in UITableView and UICollectionView with RealmSearchableTableViewAdapter and RealmSearchableCollectionViewAdapter

0.4.0 Release notes (2019-06-14)
=============================================================
### Enhancements
* Add support for UITableView and UICollectionView menu actions

0.3.1 Release notes (2019-06-11)
=============================================================
### Enhancements
* Fix crash when using DefaultTableViewItem with StaticTableViewAdapter

0.3.0 Release notes (2019-06-11)
=============================================================
### Enhancements
* Add support to UITableView editing actions

0.2.0 Release notes (2019-06-09)
=============================================================
### Enhancements
* Add support to Realm Adapters

0.1.0 Release notes (2019-06-06)
=============================================================
Hello World!
