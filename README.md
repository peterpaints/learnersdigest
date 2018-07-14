[![Build Status](https://travis-ci.org/peterpaints/learnersdigest.svg?branch=develop)](https://travis-ci.org/peterpaints/learnersdigest)
[![Coverage Status](https://coveralls.io/repos/github/peterpaints/learnersdigest/badge.svg?branch=develop)](https://coveralls.io/github/peterpaints/learnersdigest?branch=develop)
#### Learner's Digest

### Intro

This app functions like this: You select a few topics of interest, for instance, Sinatra, Rails, Data Structures, etc, and it will send you a daily digest with a curated list of tutorials/articles that you'll love!

Every article is fetched from the always
reliable [NewsApi](https://newsapi.org/docs/endpoints/everything)

### Dev Tools

This are the tools I used:
* [Sinatra](http://sinatrarb.com/)
* [DataMapper](https://datamapper.org/)
* [Rufus Scheduler](https://github.com/jmettraux/rufus-scheduler)
* [PostgresQL](https://www.postgresql.org/)

### Installation

> Clone this repo to your local machine: Open terminal in any folder and type:
```
git clone https://github.com/peterpaints/learnersdigest.git
```

> Switch to the develop branch using:
```
git checkout develop
```

> Create two postgres dbs:
```
createdb microlearn_dev
createdb microlearn_test
```

> Create a .env file with the following sample settings:
```
GMAIL_USERNAME=your_gmail_username
GMAIL_PASSWORD=your_gmail_password
DATABASE_DEV=postgres://localhost:5432/microlearn_dev
DATABASE_TEST=postgres://localhost:5432/microlearn_test
```

>Run bundler to install gems (dependencies)
```
bundle
```

> Finally, start the app!
```
bundle exec rerun 'ruby microlearn.rb'
```

### Contribution

Feel you have something you'd like to see added? Raise a PR!

### Tests

> Run tests with one simple command:
```
rspec
```

> If that doesn't work, try:
```
bundle exec rspec
```

### License

[The MIT License](https://github.com/peterpaints/learnersdigest/blob/develop/LICENSE.md)
