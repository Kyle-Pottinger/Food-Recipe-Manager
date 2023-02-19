# Food Manager App

## Basic description
Manage your recipes per events or per food categories

- Events: 
    for example xmas food, birthday food, valentine's day food, etc.
    main course, dessert, etc.

- Food categories: 
    for example breakfast, lunch, dinner, snacks, etc.

- Main recipe table
    - links to ingredients
    - links to events
    - links to food categories

- Recipe steps:
    - ingredients
    - steps (fk to step table)
    - notes

- In other words:
    1) Recipe
    2) Recipe steps * 
    3) Ingredients (links to quantity table)
    4) Events *
    5) Food categories * 
    6) Quantity table

- Todo:
    - Kyle F = Recipe + AWS
    - Kyle P = Quantity + Ingredients + Repo
    - Line = Categories + Recipe steps
    - Hlony = Events (id, ref to rec, desc for event)

- Backlog:
    - one stores procedure
    - one user defined function
    - one view
    - ERD (crow's foot diagram)

    [Recipe]
        |
        |__[Recipe steps]
        |   
        |__[Ingredients]
            |
        ____|__[Quantity]
        |
        |__[Events]
        |
        |__[Food categories]
