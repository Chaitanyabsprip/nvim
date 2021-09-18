function Workman(workman, qwerty)
  workman = workman or {normal = 0, insert = 0}
  qwerty = qwerty or {normal = 0, insert = 0}
  vim.g.workman_normal_workman = workman.normal
  vim.g.workman_insert_workman = workman.insert
  vim.g.workman_normal_qwerty = qwerty.normal
  vim.g.workman_insert_qwerty = qwerty.insert
end

Workman()
