###

- better stack trace
- highlight working files
- truncate directory

###

path = require 'path'
colors = require 'colors'
mode = 0
thisfile = path.basename __filename

# This mode will display time, filename & linenumber before log lines.
exports.modeInfo = ->
  mode = 1

exports.getStack = getStack = ->
  old = Error.prepareStackTrace
  Error.prepareStackTrace = (_, stack) -> stack
  stack = (new Error()).stack
  Error.prepareStackTrace = old
  stack.shift 1
  return stack

cwd = process.cwd()
regCwd = /(~[^:]+)/
regNode = /at(.*) \([^\(]+[\\\/]node_modules[\\\/]([^\)]+)\)/
regNod2 = /at(.*) [^\(]+[\\\/]node_modules[\\\/]([^\)]+)/

exports.parseStack = parseStack = (arg) ->
  return arg if typeof arg isnt 'string'
  return arg if arg.length < 300
  return arg if (arg.indexOf '   at') is -1

  pos = -1
  count = 0
  lines = arg.split '\n'
  for line, i in lines

    # First, truncate node_module
    nline = line.replace(regNode, 'at'.grey + '$1 ' + '$2'.grey)
    if nline != line
      lines[i] = nline
      continue

    nline = line.replace(regNod2, 'at'.grey + '$1 ' + '$2'.grey)
    if nline != line
      lines[i] = nline
      continue

    # Then, truncate src and highlight
    nline = line.replace(cwd, '~').replace(regCwd, '$1'.cyan)
    lines[i] = nline
    if nline != line
      pos = i
      count++
      if count >= 3 then break

  if count > 0
    l = lines.length
    show = pos + 4
    str = lines.slice(0, show).join('\n') +
      if l > show then "\n   #{l-show} more..."
      else ''
  else lines.join '\n'


# Extend console.log & console.error

lastInfo =
  file: ''
  line: 0

lastLog = ''
origLog = console.log.__old ? console.log

infoString = (ch, m) ->
  m = m ? mode
  if !m
    lastLog = ch
    return if lastLog == ch then ch + '| ' else '\n' + ch + '| '

  ss = getStack()
  s = ss[2]

  # Fix for theseus
  i = 3
  while i < ss.length and (
    not s.getFileName()? or s.getFileName().indexOf(__filename) >= 0
  )
    s = ss[i]
    i++

  file = s?.getFileName() ? noname
  line = s?.getLineNumber() ? 0

  str = ''
  if file != lastInfo.file
    lastInfo.file = file

    if file != noname
      file = file.replace cwd, '~'

    str = file + '>\n'

  lastInfo.line = line
  str += ' :' + s.getLineNumber() + '> '

  # if line != lastInfo.line
  #   lastInfo.line = line
  #   str += ' :' + s.getLineNumber() + '> '

  # else
  #   str = ' > '

  t = new Date()
  st = t.toLocaleTimeString().slice(0,8) + '.'
  st += (t.getMilliseconds() + 1000).toString().slice(0,3) + ' '

  return st + str

do ->
  log = console.log
  log = log.__old ? log

  console.log = ->
    str = infoString(' ')
    process.stdout.write str.grey

    args = arguments
    log.apply console, (parseStack a for a in args)

  console.log.__old = log

do ->
  log = console.error
  log = log.__old ? log

  console.error = ->
    str = infoString('E')
    process.stderr.write str.red

    args = arguments
    log.apply console, (parseStack a for a in args)

  console.error.__old = log


noname = '(noname) '

do ->
  console.debug = ->
    str = infoString('D', 1)
    process.stdout.write str.cyan
    origLog.apply console, arguments
