-- MyCustomColorscheme for NVim

-- Define a function for setting highlight groups
local function highlight(group, fg, bg, attr)
    local cmd = 'highlight ' .. group
    if fg then cmd = cmd .. ' guifg=' .. fg end
    if bg then cmd = cmd .. ' guibg=' .. bg end
    if attr then cmd = cmd .. ' gui=' .. attr end
    vim.cmd(cmd)
end

-- Background and foreground settings
highlight('Normal', '#bbbbbb', '#0a0b0a')
highlight('Comment', '#858585', nil, 'italic') -- Emphasis Italic for comments
highlight('Constant', '#87a1c5')
highlight('ConstantCharacter', '#87a1c5')
highlight('ConstantCharacterEscape', '#87a1c5')
highlight('ConstantLanguage', '#81b38c')
highlight('ConstantNumeric', '#c05776')
highlight('ConstantRegexp', '#87a1c5')
highlight('EntityNameClass', '#7574a5')
highlight('EntityNameFunction', '#7574a5')
highlight('EntityNameTag', '#81b38c')
highlight('EntityOtherAttributeName', '#7574a5')
highlight('EntityOtherInheritedClass', '#7574a5', nil, 'bold')
highlight('InvalidDeprecated', '#bbbbbb', '#87a1c5')
highlight('InvalidIllegal', '#bbbbbb', '#c05776')
highlight('Keyword', '#81b38c')
highlight('KeywordOperator', '#81b38c')
highlight('KeywordOtherNew', '#81b38c')
highlight('MarkupBold', nil, nil, 'bold')
highlight('MarkupChanged', '#87a1c5')
highlight('MarkupDeleted', '#c05776')
highlight('MarkupInserted', '#a7ecb7')
highlight('MetaPreprocessor', '#5E81AC')
highlight('Punctuation', '#e8e8e8')
highlight('PunctuationDefinitionMethodParams', '#e8e8e8')
highlight('PunctuationDefinitionTag', '#81b38c')
highlight('PunctuationDefinitionComment', '#858585')
highlight('PunctuationSection', '#e8e8e8')
highlight('PunctuationSectionEmbedded', '#81b38c')
highlight('PunctuationTerminator', '#81b38c')
highlight('PunctuationDefinitionVariable', '#81b38c')
highlight('Storage', '#81b38c')
highlight('String', '#a7ecb7')
highlight('StringRegexp', '#87a1c5')
highlight('SupportClass', '#7574a5')
highlight('SupportConstant', '#81b38c')
highlight('SupportFunction', '#7574a5')
highlight('SupportFunctionConstruct', '#81b38c')
highlight('SupportType', '#7574a5')
highlight('SupportTypeException', '#7574a5')
highlight('TokenDebug', '#507057')
highlight('TokenError', '#c05776')
highlight('TokenInfo', '#7574a5')
highlight('TokenWarning', '#87a1c5')
highlight('VariableOther', '#bbbbbb')
highlight('VariableLanguage', '#81b38c')
highlight('VariableParameter', '#bbbbbb')

-- Additional Language-Specific Highlights

-- C/CPP
highlight('PunctuationSeparatorPointerAccess', '#81b38c')
highlight('MetaPreprocessorInclude', '#7574a5', nil, 'bold')
highlight('ConditionalDirective', '#5E81AC', nil, 'bold')

-- CSS
highlight('ConstantColorRGB', '#507057')
highlight('MetaPropertyValue', '#7574a5')
highlight('MediaQueries', '#a3be8c')
highlight('PunctuationDefinitionKeywordCSS', '#81b38c')
highlight('SupportTypePropertyName', '#bbbbbb')

-- Diff
highlight('MetaDiffRangeContext', '#7574a5')
highlight('MetaDiffHeaderFromFile', '#7574a5')
highlight('PunctuationDiffRange', '#7574a5')

-- Go
highlight('ConstantOtherPlaceholderGo', '#87a1c5')

-- Java/JavaDoc
highlight('JavaDocCommentBlock', '#858585')
highlight('JavaConstantOther', '#bbbbbb')
highlight('JavaKeywordOtherDocumentation', '#7574a5')

-- JavaScript
highlight('JavaScriptMetaObjectLiteralKey', '#7574a5')
highlight('JavaScriptTemplateLiteralPunctuation', '#5E81AC')

-- Markdown
highlight('MarkdownFencedCodeBlock', '#507057')
highlight('MarkdownHeading', '#81b38c')
highlight('MarkdownQuote', '#454545')
highlight('MarkdownList', '#81b38c')
highlight('MarkdownLink', nil, nil, 'underline')
highlight('MarkdownItalic', nil, nil, 'italic')

-- Python
highlight('PythonFunctionDecorator', '#a3be8c')
highlight('PythonSupportType', '#7574a5')

-- YAML
highlight('YAMLEntityNameTag', '#7574a5')

-- XML
highlight('XMLKeywordOtherDoctype', '#5E81AC')
