# MunroQuery

[![CI](https://github.com/danielbastidasr/MunroQuery/actions/workflows/CI.yml/badge.svg)](https://github.com/danielbastidasr/MunroQuery/actions/workflows/CI.yml)

Munro Query it will help you to query and filter Munro Data.


### TODO:

- Sort by name

- Filter by Hill type
- Filter by Min height
- Filter by Max height

Pre req: 
- Can have 0 to all queries
- Order matters (makes sense from developer perspective)
- Error throw in case invalid query:  repeat query, query with boundaries, incompatible queries (min and max shoudl not cross boundaries),etc.


### Done:

- Domain layer with Data protocol that will be used to Query list.
- Empy Query
- Filter null munro from the list
- Sort by height
