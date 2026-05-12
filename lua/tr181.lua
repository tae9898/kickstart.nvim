-- tr181.lua
-- TR-181 Data Model 참조 도구 for Neovim
--
-- 설치: ~/.config/nvim/lua/tr181.lua 에 복사 후
--       init.lua 에 require('tr181').setup() 추가
--
-- 기능:
--   <leader>ts  : 커서 단어로 TR-181 검색 (플로팅 윈도우)
--   <leader>tS  : 직접 입력하여 TR-181 검색
--   <leader>tp  : 커서 단어로 parameter 상세 보기
--   <leader>to  : 커서 단어로 object 상세 보기
--   <leader>tf  : fzf 인터랙티브 검색 (터미널 분할)
--   <leader>tt  : TR-181 트리 탐색기 (플로팅 윈도우)
--   <leader>tl  : 현재 라인의 TR-181 경로 자동 감지 후 show

local M = {}

-- ─── 기본 설정 ────────────────────────────────────────────────────────────────
M.config = {
  -- tr181 실행 파일 경로 (설치 후 경로로 변경)
  tr181_cmd = os.getenv("TR181_CMD") or "tr181",

  -- 플로팅 윈도우 크기 (0~1 비율)
  float_width  = 0.75,
  float_height = 0.75,

  -- 검색 결과 최대 개수
  search_limit = 40,

  -- 키맵 prefix
  keymap_prefix = "<leader>t",

  -- 키맵 활성화 여부
  enable_keymaps = true,
}

-- ─── 내부 유틸 ────────────────────────────────────────────────────────────────
local function run_cmd(args)
  local cmd = M.config.tr181_cmd .. " " .. args .. " 2>/dev/null"
  local handle = io.popen(cmd)
  if not handle then return {} end
  local result = handle:read("*a")
  handle:close()
  -- 줄 단위로 분리
  local lines = {}
  for line in result:gmatch("[^\n]+") do
    table.insert(lines, line)
  end
  return lines
end

local function strip_ansi(str)
  return str:gsub("\027%[[%d;]*m", "")
end

-- ─── 플로팅 윈도우 ────────────────────────────────────────────────────────────
local float_win = nil
local float_buf = nil

local function close_float()
  if float_win and vim.api.nvim_win_is_valid(float_win) then
    vim.api.nvim_win_close(float_win, true)
  end
  float_win = nil
  float_buf = nil
end

local function open_float(lines, title)
  close_float()

  -- ANSI 코드 제거
  local clean_lines = {}
  for _, l in ipairs(lines) do
    table.insert(clean_lines, strip_ansi(l))
  end

  -- 윈도우 크기 계산
  local ui = vim.api.nvim_list_uis()[1]
  local win_w = math.floor(ui.width  * M.config.float_width)
  local win_h = math.floor(ui.height * M.config.float_height)
  local row   = math.floor((ui.height - win_h) / 2)
  local col   = math.floor((ui.width  - win_w) / 2)

  -- 버퍼 생성
  float_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(float_buf, 0, -1, false, clean_lines)
  vim.api.nvim_buf_set_option(float_buf, "modifiable", false)
  vim.api.nvim_buf_set_option(float_buf, "filetype", "tr181")

  -- 윈도우 열기
  float_win = vim.api.nvim_open_win(float_buf, true, {
    relative = "editor",
    width    = win_w,
    height   = win_h,
    row      = row,
    col      = col,
    style    = "minimal",
    border   = "rounded",
    title    = " " .. (title or "TR-181") .. " ",
    title_pos = "center",
  })

  -- 플로팅 윈도우 내 키맵
  local opts = { buffer = float_buf, silent = true, noremap = true }
  -- q / ESC: 닫기
  vim.keymap.set("n", "q",     close_float, opts)
  vim.keymap.set("n", "<Esc>", close_float, opts)
  -- Enter: 커서 아래 경로로 show
  vim.keymap.set("n", "<CR>", function()
    local line = vim.api.nvim_get_current_line()
    local path = line:match("Device%.[%w%.%{%}]+")
    if path then
      close_float()
      M.show(path)
    end
  end, opts)
  -- s: 커서 아래 단어로 재검색
  vim.keymap.set("n", "s", function()
    local word = vim.fn.expand("<cword>")
    if word ~= "" then
      close_float()
      M.search(word)
    end
  end, opts)
  -- p: 커서 아래 경로로 params 보기
  vim.keymap.set("n", "p", function()
    local line = vim.api.nvim_get_current_line()
    local path = line:match("Device%.[%w%.%{%}]+")
    if path then
      close_float()
      M.params(path)
    end
  end, opts)

  -- 구문 강조 (간단한 매치)
  vim.api.nvim_buf_call(float_buf, function()
    vim.fn.matchadd("Keyword",    "\\[OBJ\\]")
    vim.fn.matchadd("String",     "\\[PAR\\]")
    vim.fn.matchadd("Identifier", "Device\\.[A-Za-z0-9.{}i.]*")
    vim.fn.matchadd("Comment",    "readOnly")
    vim.fn.matchadd("Function",   "readWrite")
    vim.fn.matchadd("Type",       "\\(string\\|boolean\\|int\\|unsignedInt\\|dateTime\\|list\\)")
    vim.fn.matchadd("Special",    "─\\+")
  end)

  return float_buf, float_win
end

-- ─── 공개 API ─────────────────────────────────────────────────────────────────

