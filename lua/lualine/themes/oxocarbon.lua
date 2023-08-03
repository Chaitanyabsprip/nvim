local colors = {
  color0 = '#393939',
  color1 = '#ee5396',
  color2 = '#3ddbd9',
  color3 = '#161616',
  color6 = '#dde1e6',
  color7 = '#78a9ff',
  color8 = '#bd95ff',
  color9 = '#ff7eb6',
  color10 = '#42be65',
}

return {
  replace = {
    a = { fg = colors.color0, bg = colors.color1 },
    b = { fg = colors.color2, bg = colors.color3 },
  },
  inactive = {
    a = { fg = colors.color0, bg = colors.color7 },
    b = { fg = colors.color6, bg = colors.color3 },
    z = { fg = colors.color0, bg = colors.color3 },
  },
  normal = {
    a = { fg = colors.color0, bg = colors.color7 },
    b = { fg = colors.color6, bg = colors.color3 },
    c = { fg = colors.color6, bg = colors.color3 },
    z = { fg = colors.color6, bg = colors.color3 },
  },
  visual = {
    a = { fg = colors.color0, bg = colors.color8 },
    b = { fg = colors.color6, bg = colors.color3 },
    y = { fg = colors.color6, bg = colors.color3 },
    z = { fg = colors.color9, bg = colors.color3 },
  },
  insert = {
    a = { fg = colors.color0, bg = colors.color9 },
    b = { fg = colors.color6, bg = colors.color3 },
    z = { fg = colors.color9, bg = colors.color3 },
  },
  command = {
    a = { fg = colors.color0, bg = colors.color10 },
  },
}
