# quiver2jekyll_plus
A Gem to convert quiver notes and notebooks to jekyll markdown. 

Inspired by https://github.com/bradley-curran/quiver2jekyll/blob/master/quiver2jekyll

usage: 

    quiver2jekyll_plus <input> <output>
    
converts quiver json-exports in <input> to jekyll markdown in <output>


#Features:
* Supports notes
* Supports notebooks and takes notebooks name as a category in jekylls frontmatter


Installation:

1. Clone repository
2. cd in cloned repository
3. Run gem  install ./quiver2Jekyll_plus-0.1.0.gem  
4. Now quiver2Jekyll_plus should be available in terminal

if you want to modify the code, just rebuild the gem with provided gemspec
    
    gem build quiver2Jekyll_plus.gemspec
    gem install ./quiver2Jekyll_plus-0.1.0.gem



