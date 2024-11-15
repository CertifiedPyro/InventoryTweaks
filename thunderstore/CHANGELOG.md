# 1.2.0

### Added
- Add keyboard navigation for backpack menu.
  - Use number keys 1-5 to access top-level menus.
  - Use "Q" and "E" keys to navigate submenus.
- Sort metal detector loot in front of fish under "creatures" tab.
  - Important loot (hat, monocle, sword, and hat pieces) are placed first.
- Sort bait in the sell shop.

### Fixed
- Fix bug where treasure chests show as "empty" when obtained.

# 1.1.0

### Added
- Treasure chests are now stacked.

### Fixed
- Change the order of chalk to follow rainbow instead of shop order.

## 1.0.1

### Fixed
- Island props are sorted to top of prop list.
- Fish are sorted by item name rather than the (unseen) item id
  - When sorting by name, quality and custom names are ignored.

## 1.0.0

### Added
- Sort inventory based on a predetermined order.
- Keep favorited items at the front of the inventory.

### Fixed
- Fix inventory items with the same `ref` id by stacking them.
  - This should fix the "infinite beer" glitch.
