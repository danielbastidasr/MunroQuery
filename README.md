# MunroQuery

[![CI](https://github.com/danielbastidasr/MunroQuery/actions/workflows/CI.yml/badge.svg)](https://github.com/danielbastidasr/MunroQuery/actions/workflows/CI.yml)

## Feature details

Munro Query it will help you to query and filter Munro Data.

### Done:

- Domain layer with Data protocol that will be used to Query list.
- Empy Query
- Filter null munro from the list
- Sort by height
- Sort by name
- Filter by Hill type
- Filter by Min height
- Filter by Max height
- Limit results

Pre req: 
- Can have 0 to all queries
- Order matters (makes sense from developer perspective)
- Error throw in case invalid query:  repeat query, query with boundaries, incompatible queries (min and max shoudl not cross boundaries),etc.



## Usage

First of all we need to create a `Munro` struct or class. 
This class will allow us to create a Builder query.

```swift
// Necessary step
struct Munro: MunroItemType {
    var gridReference: String
    var name: String
    var height: Double
    var category: MunroCategory?
}
```

Once we have it, we just need to create a query as follow.

```swift
// Example usage
func createQuery(listMunro: [Munro]) -> [Munro] {
    let munroQuery = try MunroQueryBuilder(for: listMunro)
        .minHeight(of: 200)
        .maxHeight(of: 450)
        .filterBy(.MUNRO)
        .sortByName(.ASC)
        .sortByHeight(.DES)
        .limitResults(to: 1)
        .build()
        
    return munroQuery.execute()
}
```
