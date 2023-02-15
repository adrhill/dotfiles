{ colorscheme }: {
  "${colorscheme.slug}" = {
    palette = builtins.mapAttrs (name: value: "#${value}") colorscheme.colors; # Add leading '#'
    "attributes" = "base09";
    "comment" = { fg = "base03"; modifiers = [ "italic" ]; };
    "constant" = "base0C";
    "constant.character.escape" = "base0C";
    "constant.numeric" = "base0D";
    "constructor" = "base08";
    "function" = "base0D";
    "function.method" = "base0E";
    "function.macro" = "base08";
    "keyword" = "base08";
    "label" = "base0D";
    "namespace" = "base08";
    "operator" = "base08";
    "special" = "base08";
    "string" = "base0C";
    "type" = "base0D";
    "variable" = "base06";

    "diff.delta" = "base09";
    "diff.minus" = "base08";
    "diff.plus" = "base0B";

    "markup.bold" = { fg = "base0A"; modifiers = [ "bold" ]; };
    "markup.heading" = "base0D";
    "markup.italic" = { fg = "base0E"; modifiers = [ "italic" ]; };
    "markup.link.text" = "base08";
    "markup.link.url" = { fg = "base09"; modifiers = [ "underlined" ]; };
    "markup.list" = "base08";
    "markup.quote" = "base0C";
    "markup.raw" = "base0B";

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

    "ui.statusline.normal" = { fg = "base00"; bg = "base03"; };
    "ui.statusline.insert" = { fg = "base00"; bg = "base0B"; };
    "ui.statusline.select" = { fg = "base00"; bg = "base0F"; };
  };
}
