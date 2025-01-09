-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['y'] = function(state)
            -- 선택된 노드의 경로를 가져옴
            local node = state.tree:get_node()
            local filepath = node:get_id()
            -- 시스템 클립보드에 복사
            vim.fn.setreg('+', filepath)
            vim.notify('Copied: ' .. filepath)
          end,
          -- 상대 경로용 매핑을 추가하고 싶다면
          ['yr'] = function(state)
            local node = state.tree:get_node()
            local filepath = vim.fn.fnamemodify(node:get_id(), ':.')
            vim.fn.setreg('+', filepath)
            vim.notify('Copied relative: ' .. filepath)
          end,
        },
      },
    },
  },
}
