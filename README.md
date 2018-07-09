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
* [SQLite3](https://www.sqlite.org/index.html)

### Installation

> Clone this repo to your local machine: Open terminal in any folder and type:
```
git clone https://github.com/peterpaints/learnersdigest.git
```

> Switch to the develop branch using:
```
git checkout develop
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

### License

[The MIT License](https://github.com/peterpaints/learnersdigest/blob/develop/LICENSE.md)
