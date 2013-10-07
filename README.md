
A collection of slides for internal training and idea sharing at
Aptivate.

## How to build foo

Ensure [slidify][] is available on the local R install.

Then build the slides and commit to the gh-pages branch:

    cd foo
    R
    > library('slidify')
    > slidify('index.Rmd')
    C^d
    git checkout gh-pages
    git add .
    git commit
    git push origin gh-pages

[slidify]: http://slidify.org/start.html
