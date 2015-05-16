LanguageAshView = require './language-ash-view'
{CompositeDisposable} = require 'atom'

module.exports = LanguageAsh =
  languageAshView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @languageAshView = new LanguageAshView(state.languageAshViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @languageAshView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'language-ash:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @languageAshView.destroy()

  serialize: ->
    languageAshViewState: @languageAshView.serialize()

  toggle: ->
    console.log 'LanguageAsh was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
