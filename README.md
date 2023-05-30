# RecipeFinder
integrate with content delivery API to fetch recipes

## Initial Setup

---
### Prerequisites

The setups steps expect following tools installed on the system.

- Git
- Ruby [3.1.3](https://github.com/ugyenchoden/Recipe/blob/main/.ruby-version)
- Rails [7.0.4](https://github.com/ugyenchoden/Recipe/blob/main/Gemfile)
- PostgreSQL

##### 1. Check out the repository and install the needed gem
```bash
git clone git@github.com:ugyenchoden/Recipe.git
cd Recipe
bundle install
```

##### 2. Create and setup the database

```bash
bundle exec rake db:create
bundle exec rake db:migrate
```

##### 3. Add values to the following in .enb
SPACE_ID
> space id of the content delivery API

AUTH_TOKEN
> Authorization token of the content delivery API 

MAINTENANCE_EMAIL
> Email of the application maintenance team or anyone to trigger email when sync 
> with the content delivery API fails


##### 4 Seed the database
note: for initial, please run the task to seed the data from the API
```bash
rails db:sync_recipes 
```

