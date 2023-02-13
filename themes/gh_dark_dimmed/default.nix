# GitHubDark dimmed color scheme. Adapted from:
# https://github.com/primer/primitives/blob/292d7dda705b35a2bc3f0bae1ae82b1362b280d3/src/tokens/base/color/dark/dark.dimmed.json5
let
  palette = {
    black = "#1C2128";
    white = "#CDD9E5";
    gray = {
      c0 = "#CDD9E5";
      c1 = "#ADBAC7";
      c2 = "#909DAB";
      c3 = "#768390";
      c4 = "#636E7B";
      c5 = "#545D68";
      c6 = "#444C56";
      c7 = "#373E47";
      c8 = "#2D333B";
      c9 = "#22272E";
    };
    blue = {
      c0 = "#C6E6FF";
      c1 = "#96D0FF";
      c2 = "#6CB6FF";
      c3 = "#539BF5";
      c4 = "#4184E4";
      c5 = "#316DCA";
      c6 = "#255AB2";
      c7 = "#1B4B91";
      c8 = "#143D79";
      c9 = "#0F2D5C";
    };
    green = {
      c0 = "#B4F1B4";
      c1 = "#8DDB8C";
      c2 = "#6BC46D";
      c3 = "#57AB5A";
      c4 = "#46954A";
      c5 = "#347D39";
      c6 = "#2B6A30";
      c7 = "#245829";
      c8 = "#1B4721";
      c9 = "#113417";
    };
    yellow = {
      c0 = "#FBE090";
      c1 = "#EAC55F";
      c2 = "#DAAA3F";
      c3 = "#C69026";
      c4 = "#AE7C14";
      c5 = "#966600";
      c6 = "#805400";
      c7 = "#6C4400";
      c8 = "#593600";
      c9 = "#452700";
    };
    orange = {
      c0 = "#FFDDB0";
      c1 = "#FFBC6F";
      c2 = "#F69D50";
      c3 = "#E0823D";
      c4 = "#CC6B2C";
      c5 = "#AE5622";
      c6 = "#94471B";
      c7 = "#7F3913";
      c8 = "#682D0F";
      c9 = "#4D210C";
    };
    red = {
      c0 = "#FFD8D3";
      c1 = "#FFB8B0";
      c2 = "#FF938A";
      c3 = "#F47067";
      c4 = "#E5534B";
      c5 = "#C93C37";
      c6 = "#AD2E2C";
      c7 = "#922323";
      c8 = "#78191B";
      c9 = "#5D0F12";
    };
    purple = {
      c0 = "#EEDCFF";
      c1 = "#DCBDFB";
      c2 = "#DCBDFB";
      c3 = "#B083F0";
      c4 = "#986EE2";
      c5 = "#8256D0";
      c6 = "#6B44BC";
      c7 = "#5936A2";
      c8 = "#472C82";
      c9 = "#352160";
    };
    pink = {
      c0 = "#FFD7EB";
      c1 = "#FFB3D8";
      c2 = "#FC8DC7";
      c3 = "#E275AD";
      c4 = "#C96198";
      c5 = "#AE4C82";
      c6 = "#983B6E";
      c7 = "#7E325A";
      c8 = "#69264A";
      c9 = "#551639";
    };
    coral = {
      c0 = "#FFDACF";
      c1 = "#FFB9A5";
      c2 = "#F79981";
      c3 = "#EC775C";
      c4 = "#DE5B41";
      c5 = "#C2442D";
      c6 = "#A93524";
      c7 = "#8D291B";
      c8 = "#771D13";
      c9 = "#5D1008";
    };
  };


