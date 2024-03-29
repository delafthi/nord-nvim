local M = {}

---@param config table The configuration object
---@return Theme Returns a theme object which can be given to
--`require("nord.util").load` to load the theme.
function M.setup(config)
  config = config or require("nord.config")

  ---@class Theme
  local theme = {}
  theme.config = config
  theme.colors = require("nord.colors")
  local c = theme.colors

  -- local variables to reduce the use of strings
  local strikethrough = "strikethrough,"
  local inverse = "inverse,"

  -- Config specific theme settings
  local none = nil
  local bold = config.bold.enabled and "bold," or ""
  local italic = config.italic.enabled and "italic," or ""
  local underline = config.underline.enabled and "underline," or ""
  local undercurl = config.undercurl.enabled and "undercurl," or ""

  local italic_cfg = {}
  if config.italic.comment then
    italic_cfg.Comment = italic
    italic_cfg.SpecialComment = italic
  else
    italic_cfg.Comment = none
    italic_cfg.SpecialComment = none
  end

  if config.italic.boolean then
    italic_cfg.Boolean = italic
  else
    italic_cfg.Boolean = none
  end

  if config.italic.statement then
    italic_cfg.Statement = italic
  else
    italic_cfg.Statement = none
  end

  if config.italic.conditional then
    italic_cfg.Conditional = italic
  else
    italic_cfg.Conditional = none
  end

  if config.italic["repeat"] then
    italic_cfg.Repeat = italic
  else
    italic_cfg.Repeat = none
  end

  if config.italic.label then
    italic_cfg.Label = italic
  else
    italic_cfg.Label = none
  end

  if config.italic.operator then
    italic_cfg.Operator = italic
  else
    italic_cfg.Operator = none
  end

  if config.italic.keyword then
    italic_cfg.Keyword = italic
  else
    italic_cfg.Keyword = none
  end

  if config.italic.exception then
    italic_cfg.Exception = italic
  else
    italic_cfg.Exception = none
  end

  local cursorline_number_background = {}
  if config.cursor_line_number_background then
    cursorline_number_background = {
      CursorLineNr = { fg = c.nord4, bg = c.nord1 },
    }
  else
    cursorline_number_background = { CursorLineNr = { fg = c.nord4 } }
  end

  local uniform_status_lines = {}
  if config.uniform_status_lines then
    uniform_status_lines = {
      StatusLine = { fg = c.nord8, bg = c.nord3 },
      StatusLineNC = { fg = c.nord4, bg = c.nord3 },
    }
  else
    uniform_status_lines = {
      StatusLine = { fg = c.nord8, bg = c.nord3 },
      StatusLineNC = { fg = c.nord4, bg = c.nord1 },
    }
  end

  local bold_vertical_split_line = {}
  if config.bold_vertical_split_line then
    bold_vertical_split_line = { VertSplit = { fg = c.nord2, bg = c.nord1 } }
  else
    bold_vertical_split_line =
      { VertSplit = { fg = c.nord2, bg = { gui = c.nord0.gui } } }
  end

  local uniform_diff_background = {}
  if config.uniform_diff_background then
    uniform_diff_background = {
      DiffAdd = { fg = c.add },
      DiffChange = { fg = c.change },
      DiffDelete = { fg = c.remove },
      DiffText = { fg = c.nord9 },
    }
  else
    uniform_diff_background = {
      DiffAdd = { fg = c.add, bg = { gui = c.nord0.gui }, style = inverse },
      DiffChange = {
        fg = c.change,
        bg = { gui = c.nord0.gui },
        style = inverse,
      },
      DiffDelete = {
        fg = c.remove,
        bg = { gui = c.nord0.gui },
        style = inverse,
      },
      DiffText = { fg = c.nord9, bg = { gui = c.nord0.gui }, style = inverse },
    }
  end

  theme.base = {
    -- Attributes
    Bold = { style = bold },
    Italic = { style = italic },
    Underline = { style = underline },

    ColorColumn = { bg = c.nord1 }, -- used for the columns set with 'colorcolumn'
    Conceal = { bg = c.none }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor = { fg = { gui = c.nord0.gui }, bg = c.nord4 }, -- character under the cursor
    lCursor = { link = "Cursor" }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    CursorIM = { link = "Cursor" }, -- like Cursor, but used when in IME mode |CursorIM|
    CursorColumn = { bg = c.nord4 }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine = { bg = c.nord1 }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory = { fg = c.nord8 }, -- directory names (and other special names in listings)
    DiffAdd = uniform_diff_background.DiffAdd, -- diff mode: Added line |diff.txt|
    DiffChange = uniform_diff_background.DiffChange, -- diff mode: Changed line |diff.txt|
    DiffDelete = uniform_diff_background.DiffDelete, -- diff mode: Deleted line |diff.txt|
    DiffText = uniform_diff_background.DiffText, -- diff mode: Changed text within a changed line |diff.txt|
    EndOfBuffer = { fg = c.nord1 }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    TermCursor = { link = "Cursor" }, -- cursor in a focused terminal
    TermCursorNC = { bg = c.nord1 }, -- cursor in an unfocused terminal
    ErrorMsg = { fg = c.nord4, bg = c.error }, -- error messages on the command line
    VertSplit = bold_vertical_split_line.VertSplit, -- the column separating vertically split windows
    Folded = { fg = c.blue, bg = c.none }, -- line used for closed folds
    FoldColumn = { fg = c.nord3, bg = c.nord1 }, -- 'foldcolumn'
    SignColumn = { fg = c.nord1, bg = { gui = c.nord0.gui } }, -- column where |signs| are displayed
    IncSearch = { fg = c.nord6, bg = c.nord10, style = underline }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    Substitute = { link = "IncSearch" }, -- |:substitute| replacement text highlighting
    LineNr = { fg = c.nord3 }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr = cursorline_number_background.CursorLineNr, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    MatchParen = { fg = c.nord8, bg = c.nord3 }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg = { fg = c.nord4 }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea = { fg = c.nord4 }, -- Area for messages and cmdline
    -- MsgSeparator= { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg = { fg = c.nord8 }, -- |more-prompt|
    NonText = { fg = c.nord2 }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Normal = { fg = c.nord4, bg = { gui = c.nord0.gui } }, -- normal text
    NormalFloat = { fg = c.nord4, bg = c.nord2 }, -- Normal text in floating windows.
    NormalNC = { link = "Normal" }, -- normal text in non-current windows
    Pmenu = { fg = c.nord4, bg = c.nord2 }, -- Popup menu: normal item.
    PmenuSel = { fg = c.nord8, bg = c.nord3 }, -- Popup menu: selected item.
    PmenuSbar = { fg = c.nord4, bg = c.nord2 }, -- Popup menu: scrollbar.
    PmenuThumb = { fg = c.nord8, bg = c.nord3 }, -- Popup menu: Thumb of the scrollbar.
    Question = { fg = c.nord4 }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine = { link = "CursorLine" }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Search = { fg = c.nord1, bg = c.nord8 }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    SpecialKey = { fg = c.nord3 }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
    SpellBad = {
      fg = c.none,
      style = undercurl,
      sp = c.nord11,
    }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap = {
      fg = c.none,
      style = undercurl,
      sp = c.nord13,
    }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal = {
      fg = c.none,
      style = undercurl,
      sp = c.nord8,
    }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare = {
      fg = c.none,
      style = undercurl,
      sp = c.nord7,
    }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
    StatusLine = uniform_status_lines.StatusLine, -- status line of current window
    StatusLineNC = uniform_status_lines.StatusLineNC, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine = { fg = c.nord3_bright, bg = c.nord1 }, -- tab pages line, not active tab page label
    TabLineFill = { fg = c.nord3, bg = { gui = c.nord0.gui } }, -- tab pages line, where there are no labelsh
    TabLineSel = {
      fg = c.nord4,
      bg = { gui = c.nord0.gui },
      style = bold .. italic,
    }, -- tab pages line, active tab page label
    Title = { fg = c.nord4 }, -- titles for output from ":set all", ":autocmd" etc.
    Visual = { bg = c.nord2 }, -- Visual mode selection
    VisualNOS = { link = "Visual" }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg = { fg = { gui = c.nord0.gui }, bg = c.nord13 }, -- warning messages
    Whitespace = { fg = c.nord2 }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    WildMenu = { fg = c.nord8, bg = c.nord1 }, -- current match in 'wildmenu' completion

    -- These groups are not listed as default vim groups,
    -- but they are defacto standard group names for syntax highlighting.
    -- commented out groups should chain up to their "preferred" group by
    -- default,
    -- Uncomment and edit if you want more specific syntax highlighting.

    Comment = { fg = c.nord3_bright, style = italic_cfg.Comment }, -- any comment

    Constant = { fg = c.nord7 }, -- (preferred) any constant
    String = { fg = c.nord14 }, -- a string constant: "this is a string"
    Character = { fg = c.nord14 }, -- a character constant: 'c', '\n'
    Number = { fg = c.nord13 }, -- a number constant: 234, 0xff
    Boolean = { fg = c.nord7, style = italic_cfg.Boolean }, -- a boolean constant: TRUE, false
    Float = { fg = c.nord13 }, -- a floating point constant: 2.3e10

    Identifier = { fg = c.nord4 }, -- (preferred) any variable name
    Function = { fg = c.nord8 }, -- function name (also: methods for classes)

    Statement = { fg = c.nord9, style = italic_cfg.Statement }, -- (preferred) any statement
    Conditional = { fg = c.nord9, style = italic_cfg.Conditional }, -- if, then, else, endif, switch, etc.
    Repeat = { fg = c.nord9, style = italic_cfg.Repeat }, -- for, do, while, etc.
    Label = { fg = c.nord9, style = italic_cfg.Label }, -- case, default, etc.
    Operator = { fg = c.nord8, style = italic_cfg.Operator }, -- "sizeof", "+", "*", etc.
    Keyword = { fg = c.nord9, style = italic_cfg.Keyword }, -- any other keyword
    Exception = { fg = c.nord9, style = italic_cfg.Exception }, -- try, catch, throw

    PreProc = { fg = c.nord10 }, -- (preferred) generic Preprocessor
    Include = { fg = c.nord10 }, -- preprocessor #include
    Define = { fg = c.nord10 }, -- preprocessor #define
    Macro = { link = "Define" }, -- same as Define
    PreCondit = { link = "PreProc" }, -- preprocessor #if, #else, #endif, etc.

    Type = { fg = c.nord7 }, -- (preferred) int, long, char, etc.
    StorageClass = { fg = c.nord9 }, -- static, register, volatile, etc.
    Structure = { fg = c.nord9 }, -- struct, union, enum, etc.
    Typedef = { fg = c.nord9 }, -- A typedef

    Special = { fg = c.nord4 }, -- (preferred) any special symbol
    SpecialChar = { fg = c.nord13 }, -- special character in a constant
    Tag = { fg = c.nord4 }, -- you can use CTRL-] on this
    Delimiter = { fg = c.nord8 }, -- character that needs attention
    SpecialComment = { fg = c.nord8, style = italic_cfg.SpecialComment }, -- special things inside a comment
    Debug = { fg = c.nord15 }, -- debugging statements

    Underlined = { style = underline }, -- text that stands out, HTML links

    -- Ignore = {}, -- (preferred) left blank, hidden  |hl-Ignore|

    Error = { fg = c.error }, -- (preferred) any erroneous construct

    Todo = { fg = c.warning }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
  }

  theme.additional = {
    -- These groups are for the native LSP client. Some other LSP clients may
    -- use these groups, or use their own. Consult your LSP client's
    -- documentation.
    LspReferenceText = { bg = c.nord2 }, -- used for highlighting "text" references
    LspReferenceRead = { bg = c.nord2 }, -- used for highlighting "read" references
    LspReferenceWrite = { bg = c.nord2 }, -- used for highlighting "write" references

    DiagnosticError = { fg = c.error }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    DiagnosticWarn = { fg = c.warning }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    DiagnosticInfo = { fg = c.info }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    DiagnosticHint = { fg = c.hint }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)

    -- DiagnosticSignError = { }, -- Used for "Error" signs in sign column
    -- DiagnosticSignWarn = { }, -- Used for "Warning" signs in sign column
    -- DiagnosticSignInfo = { }, -- Used for "Information" signs in sign column
    -- DiagnosticSignHint = { }, -- Used for "Hint" signs in sign column
    --
    -- DiagnosticFloatingError = { }, -- Used to color "Error" diagnostic messages in diagnostics float
    -- DiagnosticFloatingWarn = { }, -- Used to color "Warning" diagnostic messages in diagnostics float
    -- DiagnosticFloatingInfo = { }, -- Used to color "Information" diagnostic messages in diagnostics float
    -- DiagnosticFloatingHint = { }, -- Used to color "Hint" diagnostic messages in diagnostics float

    DiagnosticUnderlineError = { style = undercurl, sp = c.error }, -- Used to underline "Error" diagnostics
    DiagnosticUnderlineWarn = { style = undercurl, sp = c.warning }, -- Used to underline "Warning" diagnostics
    DiagnosticUnderlineInfo = { style = undercurl, sp = c.info }, -- Used to underline "Information" diagnostics
    DiagnosticUnderlineHint = { style = undercurl, sp = c.hint }, -- Used to underline "Hint" diagnostics

    -- DiagnosticVirtualTextError = {}, -- Used for "Error" diagnostic virtual text
    -- DiagnosticVirtualTextWarn = {}, -- Used for "Warning" diagnostic virtual text
    -- DiagnosticVirtualTextInfo = {}, -- Used for "Information" diagnostic virtual text
    -- DiagnosticVirtualTextHint = {}, -- Used for "Hint" diagnostic virtual text

    LspSignatureActiveParameter = { fg = c.nord12 },
    LspCodeLens = { link = "Comment" },
  }

  theme.languages = {

    asciidocAttributeEntry = { fg = c.nord10 },
    asciidocAttributeList = { fg = c.nord10 },
    asciidocAttributeRef = { fg = c.nord10 },
    asciidocHLabel = { fg = c.nord9 },
    asciidocListingBlock = { fg = c.nord7 },
    asciidocMacroAttributes = { fg = c.nord8 },
    asciidocOneLineTitle = { fg = c.nord8 },
    asciidocPassthroughBlock = { fg = c.nord9 },
    asciidocQuotedMonospaced = { fg = c.nord7 },
    asciidocTriplePlusPassthrough = { fg = c.nord7 },
    asciidocAdmonition = { link = "Keyword" },
    asciidocAttributRef = { link = "markdownH1" },
    asciidocBackslash = { link = "Keyword" },
    asciidocMacro = { link = "Keyword" },
    asciidocQuotedBold = { link = "Bold" },
    asciidocQuotedEmphasized = { link = "Italic" },
    asciidocQuotedQuotedMonospaced2 = {
      link = "asciidocQuotedMonospaced",
    },
    asciidocQuotedUnconstrainedBold = {
      link = "asciidocBold",
    },
    asciidocQuotedUnconstrainedEmphasized = {
      link = "markdownLinkText",
    },
    asciidocURL = { link = "Keyword" },

    awkCharClass = { fg = c.nord7 },
    awkPatterns = { fg = c.nord9 },
    awkArrayElement = { link = "Identifier" },
    awkBoolLogic = { link = "Keyword" },
    awkBrktRegExp = { link = "SpecialChar" },
    awkComma = { link = "Delimiter" },
    awkExpression = { link = "Keyword" },
    awkFieldVars = { link = "Identifier" },
    awkLineSkip = { link = "Keyword" },
    awkOperator = { link = "Operator" },
    awkRegExp = { link = "SpecialChar" },
    awkSearch = { link = "Keyword" },
    awkSemicolon = { link = "Delimiter" },
    awkSpecialCharacter = { link = "SpecialChar" },
    awkSpecialPrintf = { link = "SpecialChar" },
    awkVariables = { link = "Identifier" },

    cIncluded = { fg = c.nord7 },
    cOperator = { link = "Operator" },
    cPreCondit = { link = "PreCondit" },

    cmakeGeneratorExpression = { fg = c.nord10 },

    csPreCondit = { link = "PreCondit" },
    csType = { link = "Type" },
    csXmlTag = { link = "SpecialComment" },

    cssAttributeSelector = { fg = c.nord7 },
    cssDefinition = { fg = c.nord7 },
    cssIdentifier = { fg = c.nord7 },
    cssStringQ = { fg = c.nord7 },
    cssAttr = { link = "Keyword" },
    cssBraces = { link = "Delimiter" },
    cssClassName = { link = "cssDefinition" },
    cssColor = { link = "Number" },
    cssProp = { link = "cssDefinition" },
    cssPseudoClass = { link = "cssDefinition" },
    cssPseudoClassId = { link = "cssPseudoClass" },
    cssVendor = { link = "Keyword" },

    dosinHeader = { fg = c.nord8 },
    dosiniLabel = { link = "Type" },

    dtBooleanKey = { fg = c.nord7 },
    dtExecKey = { fg = c.nord7 },
    dtLocaleKey = { fg = c.nord7 },
    dtNumericKey = { fg = c.nord7 },
    dtTypeKey = { fg = c.nord7 },
    dtDelim = { link = "Delimiter" },
    dtLocaleValue = { link = "Keyword" },
    dtTypeValue = { link = "Keyword" },

    diffAdded = { fg = c.add },
    diffChanged = { fg = c.change },
    diffRemoved = { fg = c.remove },

    gitconfigVariable = { fg = c.nord7 },

    goBuiltins = { fg = c.nord7 },
    goConstants = { link = "Keyword" },

    helpBar = { fg = c.nord3 },
    helpHyperTextJump = { fg = c.nord8, style = underline },

    htmlArg = { fg = c.nord7 },
    htmlLink = { fg = c.nord4, style = c.none, ps = c.none },
    htmlBold = { link = "Bold" },
    htmlEndTag = { link = "htmlTag" },
    htmlItalic = { link = "Italic" },
    htmlH1 = { link = "markdownH1" },
    htmlH2 = { link = "markdownH2" },
    htmlH3 = { link = "markdownH3" },
    htmlH4 = { link = "markdownH4" },
    htmlH5 = { link = "markdownH5" },
    htmlH6 = { link = "markdownH6" },
    htmlSpecialChar = { link = "SpecialChar" },
    htmlTag = { link = "Keyword" },
    htmlTagN = { link = "htmlTag" },

    javaDocTags = { fg = c.nord7 },
    javaCommentTitle = { link = "Comment" },
    javaScriptBraces = { link = "Delimiter" },
    javaScriptIdentifier = { link = "Keyword" },
    javaScriptNumber = { link = "Number" },

    jsonKeyword = { fg = c.nord7 },

    lessClass = { fg = c.nord7 },
    lessAmpersand = { link = "Keyword" },
    lessCssAttribute = { link = "Delimiter" },
    lessFunction = { link = "Function" },
    cssSelectorOp = { link = "Keyword" },

    lispAtomBarSymbol = { link = "SpecialChar" },
    lispAtomList = { link = "SpecialChar" },
    lispAtomMark = { link = "Keyword" },
    lispBarSymbol = { link = "SpecialChar" },
    lispFunc = { link = "Function" },

    luaFunc = { link = "Function" },

    markdownBlockquote = { fg = c.nord7 },
    markdownCode = { fg = c.nord7 },
    markdownCodeDelimiter = { fg = c.nord7 },
    markdownFootnote = { fg = c.nord7 },
    markdownId = { fg = c.nord7 },
    markdownDeclaration = { fg = c.nord7 },
    markdownLinkText = { fg = c.nord7 },
    markdownUrl = { fg = c.nord7 },
    markdownBold = { link = "Bold" },
    markdownBoldDelimiter = { link = "Keyword" },
    markdownFootnoteDefinition = { link = "markdownFootnote" },
    markdownH1 = { fg = c.nord11 },
    markdownH2 = { fg = c.nord12 },
    markdownH3 = { fg = c.nord13 },
    markdownH4 = { fg = c.nord14 },
    markdownH5 = { fg = c.nord7 },
    markdownH6 = { fg = c.nord9 },
    markdownIdDelimiter = { link = "Keyword" },
    markdownItalic = { link = "Italic" },
    markdownItalicDelimiter = { link = "Keyword" },
    markdownLinkDelimiter = { link = "Keyword" },
    markdownLinkTextDelimiter = { link = "Keyword" },
    markdownListMarker = { link = "Keyword" },
    markdownRule = { link = "Keyword" },
    markdownHeadingDelimiter = { link = "Keyword" },

    ["@punctuation.special.markdown"] = {
      fg = c.nord15,
      style = bold,
    },
    ["@text.literal.markdown"] = { fg = c.nord4 },
    ["@text.literal.markdown_inline"] = { fg = c.nord4 },

    perlPackageDecl = { fg = c.nord7 },

    phpClasses = { fg = c.nord7 },
    phpDocTags = { fg = c.nord7 },
    phpDocCustomTags = { link = "phpDocTags" },
    phpMemberSelector = { link = "Keyword" },

    padCmdText = { fg = c.nord7 },
    padVerbatimLine = { fg = c.nord4 },
    podFormat = { link = "Keyword" },

    pythonBuiltin = { link = "Type" },
    pythonEscape = { link = "SpecialChar" },

    rubyConstant = { fg = c.nord7 },
    rubySymbol = { fg = c.nord6 },
    rubyAttribute = { link = "Identifier" },
    rubyBlockParameterList = { link = "Operator" },
    rubyInterpolationDelimiter = { link = "Keyword" },
    rubyKeywordAsMethod = { link = "Function" },
    rubyLocalVariableOrMethod = { link = "Function" },
    rubyPseudoVariable = { link = "Keyword" },
    rubyRegexp = { link = "SpecialChar" },

    rustAttribute = { fg = c.nord10 },
    rustEnum = { fg = c.nord7 },
    rustMacro = { fg = c.nord8 },
    rustModPath = { fg = c.nord7 },
    rustPanic = { fg = c.nord9 },
    rustModTrait = { fg = c.nord7 },
    rustCommentLineDoc = { link = "Comment" },
    rustDerive = { link = "rustAttribute" },
    rustEnumVariant = { link = "rustEnum" },
    rustEscape = { link = "SpecialChar" },
    rustQuestionMark = { link = "Keyword" },

    sassClass = { fg = c.nord7 },
    sassId = { fg = c.nord7 },
    sassAmpersand = { link = "Keyword" },
    sassClassChar = { link = "Delimiter" },
    sassControl = { link = "Keyword" },
    sassControlLine = { link = "Keyword" },
    sassExtend = { link = "Keyword" },
    sassFor = { link = "Keyword" },
    sassFunctionDecl = { link = "Keyword" },
    sassFunctionName = { link = "Function" },
    sassidChar = { link = "sassId" },
    sassInclude = { link = "SpecialChar" },
    sassMixinName = { link = "Function" },
    sassMixing = { link = "SpecialChar" },
    sassReturn = { link = "Keyword" },

    shCmdParenRegion = { link = "Delimiter" },
    shCmdSubRegion = { link = "Delimiter" },
    shDerefSimple = { link = "Identifier" },
    shDerefVar = { link = "Identifier" },

    sqlKeyword = { link = "Keyword" },
    sqlSpecial = { link = "Keyword" },

    vimAugroup = { fg = c.nord7 },
    vimMapRhs = { fg = c.nord7 },
    vimNotation = { fg = c.nord7 },
    vimFunc = { link = "Function" },
    vimFunction = { link = "Function" },
    vimUserFunc = { link = "Function" },

    xmlAttrib = { fg = c.nord7 },
    xmlCdataStart = { fg = c.nord3 },
    xmlNamespace = { fg = c.nord7 },
    xmlAttribPunct = { link = "Delimiter" },
    xmlCdata = { link = "Comment" },
    xmlCdataCdata = { link = "xmlCdataStart" },
    xmlCdataEnd = { link = "xmlCdataStart" },
    xmlEndTag = { link = "xmlTagName" },
    xmlProcessingDelim = { link = "Keyword" },
    xmlTagName = { link = "Keyword" },

    yamlBlockMappingKey = { fg = c.nord7 },
    yamlBool = { link = "Keyword" },
    yamlDocumentStart = { link = "Keyword" },
  }

  theme.plugins = {
    -- Bufferline
    TabLineSelector = { fg = c.nord9 },
    TabLineDuplicate = { fg = c.nord15 },

    -- Dashboard
    DashboardShortCut = { fg = c.nord9 },
    DashboardHeader = { fg = c.nord15 },
    DashboardCenter = { fg = c.nord4 },
    DashboardFooter = { fg = c.nord3_bright, style = italic },

    -- Diff
    diffAdded = { link = "DiffAdd" },
    diffChanged = { link = "DiffChange" },
    diffRemoved = { link = "DiffRemove" },
    diffOldFile = { fg = c.nord13 },
    diffNewFile = { fg = c.nord12 },
    diffFile = { fg = c.nord7 },
    diffLine = { fg = c.nord3 },
    diffIndexLine = { fg = c.nord9 },

    -- GitSigns
    GitSignsAdd = { fg = c.add },
    GitSignsAddNr = { fg = c.add },
    GitSignsAddLn = { fg = c.add },
    GitSignsChange = { fg = c.change },
    GitSignsChangeNr = { fg = c.change },
    GitSignsChangeLn = { fg = c.change },
    GitSignsDelete = { fg = c.remove },
    GitSignsDeleteNr = { fg = c.remove },
    GitSignsDeleteLn = { fg = c.remove },

    -- Indent Blankline
    IndentBlanklineChar = { fg = c.nord3 },
    IndentBlanklineContextChar = { fg = c.nord10 },

    -- Lightspeed
    LightspeedLabel = { fg = c.nord8, style = bold }, -- The character needed to be pressed to jump to the match position, after the whole search pattern has been given. It appears top of the second character of the pair, after the first input has been given.
    LightspeedLabelOverlapped = {
      fg = c.nord8,
      style = bold .. underline,
    }, -- When matches overlap, labels get next to each other - in that case they get different highlights, to be more easily distinguishable (slightly lighter or darker, depending on the global background).
    LightspeedLabelDistant = { fg = c.nord15, style = bold },
    LightspeedLabelDistantOverlapped = {
      fg = c.nord15,
      style = bold .. underline,
    }, -- If the number of matches exceeds the available target labels, the next group of labeled targets are shown with a different color. Those can be reached by pressing `cycle_group_fwd_key` before the label character.
    LightspeedShortcut = { fg = c.nord10, style = bold },
    LightspeedShortcutOverlapped = {
      fg = c.nord10,
      style = bold .. underline,
    }, -- Labels for positions that can be jumped to right after the first input (see |lightspeed-shortcuts|). These are highlighted as "inverted" labels by default (background/foreground switched).
    LightspeedMaskedChar = {
      fg = c.nord4,
      bg = c.nord2,
      style = bold,
    }, -- The second character of the match, that is shown on top of the first one, as a reminder.
    LightspeedGreyWash = { fg = c.nord3_bright }, -- Foreground color of the "washed out" area for 2-character search. Depending on the colorscheme, it might be appropriate to link this to the Comment highlight group.
    LightspeedUnlabeledMatch = { fg = c.nord4, bg = c.nord1 }, -- Matches that can be jumped to automatically, i.e. do not get a label - the only ones, and the first ones if `jump_to_first_match` is on. (Bold black or white by default, depending on the global background.)
    LightspeedOneCharMatch = { fg = c.nord8, style = bold .. inverse }, -- Matching characters of f/t search. (Default: |LightspeedShortcut| without underline. Setting some background color is recommended, as there is no "grey wash" for one-character search mode.)
    LightspeedUniqueChar = { style = bold .. underline }, -- Unique characters in the search direction, shown if `highlight_unique_chars` is on. Uses the same settings as |LightspeedUnlabeledMatch| by default.
    -- LightSpeedPeindigOpArea = {} -- When jumping based on partial input in
    -- operator-pending mode, we do not see the operation executed right away,
    -- because of the "safety" timeout (see |lightspeed-jump-on-partial-input|),
    -- therefore we set a temporary highlight on the operated area.
    -- LightspeedCursor = {} -- Linked to |hl-Cursor| by default.

    -- Neogit
    NeogitBranch = { fg = c.nord7, style = bold },
    NeogitRemote = { fg = c.nord13 },
    NeogitNotificationInfo = { fg = c.success },
    NeogitNotificationWarning = { fg = c.warning },
    NeogitNotificationError = { fg = c.error },
    NeogitDiffAddHighlight = { fg = c.add, bg = c.nord1 },
    NeogitDiffDeleteHighlight = { fg = c.remove, bg = c.nord1 },
    NeogitDiffContextHighlight = {
      bg = c.nord1,
      fg = c.nord4,
    },
    NeogitHunkHeader = { fg = c.nord9 },
    NeogitHunkHeaderHighlight = { fg = c.nord9, bg = c.nord1 },

    -- Neovim
    healthError = { fg = c.error },
    healthSuccess = { fg = c.success },
    healthWarning = { fg = c.warning },

    -- nvim-cmp
    CmpItemAbbr = { fg = c.nord4 },
    CmpItemAbbrDeprecated = { fg = c.nord3_bright },
    CmpItemAbbrMatch = { fg = c.nord8, style = bold .. inverse },
    CmpItemAbbrMatchFuzzy = {
      fg = c.nord8,
      bg = { gui = c.nord0.gui },
      style = bold .. inverse,
    },
    CmpItemKind = { fg = c.nord9 },
    CmpItemMenu = { fg = c.nord3_bright },
    CmpGhostText = { fg = c.nord3 },
    CmpDocumentation = { bg = c.nord3 },

    -- nvim-dap
    DapBreakpoint = { fg = c.nord11 },
    DapStopped = { fg = c.nord15 },

    -- octo.nvim
    OctoEditable = { bg = c.nord1 },

    -- nvim-ts-rainbow
    rainbowcol1 = { fg = c.nord10 },
    rainbowcol2 = { fg = c.nord15 },
    rainbowcol3 = { fg = c.nord14 },
    rainbowcol4 = { fg = c.nord13 },
    rainbowcol5 = { fg = c.nord12 },
    rainbowcol6 = { fg = c.nord11 },
    rainbowcol7 = { fg = c.nord9 },

    -- Telescope
    TelescopePromptBorder = { fg = c.nord15 },
    TelescopeResultsBorder = { fg = c.nord9 },
    TelescopePreviewBorder = { fg = c.nord10 },
    TelescopeSelectionCaret = { fg = c.nord9, style = bold },
    TelescopeSelection = { fg = c.nord9, style = bold },
    TelescopeMatching = { fg = c.nord8 },
    -- TelescopeNormal = {},

    -- Tree-sitter
    ["@attribute"] = { fg = c.nord10 }, -- Annotations that can be attached to the code to denote some kind of meta information. e.g. C++/Dart attributes.
    ["@boolean"] = { link = "Boolean" }, -- Boolean literals: `True` and `False` in Python.

    ["@character"] = { link = "Character" }, -- Character literals: `'a'` in C.

    ["@comment"] = { link = "Comment" }, -- Line comments and block comments.

    ["@conditional"] = { link = "Conditional" }, -- Keywords related to conditionals: `if`, `when`, `cond`, etc.

    ["@constant"] = { link = "Constant" }, -- Constants identifiers. These might not be semantically constant. E.g. uppercase variables in Python.
    ["@constant.builtin"] = { link = "Constant" }, -- Built-in constant values: `nil` in Lua.
    ["@constant.macro"] = { link = "Function" }, -- Constants defined by macros: `NULL` in C.

    ["@constructor"] = { link = "Function" }, -- Constructor calls and definitions: `{}` in Lua, and Java constructors.

    ["@error"] = { link = "Error" }, -- Syntax/parser errors. This might highlight large sections of code while the user is typing still incomplete code, use a sensible highlight.

    ["@exception"] = { link = "Exception" }, -- Exception related keywords: `try`, `except`, `finally` in Python.

    ["@field"] = { link = "Identifier" }, -- Object and struct fields.

    ["@float"] = { link = "Float" }, -- Floating-point number literals.
    ["@function"] = { link = "Function" }, -- Function calls and definitions.
    ["@function.builtin"] = { link = "Function" }, -- Built-in functions: `print` in Lua.
    ["@function.macro"] = { fg = c.nord8 }, -- Macro defined functions (calls and definitions): each `macro_rules` in Rust.
    ["@include"] = { link = "Include" }, -- File or module inclusion keywords: `#include` in C, `use` or `extern crate` in Rust.
    ["@keyword"] = { link = "Keyword" }, -- Keywords that don't fit into other categories.
    ["@keyword.function"] = { link = "Keyword" }, -- Keywords used to define a function: `function` in Lua, `def` and `lambda` in Python.
    ["@keyword.operator"] = { link = "Keyword" }, -- Unary and binary operators that are English words: `and`, `or` in Python; `sizeof` in C.
    ["@keyword.return"] = { link = "Keyword" }, -- Keywords like `return` and `yield`.
    ["@label"] = { link = "Label" }, -- GOTO labels: `label:` in C, and `::label::` in Lua.
    ["@method"] = { link = "Function" }, -- Method calls and definitions.
    ["@namespace"] = { fg = c.nord7 }, -- Identifiers referring to modules and namespaces.
    -- ["@none"] = {}, -- No highlighting (sets all highlight arguments to `NONE`). this group is used to clear certain ranges, for example, string interpolations. Don't change the values of this highlight group.
    ["@number"] = { link = "Number" }, -- Numeric literals that don't fit into other categories.
    ["@operator"] = { link = "Operator" }, -- Binary or unary operators: `+`, and also `->` and `*` in C.
    ["@parameter"] = { fg = c.nord10 }, -- Parameters of a function.
    ["@parameter.reference"] = { link = "@parameter" }, -- References to parameters of a function.
    ["@property"] = { link = "@field" }, -- Same as `@field`.
    ["@punctuation.delimiter"] = { link = "Delimiter" }, -- Punctuation delimiters: Periods, commas, semicolons, etc.
    ["@punctuation.bracket"] = { link = "Delimiter" }, -- Brackets, braces, parentheses, etc.
    ["@punctuation.special"] = { link = "Delimiter" }, -- Special punctuation that doesn't fit into the previous categories.
    ["@repeat"] = { link = "Repeat" }, -- Keywords related to loops: `for`, `while`, etc.
    ["@string"] = { link = "String" }, -- String literals.
    ["@string.regex"] = { link = "String" }, -- Regular expression literals.
    ["@string.escape"] = { fg = c.nord13 }, -- Escape characters within a string: `\n`, `\t`, etc.
    ["@string.special"] = { link = "@string.escape" }, -- Strings with special meaning that don't fit into the previous categories.
    ["@symbol"] = { link = "Identifier" }, -- Identifiers referring to symbols or atoms.
    ["@tag"] = { link = "Tag" }, -- Tags like HTML tag names.
    ["@tag.attribute"] = { link = "@attribute" }, -- HTML tag attributes.
    ["@tag.delimiter"] = { link = "Delimiter" }, -- Tag delimiters like `<` `>` `/`.
    ["@text"] = { link = "Text" }, -- Non-structured text. Like text in a markup language.
    ["@text.emphasis"] = { link = "Italic" }, -- Text to be represented with emphasis.
    ["@text.literal"] = { fg = c.nord13 }, -- Literal or verbatim text
    ["@text.math"] = { fg = c.nord15 }, -- Math environments like LaTeX's `$ ... $`
    ["@text.reference"] = { fg = c.nord8 }, -- Footnotes, text references, citations, etc.
    ["@text.strike"] = { style = strikethrough }, -- Strikethrough text.
    ["@text.strong"] = { link = "Bold" }, -- Text to be represented in bold.
    ["@text.title"] = { fg = c.nord12, style = bold }, -- text that is part of a title
    ["@text.underline"] = { link = "Underline" }, -- Text to be represented with an underline.
    ["@text.uri"] = { fg = c.nord10, style = underline }, -- URIs like hyperlinks or email addresses.
    ["@text.environment"] = { bg = c.nord1 }, -- Text environments of markup languages.
    ["@text.environment.name"] = { link = "Tag" }, -- Text/string indicating the type of text environment. Like the name of `\begin` block in LaTeX.
    ["@text.note"] = { fg = c.info }, -- Text representation of an informational note.
    ["@text.warning"] = { fg = c.warning }, -- Text representation of a warning note.
    ["@text.danger"] = { fg = c.error }, -- Text representation of a danger note.
    ["@type"] = { link = "Type" }, -- Type (and class) definitions and annotations.
    ["@type.builtin"] = { link = "TypeBuiltin" }, -- Built-in types: `i32` in Rust.
    ["@variable"] = { link = "Identifier" }, -- Variable names that don't fit into other categories.
    ["@variable.builtin"] = { link = "Keyword" }, -- Variable names defined by the language: `this` or `self` in Javascript.

    -- Which-key.nvim
    WhichKey = { link = "Function" }, -- the key
    WhichKeyGroup = { link = "Keyword" }, -- a group
    WhichKeySeparator = { link = "Keyword" }, -- the separator between the key and its label
    WhichKeyDesc = { link = "Identifier" }, -- the label of the key
    WhichKeyFloat = { fg = c.nord4, bg = c.nord1 }, -- Normal in the popup window
    WhichKeyValue = { link = "Comment" }, -- used by plugins that provide values
  }

  return theme
end

return M
