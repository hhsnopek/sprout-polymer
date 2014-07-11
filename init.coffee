fs = require 'fs'

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
    html: 'example.html'
    css: 'example.css'
  }

  advanceFiles = {
    jade: 'example.jade'
    styl: 'example.styl'
    Makefile: 'Makefile'
  }

  for type, file of files
    fs.rename(file, "#{sprout.name}.#{type}", (err) -> console.log err)

  unless sprout.advance
    console.log 'remove unnecessary files...'
    for type, file of advanceFiles
      sprout.remove file

  else
    for type, file of advanceFiles
      if file isnt 'Makefile'
        fs.rename(file, "#{sprout.name}.#{type}", (err) -> console.log err)

  console.log 'done!'
  if sprout.advance
    console.log 'Run `make install` to complete setup'
  else
    console.log 'Run `bower install` to complete setup'

  done()