in
{
  # System-wide colors, used in sway and alacritty.
  # Superset of the usual 16 ANSI colors.
  systemColors = with palette; {
    # ANSI
    black = black;
    red = red.c5;
    green = green.c5;
    yellow = yellow.c5;
    blue = blue.c7;
    magenta = purple.c5;
    cyan = blue.c2;
    white = gray.c1;
    # Non-ANSI
    orange = orange.c5;
    pink = pink.c4;
    coral = coral.c4;
    bright = {
      # ANSI
      black = gray.c8;
      red = red.c3;
      green = green.c4;
      yellow = yellow.c3;
      blue = blue.c4;
      magenta = purple.c2;
      cyan = blue.c1;
      white = white;
      # Non-ANSI
      orange = orange.c2;
      pink = pink.c1;
      coral = coral.c2;
    };
  };

  programs.helix.themes.nixTheme = with palette; {
    "attribute" = gray.c1;
    "comment" = gray.c3;
    "constant" = blue.c2;
    "constant.builtin" = blue.c2;
    "constant.numeric" = blue.c2;
    "constant.character.escape" = blue.c2;
    "constructor" = purple.c2;
    "function" = purple.c2;
    "function.macro" = purple.c2;
    "keyword" = red.c3;
    "keyword.directive" = red.c3;
    "label" = red.c3;
    "namespace" = orange.c2;
    "operator" = blue.c1;
    "punctuation" = gray.c1;
    "punctuation.delimiter" = gray.c1;
    "special" = blue.c1;
    "string" = blue.c1;
    "tag" = green.c1;
    "type" = orange.c2;
    "type.builtin" = blue.c2;
    "variable" = blue.c1;
    "variable.other.member" = blue.c1;
    "variable.parameter" = orange.c2;
    "variable.builtin" = red.c3;

    "markup.heading" = blue.c2;
    "markdown.bold" = { modifiers = [ "bold" ]; };
    "markdown.italic" = { modifiers = [ "italic" ]; };
    "markdown.strikethrough" = { modifiers = [ "crossed_out" ]; };
    "markdown.link.url" = { modifiers = [ "underlined" ]; };
    "markdown.link.text" = { fg = blue.c1; modifiers = [ "underlined" ]; };
    "markup.raw" = blue.c2;
    "diff.plus" = green.c3;
    "diff.minus" = red.c4;
    "diff.delta" = yellow.c3;
    "ui.background" = { bg = gray.c9; };
    "ui.background.separator" = { fg = gray.c4; };
    "ui.linenr" = { fg = gray.c4; };
    "ui.linenr.selected" = { fg = gray.c4; };
    "ui.statusline" = { fg = gray.c4; bg = gray.c7; };
    "ui.statusline.active" = {
      fg = gray.c1;
      bg = gray.c9;
      underline = {
        color = coral.c3;
        style = "line";
      };
    };
    "ui.statusline.normal" = { fg = gray.c1; bg = blue.c4; };
    "ui.statusline.insert" = { fg = gray.c1; bg = yellow.c4; };
    "ui.statusline.select" = { fg = gray.c1; bg = pink.c4; };
    "ui.popup" = { bg = gray.c8; };
    "ui.popup.info" = { fg = gray.c1; bg = gray.c8; };
    "ui.window.fg" = gray.c6;
    "ui.help" = { fg = gray.c1; bg = gray.c8; };

    "ui.text" = { fg = gray.c3; };
    "ui.text.focus" = { fg = gray.c1; };
    "ui.text.inactive" = { fg = gray.c4; };
    "ui.virtual" = { fg = gray.c6; };
    "ui.selection" = { fg = blue.c8; };
    "ui.selection.primary" = { bg = blue.c7; };
    "ui.cursor.match" = {
      fg = yellow.c3;
      modifiers = [ "bold" ];
      underline = { style = "line"; };
    };
    "ui.cursor" = { modifiers = [ "reversed" ]; };
    "ui.cursorline.primary" = { bg = gray.c8; };

    "ui.menu" = { fg = gray.c1; bg = gray.c8; };
    "ui.menu.selected" = { bg = gray.c4; };
    "ui.menu.scroll" = { fg = gray.c5; bg = gray.c8; };

    "diagnostic.hint" = {
      underline = { color = green.c3; style = "curl"; };
    };
    "diagnostic.info" = {
      underline = { color = blue.c3; style = "curl"; };
    };
    "diagnostic.warning" = {
      underline = { color = yellow.c3; style = "curl"; };
    };
    "diagnostic.error" = {
      underline = { color = red.c4; style = "curl"; };
    };
  };
}