--- 키워드 검색
function M.search(keyword)
  if not keyword or keyword == "" then
    keyword = vim.fn.input("TR-181 Search: ")
    if keyword == "" then return end
  end
  local lines = run_cmd(string.format("search %q --limit %d", keyword, M.config.search_limit))
  if #lines == 0 then
    vim.notify("TR-181: No results for '" .. keyword .. "'", vim.log.levels.WARN)
    return
  end
  open_float(lines, "TR-181 Search: " .. keyword)
end

--- 커서 단어로 검색
function M.search_cword()
  local word = vim.fn.expand("<cword>")
  if word == "" then
    vim.notify("TR-181: No word under cursor", vim.log.levels.WARN)
    return
  end
  M.search(word)
end

--- 경로 상세 보기
function M.show(path)
  if not path or path == "" then
    path = vim.fn.expand("<cword>")
  end
  if path == "" then return end
  local lines = run_cmd(string.format("show %q", path))
  if #lines == 0 then
    vim.notify("TR-181: Not found: " .. path, vim.log.levels.WARN)
    return
  end
  open_float(lines, "TR-181: " .. path)
end

--- 커서 아래 TR-181 경로 자동 감지 후 show
function M.show_path_under_cursor()
  -- 현재 라인에서 Device.XXX.YYY 패턴 추출
  local line = vim.api.nvim_get_current_line()
  local col  = vim.api.nvim_win_get_cursor(0)[2] + 1

  -- 커서 위치 기준으로 경로 추출
  local path = nil

  -- 전체 라인에서 TR-181 경로 패턴 모두 찾기
  for p in line:gmatch("Device%.[%w%.%{%}i]+") do
    local s, e = line:find(p, 1, true)
    if s and e and s <= col and col <= e then
      path = p
      break
    end
  end

  -- 못 찾으면 커서 단어 사용
  if not path then
    path = vim.fn.expand("<cword>")
  end

  if path == "" then
    vim.notify("TR-181: No path found under cursor", vim.log.levels.WARN)
    return
  end

  M.show(path)
end

--- Object의 Parameter 목록
function M.params(path)
  if not path or path == "" then
    path = vim.fn.expand("<cword>")
  end
  if path == "" then return end
  local lines = run_cmd(string.format("params %q", path))
  if #lines == 0 then
    vim.notify("TR-181: Not found: " .. path, vim.log.levels.WARN)
    return
  end
  open_float(lines, "TR-181 Params: " .. path)
end

--- 트리 탐색기
function M.tree(prefix, depth)
  prefix = prefix or vim.fn.input("TR-181 Tree prefix (e.g. Device.WiFi.): ", "Device.")
  if prefix == "" then return end
  depth = depth or 4
  local lines = run_cmd(string.format("tree %q --depth %d", prefix, depth))
  if #lines == 0 then
    vim.notify("TR-181: No objects under " .. prefix, vim.log.levels.WARN)
    return
  end
  open_float(lines, "TR-181 Tree: " .. prefix)
end

--- fzf 인터랙티브 검색 (터미널 분할)
function M.fzf()
  -- 하단 터미널 분할로 fzf 실행
  local cmd = M.config.tr181_cmd .. " fzf"
  vim.cmd("botright 20split")
  vim.fn.termopen(cmd, {
    on_exit = function()
      vim.cmd("bdelete!")
    end,
  })
  vim.cmd("startinsert")
end

--- 통계 보기
function M.stats()
  local lines = run_cmd("stats")
  open_float(lines, "TR-181 Statistics")
end

-- ─── 자동완성 (omnifunc) ──────────────────────────────────────────────────────
-- :set omnifunc=v:lua.require('tr181').omnifunc 로 활성화
function M.omnifunc(findstart, base)
  if findstart == 1 then
    -- 커서 앞에서 Device. 시작점 찾기
    local line = vim.api.nvim_get_current_line()
    local col  = vim.api.nvim_win_get_cursor(0)[2]
    local sub  = line:sub(1, col)
    local s    = sub:find("Device%.[%w%.%{%}i]*$")
    if s then
      return s - 1
    end
    return -3  -- 자동완성 취소
  else
    -- base 로 시작하는 object/parameter 목록 반환
    local lines = run_cmd(string.format("list %q", base))
    local items = {}
    for _, l in ipairs(lines) do
      local path = l:match("Device%.[%w%.%{%}i.]+")
      if path then
        table.insert(items, {
          word = path,
          menu = "[TR-181]",
          kind = l:match("%[table%]") and "T" or "O",
        })
      end
    end
    return items
  end
end

-- ─── 키맵 등록 ────────────────────────────────────────────────────────────────
function M.setup(opts)
  -- 설정 병합
  if opts then
    for k, v in pairs(opts) do
      M.config[k] = v
    end
  end

  if not M.config.enable_keymaps then return end

  local p = M.config.keymap_prefix
  local map = function(key, fn, desc)
    vim.keymap.set("n", p .. key, fn, { silent = true, desc = "TR-181: " .. desc })
  end

  map("s", M.search_cword,           "Search (cursor word)")
  map("S", function() M.search() end,"Search (input)")
  map("p", function() M.params() end,"Params of object")
  map("o", function() M.show() end,  "Show object/param")
  map("l", M.show_path_under_cursor, "Show path under cursor")
  map("f", M.fzf,                    "fzf interactive search")
  map("t", function() M.tree() end,  "Tree explorer")
  map("i", M.stats,                  "Statistics")

  -- 플로팅 윈도우 닫기 (전역)
  vim.keymap.set("n", p .. "q", close_float, { silent = true, desc = "TR-181: Close float" })

  vim.notify("TR-181 plugin loaded. Prefix: " .. p, vim.log.levels.INFO)
end

return M
