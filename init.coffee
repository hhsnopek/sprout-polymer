fs = require 'fs-extra'
path = require 'path'

exports.before = (sprout, done) ->
  console.log """
.......++++++++........+++++++~~........
......++++++++........++++++++~~~.......
.....++++++++........++++++++~~~~~......
....++++++++........++++++++~~~~~~~.....
...=+++++++........=+++++++.~~~~~~~?....
..===+++++........===+++++...~~~~~???...
.=====+++........=====+++.....~~~?????..
=======+........=======+.......~???????.
=======~.......~=======........++++++++.
.=====~~~.....~~~=====........++++++++..
..===~~~~~...~~~~~===........++++++++...
...=~~~~~~~.~~~~~~~=........++++++++....
....::::::::~~~~~~~........========.....
.....::::::::~~~~~........========......
......::::::::~~~........~=======.......
.......::::::::~........~=======........
........::::::::.......:=======.........
    http://www.polymer-project.org/
  """
  done()

exports.configure = [
  {
    type: 'input',
    name: 'name',
    message: 'What is the name of your project?'
  },
  {
    type: 'input',
    name: 'github_username',
    message: 'What is your github username?'
  },
  {
    type: 'input',
    name: 'description',
    message: 'Describe your project'
  },
  {
    type: 'confirm',
    name: 'advance',
    message: 'Would you like to use Jade & Stylus?',
    default: true
  }
]

exports.after = (sprout, done) ->
  files = {
    html: 'example.html'
    css: 'example.css'
  }

  advanceFiles = {
    jade: 'example.jade'
    styl: 'example.styl'
    Makefile: 'Makefile'
  }

  if not sprout.config_values.advance is true
    console.log 'remove unnecessary files...'

    for type, file of advanceFiles
      sprout.remove path.join(sprout.target, file)

  else if sprout.config_values.advance is true
    for type, file of advanceFiles
      if file isnt 'Makefile'
        fs.copySync(path.join(sprout.target, file), path.join(sprout.target, "#{sprout.config_values.name}.#{type}"))
        sprout.remove path.join(sprout.target, file)

  console.log 'renaming files...'
  for type, file of files
    fs.copySync(path.join(sprout.target, file), path.join(sprout.target, "#{sprout.config_values.name}.#{type}"))
    sprout.remove path.join(sprout.target, file)

  console.log 'done!'
  if sprout.config_values.advance
    console.log 'Run `make install` to complete setup'
  else
    console.log 'Run `bower install` to complete setup'

  done()
