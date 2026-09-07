local M = {}

local default_config = {
  transparent = false,
  disable_italics = false,
}
local config = vim.deepcopy(default_config)
local configured = false

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local function link_map(pairs_by_target)
  for target, sources in pairs(pairs_by_target) do
    for _, src in ipairs(sources) do
      hi(src, { link = target })
    end
  end
end

function M.setup(opts)
  if opts ~= nil then
    config = vim.tbl_deep_extend("force", default_config, opts)
    configured = true
  elseif not configured then
    config = vim.deepcopy(default_config)
  end

  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
  vim.g.colors_name = "natural"
  vim.opt.background = "dark"
  vim.opt.termguicolors = false

  local bg = config.transparent and "NONE" or 0
  local italic = not config.disable_italics

  -- Base UI
  hi("Normal",       { ctermfg = 7, ctermbg = bg })
  hi("Cursor",       { ctermfg = 0, ctermbg = 7 })
  hi("CursorLine",   { ctermfg = 7, ctermbg = 8 })
  hi("CursorColumn", { ctermbg = 8 })
  hi("LineNr",       { ctermfg = 8 })
  hi("CursorLineNr", { ctermfg = 7 })

  -- Basic syntax (the "natural" palette)
  hi("Comment",        { ctermfg = 8,  italic = italic })
  hi("String",         { ctermfg = 2 })
  hi("Character",      { ctermfg = 10 })
  hi("Number",         { ctermfg = 6 })
  hi("Float",          { ctermfg = 6 })
  hi("Boolean",        { ctermfg = 1 })
  hi("Constant",       { ctermfg = 5 })
  hi("Identifier",     { ctermfg = 7 })
  hi("Function",       { ctermfg = 4 })
  hi("Method",         { ctermfg = 4 })
  hi("Statement",      { ctermfg = 3 })
  hi("Conditional",    { ctermfg = 3 })
  hi("Repeat",         { ctermfg = 3 })
  hi("Label",          { ctermfg = 3 })
  hi("Keyword",        { ctermfg = 3 })
  hi("Operator",       { ctermfg = 7 })
  hi("Exception",      { ctermfg = 1 })
  hi("PreProc",        { ctermfg = 13 })
  hi("Include",        { ctermfg = 13 })
  hi("Define",         { ctermfg = 13 })
  hi("Macro",          { ctermfg = 13 })
  hi("PreCondit",      { ctermfg = 13 })
  hi("Type",           { ctermfg = 4, bold = true })
  hi("Class",          { ctermfg = 4, bold = true })
  hi("StorageClass",   { ctermfg = 3 })
  hi("Structure",      { ctermfg = 3 })
  hi("Typedef",        { ctermfg = 12 })
  hi("Special",        { ctermfg = 6 })
  hi("SpecialChar",    { ctermfg = 14 })
  hi("Tag",            { ctermfg = 1 })
  hi("Delimiter",      { ctermfg = 8 })
  hi("SpecialComment", { ctermfg = 11 })
  hi("Debug",          { ctermfg = 9 })
  hi("Variable",       { ctermfg = 7 })
  hi("Property",       { ctermfg = 6 })

  -- UI chrome
  hi("Visual",         { ctermbg = 8 })
  hi("Search",         { ctermfg = 0, ctermbg = 3,  bold = true })
  hi("IncSearch",      { ctermfg = 0, ctermbg = 11, bold = true })
  hi("StatusLine",     { ctermfg = 7, ctermbg = 8,  bold = true })
  hi("StatusLineNC",   { ctermfg = 8 })
  hi("VertSplit",      { ctermfg = 8 })
  hi("Pmenu",          { ctermfg = 7, ctermbg = 8 })
  hi("PmenuSel",       { ctermfg = 0, ctermbg = 4,  bold = true })
  hi("PmenuSbar",      { ctermbg = 8 })
  hi("PmenuThumb",     { ctermbg = 7 })
  hi("TabLine",        { ctermfg = 8 })
  hi("TabLineFill",    { ctermfg = 8 })
  hi("TabLineSel",     { ctermfg = 7, ctermbg = 8,  bold = true })

  hi("DiffAdd",        { ctermfg = 2,  bold = true })
  hi("DiffChange",     { ctermfg = 3 })
  hi("DiffDelete",     { ctermfg = 1,  bold = true })
  hi("DiffText",       { ctermfg = 11, bold = true })

  hi("Error",          { ctermfg = 9,  bold = true })
  hi("Warning",        { ctermfg = 11, bold = true })
  hi("ErrorMsg",       { ctermfg = 9,  bold = true })
  hi("WarningMsg",     { ctermfg = 11, bold = true })
  hi("Question",       { ctermfg = 2,  bold = true })
  hi("MoreMsg",        { ctermfg = 2,  bold = true })

  hi("Folded",         { ctermfg = 8, italic = italic })
  hi("FoldColumn",     { ctermfg = 8 })

  hi("SpellBad",       { ctermfg = 1, underline = true })
  hi("SpellCap",       { ctermfg = 4, underline = true })
  hi("SpellLocal",     { ctermfg = 6, underline = true })
  hi("SpellRare",      { ctermfg = 5, underline = true })

  hi("NormalFloat",    { ctermfg = 7, ctermbg = bg })
  hi("FloatBorder",    { ctermfg = 8, ctermbg = bg })
  hi("FloatTitle",     { ctermfg = 4, ctermbg = bg, bold = true })
  hi("Directory",      { ctermfg = 4, bold = true })

  -- Diagnostics
  hi("DiagnosticError",            { ctermfg = 9 })
  hi("DiagnosticWarn",             { ctermfg = 11 })
  hi("DiagnosticInfo",             { ctermfg = 12 })
  hi("DiagnosticHint",             { ctermfg = 14 })
  hi("DiagnosticOk",               { ctermfg = 2 })
  hi("DiagnosticVirtualTextError", { ctermfg = 9 })
  hi("DiagnosticVirtualTextWarn",  { ctermfg = 11 })
  hi("DiagnosticVirtualTextInfo",  { ctermfg = 12 })
  hi("DiagnosticVirtualTextHint",  { ctermfg = 14 })
  hi("DiagnosticVirtualTextOk",    { ctermfg = 2 })
  hi("DiagnosticUnderlineError",   { ctermfg = 9,  underline = true })
  hi("DiagnosticUnderlineWarn",    { ctermfg = 11, underline = true })
  hi("DiagnosticUnderlineInfo",    { ctermfg = 12, underline = true })
  hi("DiagnosticUnderlineHint",    { ctermfg = 14, underline = true })
  hi("DiagnosticUnderlineOk",      { ctermfg = 2,  underline = true })
  hi("DiagnosticSignError",        { ctermfg = 9 })
  hi("DiagnosticSignWarn",         { ctermfg = 11 })
  hi("DiagnosticSignInfo",         { ctermfg = 12 })
  hi("DiagnosticSignHint",         { ctermfg = 14 })
  hi("DiagnosticSignOk",           { ctermfg = 2 })

  hi("LspReferenceText",            { ctermbg = 8 })
  hi("LspReferenceRead",            { ctermbg = 8 })
  hi("LspReferenceWrite",           { ctermbg = 8 })
  hi("LspSignatureActiveParameter", { ctermfg = 10, bold = true })
  hi("LspCodeLens",                 { ctermfg = 8, italic = italic })
  hi("LspCodeLensSeparator",        { ctermfg = 8 })
  hi("LspInlayHint",                { ctermfg = 8, ctermbg = bg, italic = italic })

  -- Treesitter captures -> basic syntax
  link_map({
    Comment      = { "@comment", "@comment.documentation" },
    String       = { "@string", "@string.regex" },
    Character    = { "@character" },
    SpecialChar  = { "@string.escape", "@string.special", "@character.special", "@punctuation.special" },
    Number       = { "@number", "@float" },
    Boolean      = { "@boolean" },
    Constant     = { "@constant", "@constant.builtin", "@constant.macro", "@symbol" },
    Identifier   = { "@variable", "@parameter", "@parameter.reference" },
    Function     = { "@function", "@function.call", "@function.builtin", "@function.macro", "@method", "@method.call" },
    Type         = { "@type", "@type.builtin", "@type.definition", "@constructor", "@namespace" },
    StorageClass = { "@type.qualifier", "@storageclass" },
    Keyword      = { "@keyword", "@keyword.function", "@keyword.operator", "@keyword.return" },
    Conditional  = { "@conditional" },
    Repeat       = { "@repeat" },
    Exception    = { "@exception" },
    Include      = { "@include" },
    Define       = { "@define" },
    PreProc      = { "@annotation", "@attribute" },
    Operator     = { "@operator", "@punctuation.bracket", "@punctuation.delimiter" },
    Special      = { "@property", "@field", "@variable.builtin" },
    Label        = { "@label" },
    Tag          = { "@tag" },
    Delimiter    = { "@tag.delimiter" },
    Error        = { "@error", "@debug" },
  })

  -- LSP semantic tokens -> basic syntax
  link_map({
    Comment      = { "@lsp.type.comment" },
    String       = { "@lsp.type.string", "@lsp.type.regexp" },
    Number       = { "@lsp.type.number" },
    Constant     = { "@lsp.type.enumMember" },
    Identifier   = { "@lsp.type.variable", "@lsp.type.parameter" },
    Function     = { "@lsp.type.function", "@lsp.type.method", "@lsp.type.event" },
    Type         = { "@lsp.type.type", "@lsp.type.class", "@lsp.type.enum", "@lsp.type.interface", "@lsp.type.struct", "@lsp.type.typeParameter", "@lsp.type.namespace" },
    StorageClass = { "@lsp.type.modifier" },
    Keyword      = { "@lsp.type.keyword" },
    PreProc      = { "@lsp.type.decorator", "@lsp.type.macro" },
    Operator     = { "@lsp.type.operator" },
    Special      = { "@lsp.type.property" },
  })
end

return M
