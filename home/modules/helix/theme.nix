{ colorscheme }: {
  "${colorscheme.slug}" = {
    palette = builtins.mapAttrs (name: value: "#${value}") colorscheme.colors; # Add leading '#'
    "attributes" = "base09";
    "comment" = { fg = "base03"; modifiers = [ "italic" ]; };
    "constant" = "base09";
    "constant.character.escape" = "base0C";
    "constant.numeric" = "base09";
    "constructor" = "base0D";
    "debug" = "base03";
    "diagnostic" = { modifiers = [ "underlined" ]; };
    "diff.delta" = "base09";
    "diff.minus" = "base08";
    "diff.plus" = "base0B";
    "error" = "base08";
    "function" = "base0D";
    "hint" = "base03";
    "info" = "base0D";
    "keyword" = "base0E";
    "label" = "base0E";
    "markup.bold" = { fg = "base0A"; modifiers = [ "bold" ]; };
    "markup.heading" = "base0D";
    "markup.italic" = { fg = "base0E"; modifiers = [ "italic" ]; };
    "markup.link.text" = "base08";
    "markup.link.url" = { fg = "base09"; modifiers = [ "underlined" ]; };
    "markup.list" = "base08";
    "markup.quote" = "base0C";
    "markup.raw" = "base0B";
    "namespace" = "base0E";
    "operator" = "base05";
    "special" = "base0D";
    "string" = "base0B";
    "type" = "base0A";
    "ui.background" = { bg = "base00"; };
    "ui.cursor" = { fg = "base04"; modifiers = [ "reversed" ]; };
    "ui.cursor.match" = { fg = "base0A"; modifiers = [ "underlined" ]; };
    "ui.cursor.primary" = { fg = "base05"; modifiers = [ "reversed" ]; };
    "ui.gutter" = { bg = "base00"; };
    "ui.help" = { fg = "base06"; bg = "base01"; };
    "ui.linenr" = { fg = "base03"; bg = "base00"; };
    "ui.linenr.selected" = { fg = "base04"; bg = "base01"; modifiers = [ "bold" ]; };
    "ui.menu" = { fg = "base05"; bg = "base01"; };
    "ui.menu.selected" = { fg = "base01"; bg = "base04"; };
    "ui.popup" = { bg = "base01"; };
    "ui.selection" = { bg = "base02"; };
    "ui.statusline" = { fg = "base04"; bg = "base01"; };
    "ui.text" = "base05";
    "ui.text.focus" = "base05";
    "ui.virtual.ruler" = { bg = "base01"; };
    "ui.virtual.whitespace" = { fg = "base03"; };
    "ui.window" = { bg = "base01"; };
    "variable" = "base08";
    "variable.other.member" = "base0B";
    "warning" = "base09";
    "ui.statusline.normal" = { fg = "base00"; bg = "base03"; };
    "ui.statusline.insert" = { fg = "base00"; bg = "base0B"; };
    "ui.statusline.select" = { fg = "base00"; bg = "base0F"; };
  };

  # themes.nixTheme = with palette; {
  #   "attribute" = gray.c1;
  #   "comment" = gray.c3;
  #   "constant" = blue.c2;
  #   "constant.builtin" = blue.c2;
  #   "constant.numeric" = blue.c2;
  #   "constant.character.escape" = blue.c2;
  #   "constructor" = purple.c2;
  #   "function" = purple.c2;
  #   "function.macro" = purple.c2;
  #   "keyword" = red.c3;
  #   "keyword.directive" = red.c3;
  #   "label" = red.c3;
  #   "namespace" = orange.c2;
  #   "operator" = blue.c1;
  #   "punctuation" = gray.c1;
  #   "punctuation.delimiter" = gray.c1;
  #   "special" = blue.c1;
  #   "string" = blue.c1;
  #   "tag" = green.c1;
  #   "type" = orange.c2;
  #   "type.builtin" = blue.c2;
  #   "variable" = blue.c1;
  #   "variable.other.member" = blue.c1;
  #   "variable.parameter" = orange.c2;
  #   "variable.builtin" = red.c3;

  #   "markup.heading" = blue.c2;
  #   "markdown.bold" = { modifiers = [ "bold" ]; };
  #   "markdown.italic" = { modifiers = [ "italic" ]; };
  #   "markdown.strikethrough" = { modifiers = [ "crossed_out" ]; };
  #   "markdown.link.url" = { modifiers = [ "underlined" ]; };
  #   "markdown.link.text" = { fg = blue.c1; modifiers = [ "underlined" ]; };
  #   "markup.raw" = blue.c2;
  #   "diff.plus" = green.c3;
  #   "diff.minus" = red.c4;
  #   "diff.delta" = yellow.c3;
  #   "ui.background" = { bg = gray.c9; };
  #   "ui.background.separator" = { fg = gray.c4; };
  #   "ui.linenr" = { fg = gray.c4; };
  #   "ui.linenr.selected" = { fg = gray.c4; };
  #   "ui.statusline" = { fg = gray.c4; bg = gray.c7; };
  #   "ui.statusline.active" = {
  #     fg = gray.c1;
  #     bg = gray.c9;
  #     underline = {
  #       color = coral.c3;
  #       style = "line";
  #     };
  #   };
  #   "ui.statusline.normal" = { fg = gray.c1; bg = blue.c4; };
  #   "ui.statusline.insert" = { fg = gray.c1; bg = yellow.c4; };
  #   "ui.statusline.select" = { fg = gray.c1; bg = pink.c4; };
  #   "ui.popup" = { bg = gray.c8; };
  #   "ui.popup.info" = { fg = gray.c1; bg = gray.c8; };
  #   "ui.window.fg" = gray.c6;
  #   "ui.help" = { fg = gray.c1; bg = gray.c8; };

  #   "ui.text" = { fg = gray.c3; };
  #   "ui.text.focus" = { fg = gray.c1; };
  #   "ui.text.inactive" = { fg = gray.c4; };
  #   "ui.virtual" = { fg = gray.c6; };
  #   "ui.selection" = { fg = blue.c8; };
  #   "ui.selection.primary" = { bg = blue.c7; };
  #   "ui.cursor.match" = {
  #     fg = yellow.c3;
  #     modifiers = [ "bold" ];
  #     underline = { style = "line"; };
  #   };
  #   "ui.cursor" = { modifiers = [ "reversed" ]; };
  #   "ui.cursorline.primary" = { bg = gray.c8; };

  #   "ui.menu" = { fg = gray.c1; bg = gray.c8; };
  #   "ui.menu.selected" = { bg = gray.c4; };
  #   "ui.menu.scroll" = { fg = gray.c5; bg = gray.c8; };

  #   "diagnostic.hint" = {
  #     underline = { color = green.c3; style = "curl"; };
  #   };
  #   "diagnostic.info" = {
  #     underline = { color = blue.c3; style = "curl"; };
  #   };
  #   "diagnostic.warning" = {
  #     underline = { color = yellow.c3; style = "curl"; };
  #   };
  #   "diagnostic.error" = {
  #     underline = { color = red.c4; style = "curl"; };
  #   };
  # };
}
