return
{
  'logannday/gruber-darker-nvim',
  version = false,
  priority = 1000,
  config = function()
    -- Load the base gruber-darker theme first
    vim.cmd.colorscheme("gruber-darker")

    -- Tokyo Night base-16 palette for accents
    local tokyo_accents = {
      keyword = "#bb9af7",       -- tokyo night purple for keywords
      function_name = "#7dcfff", -- tokyo night cyan for functions
      constant = "#ff9e64",      -- tokyo night orange for constants
      comment = "#565f89",       -- tokyo night comment blue-gray
      type = "#2ac3de",          -- tokyo night teal for types
      macro = "#f7768e",         -- tokyo night red for macros
      string = "#9ece6a",        -- tokyo night green for strings
      field = "#73daca",         -- tokyo night teal-green for fields/properties
      namespace = "#bb9af7",     -- tokyo night purple for namespaces/modules
    }

    local function apply_tokyo_accents()
      -- Keywords - purple with bold
      vim.api.nvim_set_hl(0, "@keyword", { fg = tokyo_accents.keyword, bold = true })
      vim.api.nvim_set_hl(0, "@keyword.function", { fg = tokyo_accents.keyword, bold = true })
      vim.api.nvim_set_hl(0, "@keyword.return", { fg = tokyo_accents.keyword, bold = true })
      vim.api.nvim_set_hl(0, "@conditional", { fg = tokyo_accents.keyword, bold = true })
      vim.api.nvim_set_hl(0, "@repeat", { fg = tokyo_accents.keyword, bold = true })
      vim.api.nvim_set_hl(0, "@keyword.operator", { fg = tokyo_accents.keyword, bold = true })

      -- Function names - cyan
      vim.api.nvim_set_hl(0, "@function", { fg = tokyo_accents.function_name })
      vim.api.nvim_set_hl(0, "@function.builtin", { fg = tokyo_accents.function_name })
      vim.api.nvim_set_hl(0, "@method", { fg = tokyo_accents.function_name })
      vim.api.nvim_set_hl(0, "@function.call", { fg = tokyo_accents.function_name })
      vim.api.nvim_set_hl(0, "@method.call", { fg = tokyo_accents.function_name })

      -- Constants - orange
      vim.api.nvim_set_hl(0, "@constant", { fg = tokyo_accents.constant })
      vim.api.nvim_set_hl(0, "@constant.builtin", { fg = tokyo_accents.constant })
      vim.api.nvim_set_hl(0, "@number", { fg = tokyo_accents.constant })
      vim.api.nvim_set_hl(0, "@boolean", { fg = tokyo_accents.constant })

      -- Types and macros - teal and red respectively
      vim.api.nvim_set_hl(0, "@type", { fg = tokyo_accents.type })
      vim.api.nvim_set_hl(0, "@type.builtin", { fg = tokyo_accents.type })
      vim.api.nvim_set_hl(0, "@type.definition", { fg = tokyo_accents.type })
      vim.api.nvim_set_hl(0, "@storageclass", { fg = tokyo_accents.type })

      -- Macros (Rust, C, etc.) - red
      vim.api.nvim_set_hl(0, "@macro", { fg = tokyo_accents.macro })
      vim.api.nvim_set_hl(0, "@attribute", { fg = tokyo_accents.macro })
      vim.api.nvim_set_hl(0, "@preproc", { fg = tokyo_accents.macro })

      -- Strings - green
      vim.api.nvim_set_hl(0, "@string", { fg = tokyo_accents.string })
      vim.api.nvim_set_hl(0, "@string.regex", { fg = tokyo_accents.string })
      vim.api.nvim_set_hl(0, "@string.escape", { fg = tokyo_accents.constant })

      -- Comments - Tokyo Night blue-gray
      vim.api.nvim_set_hl(0, "@comment", { fg = tokyo_accents.comment, italic = true })
      vim.api.nvim_set_hl(0, "@comment.documentation", { fg = tokyo_accents.comment, italic = true })
      vim.api.nvim_set_hl(0, "Comment", { fg = tokyo_accents.comment, italic = true })

      -- Variables - keep as Gruber default (don't override)
      -- vim.api.nvim_set_hl(0, "@variable", { fg = ... }) -- Let Gruber handle this
      vim.api.nvim_set_hl(0, "@variable.builtin", { fg = tokyo_accents.constant })
      -- vim.api.nvim_set_hl(0, "@parameter", { fg = ... }) -- Let Gruber handle this

      -- Fields/Properties - Tokyo Night teal-green (works across all languages)
      vim.api.nvim_set_hl(0, "@property", { fg = tokyo_accents.field })
      vim.api.nvim_set_hl(0, "@field", { fg = tokyo_accents.field })
      vim.api.nvim_set_hl(0, "@variable.member", { fg = tokyo_accents.field })

      -- Namespaces/Modules - purple
      vim.api.nvim_set_hl(0, "@namespace", { fg = tokyo_accents.namespace })
      vim.api.nvim_set_hl(0, "@module", { fg = tokyo_accents.namespace })

      -- LSP-specific highlights
      vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { fg = tokyo_accents.constant, bold = true })
      vim.api.nvim_set_hl(0, "@lsp.type.keyword", { fg = tokyo_accents.keyword, bold = true })
      vim.api.nvim_set_hl(0, "@lsp.type.type", { fg = tokyo_accents.type })
      vim.api.nvim_set_hl(0, "@lsp.type.macro", { fg = tokyo_accents.macro })
      vim.api.nvim_set_hl(0, "@lsp.type.function", { fg = tokyo_accents.function_name })
      vim.api.nvim_set_hl(0, "@lsp.type.method", { fg = tokyo_accents.function_name })
      -- Variables - let Gruber handle these
      -- vim.api.nvim_set_hl(0, "@lsp.type.variable", { fg = ... })
      -- vim.api.nvim_set_hl(0, "@lsp.type.parameter", { fg = ... })
      vim.api.nvim_set_hl(0, "@lsp.type.property", { fg = tokyo_accents.field })
      vim.api.nvim_set_hl(0, "@lsp.type.field", { fg = tokyo_accents.field })
      vim.api.nvim_set_hl(0, "@lsp.type.namespace", { fg = tokyo_accents.namespace })
      vim.api.nvim_set_hl(0, "@lsp.type.module", { fg = tokyo_accents.namespace })

      -- Completion menu colors
      vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = tokyo_accents.keyword })
      vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = tokyo_accents.function_name })
      vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = tokyo_accents.function_name })
      -- Variables - let Gruber handle
      -- vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = ... })
      vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = tokyo_accents.constant })
      vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = tokyo_accents.type })
      vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = tokyo_accents.type })
      vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = tokyo_accents.type })
      vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = tokyo_accents.type })
      vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = tokyo_accents.namespace })
      vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = tokyo_accents.field })
      vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = tokyo_accents.field })

      -- Diagnostic colors (keep minimal, just hints)
      vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = tokyo_accents.comment })
    end

    -- Apply accents immediately
    apply_tokyo_accents()

    -- Reapply when colorscheme changes
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "gruber-darker",
      callback = apply_tokyo_accents,
    })
  end
}
