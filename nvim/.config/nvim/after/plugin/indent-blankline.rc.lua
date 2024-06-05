local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

require("ibl").setup({
  indent = {
    char = "▏",
    -- highlight = highlight -- enables rainbow highlight
  },
  scope = {
    show_start = false,
    show_end = false,
  },
})
