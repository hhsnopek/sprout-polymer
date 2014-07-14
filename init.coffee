fs = require 'fs-extra'
path = require 'path'

exports.before = (sprout, done) ->
  console.log """
.......+++++???........+++++++~~........
......+++++?++........+++?++++~~~.......
.....++++++??........+++++?++~~~~~......
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
.......::::::::~,.......~=======........
........::::::::.......:=======.........

    http://www.polymer-project.org/

  """
  done()

exports.configure = [
  {
    type: 'input',
    name: 'name',
    message: 'What is the name of your component?'
  },
  {
    type: 'input',
    name: 'github_username',
    message: 'What is your github username?'
  },
  {
    type: 'input',
    name: 'description',
    message: 'Describe your component'
  }
]

exports.after = (sprout, done) ->
  files = {
    html: 'example.html'
    css: 'example.css'
  }

  console.log 'renaming files...'
  for type, file of files
    fs.renameSync(path.join(sprout.target, file), path.join(sprout.target, "#{sprout.config_values.name}.#{type}"))

  console.log 'done!'
  console.log 'Run `bower install` to complete setup'

  done()
