fs = require 'fs-extra'

exports.before = (sprout, done) ->
  console.log """
                              .,
    ,,,  `,,`                 .,
    ,,   ,,,'                 .,
   ,,,  .,,'':     ;;;;  ;;;; .,.:  ; ;;;;;:;  ;;;; ;;;
  `::   ::.,;,     ;  :.`;  ;`., ; ,, ;  ;   ; ;  ; ;
  ::,  :::  :,,    ;   :,`  `,., ; ;  ;  ;   ;`;;;; ;
  ;;;  ;;`  :,,    ;  .,.,  ,.., `:;  ;  ;   ; ;    ;
  `:' ;;;  ,:,     ;  ;  ;  ; .,  ;.  ;  ;   ; ;` ; ;
   '';''   ::.     ;`:    ,,  ``  ;   .  .   .  ,,  .
    ''';  ;;:      ;              ;
    :;;   ::`      ;            `;

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
  console.log 'renaming files...'
  files = {
    html: './example.html'
    css: './example.css'
  }

  advanceFiles = {
    jade: './example.jade'
    styl: './example.styl'
    Makefile: './Makefile'
  }

  for type, file of files
    fs.copySync(path.join(sprout.target, file), path.join(sprout.target, "#{sprout.name}.#{type}"))
    sprout.remove file

  unless sprout.advance
    console.log 'remove unnecessary files...'
    for type, file of advanceFiles
      sprout.remove path.join(sprout.target, file)

  else
    for type, file of advanceFiles
      if file isnt 'Makefile'
        fs.copySync(path.join(sprout.target, file), path.join(sprout.target, "#{sprout.name}.#{type}"))
        sprout.remove path.join(sprout.target, file)

  console.log 'done!'
  if sprout.advance
    console.log 'Run `make install` to complete setup'
  else
    console.log 'Run `bower install` to complete setup'

  done()
