ChristopherWordCount2View = require './christopher-word-count2-view'
{CompositeDisposable} = require 'atom'

module.exports = ChristopherWordCount2 =
  christopherWordCount2View: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @christopherWordCount2View = new ChristopherWordCount2View(state.christopherWordCount2ViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @christopherWordCount2View.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace',
      'christopher-word-count2:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @wordcountView.destroy()

  serialize: ->
    christopherWordCount2ViewState: @christopherWordCount2View.serialize()

  toggle: ->
    console.log 'ChristopherWordCount2 was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      editor = atom.workspace.getActiveTextEditor()
      words = editor.getText().split(/\s+/).length
      @christopherWordCount2View.setCount(words)
      @modalPanel.show()
