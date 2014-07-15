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
    message: 'Describe your component:'
  },
  {
    type: 'list',
    name: 'html',
    message: 'What templating language would you like to use?',
    choices: [ 'html', 'jade', 'ejs', 'mustache/hogan', 'handlebars', 'haml', 'swig' ]
  },
  {
    type: 'list',
    name: 'css',
    message: 'What stylesheet language would you like to use?',
    choices: [ 'css', 'stylus', 'sass', 'less' ]
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
