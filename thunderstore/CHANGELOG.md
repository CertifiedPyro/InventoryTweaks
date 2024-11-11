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
