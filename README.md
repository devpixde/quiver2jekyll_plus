# quiver2jekyll_plus

A Gem to convert quiver notes and notebooks to jekyll markdown. 

Inspired by https://github.com/bradley-curran/quiver2jekyll/blob/master/quiver2jekyll

* Supports quiver notes
* Supports quiver notebooks (collections of notes) and takes notebooks name as a category in jekylls frontmatter
* Optional paramters for input and output folders and selectors (marking notes)



## Installation

1. Clone repository
2. cd in cloned repository
3. Run gem  install ./quiver2Jekyll_plus-0.x.y.gem  
4. Now quiver2Jekyll_plus should be available in terminal

if you want to modify the code, just rebuild the gem with provided gemspec
    
    gem build quiver2Jekyll_plus.gemspec
    gem install ./quiver2Jekyll_plus-0.x.y0.gem





## Quick start

After installation quiver2Jekyll_plus should now be available on your CLI

run

    quiver2Jekyll_plus quiver-input-folder jekyll-output-folder selector 




For example:

    quiver2Jekyll_plus '.' './../_posts' '*' 

Selects all quiver-notes in same folder that are beginning with * in its title and creating jekyll-posts in folder ./../_posts

All parameters are optional.

* quiver-input-folder defaults to '.'
* jekyll-output-folder defaults to '.'
* selector  defaults to '' 




## License

MIT

Devpix: Ingo Klemm, info@devpix.de