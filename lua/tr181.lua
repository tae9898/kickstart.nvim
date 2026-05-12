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
--   <leader>to  : 커서 단어로 object/param show
--   <leader>tf  : fzf 인터랙티브 검색 (터미널 분할)
--   <leader>tt  : TR-181 트리 탐색기 (플로팅 윈도우)
--   <leader>tl  : 현재 라인의 TR-181 경로 자동 감지 후 show
--   <leader>ti  : 통계 보기

local M = {}

-- ─── 기본 설정 ────────────────────────────────────────────────────────────────
M.config = {
  -- tr181 실행 파일 경로 (TR181_CMD 환경변수 또는 기본값)
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

--- 쉘 명령 실행 후 결과를 줄 단위 테이블로 반환
--- 항상 table을 반환 (nil 반환 없음)
local function run_cmd(subcmd, ...)
  -- 인자를 안전하게 쉘 이스케이프
  local escaped_args = {}
  for _, arg in ipairs({...}) do
    -- 작은따옴표로 감싸고 내부 작은따옴표는 '\'' 로 치환
    local safe = "'" .. tostring(arg):gsub("'", "'\\''") .. "'"
    table.insert(escaped_args, safe)
  end

  local cmd = table.concat({
    M.config.tr181_cmd,
    subcmd,
    table.concat(escaped_args, " "),
    "2>/dev/null",
  }, " ")

  local handle = io.popen(cmd)
  if not handle then
    return {}
  end

  local result = handle:read("*a")
  handle:close()

  -- result가 nil이거나 string이 아닌 경우 방어
  if type(result) ~= "string" then
    return {}
  end

  -- ANSI 이스케이프 코드 제거
  result = result:gsub("\027%[[%d;]*m", "")

  -- 줄 단위 분리
  local lines = {}
  for line in result:gmatch("[^\n]+") do
    -- 각 항목이 반드시 string임을 보장
    if type(line) == "string" then
      table.insert(lines, line)
    end
  end

  return lines
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

--- lines: string 배열 (반드시 table이어야 함)
local function open_float(lines, title)
  -- 타입 안전성 검사
  if type(lines) ~= "table" then
    vim.notify("TR-181: internal error (lines is not a table: " .. type(lines) .. ")", vim.log.levels.ERROR)
    return
  end

  close_float()

  -- 각 항목을 string으로 변환 (방어적 처리)
  local clean_lines = {}
  for i, l in ipairs(lines) do
    if type(l) == "string" then
      table.insert(clean_lines, l)
    else
      table.insert(clean_lines, tostring(l))
    end
  end

  if #clean_lines == 0 then
    vim.notify("TR-181: No output to display", vim.log.levels.WARN)
    return
  end

  -- 윈도우 크기 계산
  local ui = vim.api.nvim_list_uis()[1]
  if not ui then
    vim.notify("TR-181: Cannot get UI info", vim.log.levels.ERROR)
    return
  end
  local win_w = math.floor(ui.width  * M.config.float_width)
  local win_h = math.floor(ui.height * M.config.float_height)
  local row   = math.floor((ui.height - win_h) / 2)
  local col   = math.floor((ui.width  - win_w) / 2)

  -- 최소 크기 보장
  win_w = math.max(win_w, 40)
  win_h = math.max(win_h, 10)

  -- 버퍼 생성
  float_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(float_buf, 0, -1, false, clean_lines)
  vim.api.nvim_buf_set_option(float_buf, "modifiable", false)
  vim.api.nvim_buf_set_option(float_buf, "bufhidden", "wipe")

  -- 윈도우 열기
  local ok, err = pcall(function()
    float_win = vim.api.nvim_open_win(float_buf, true, {
      relative  = "editor",
      width     = win_w,
      height    = win_h,
      row       = row,
      col       = col,
      style     = "minimal",
      border    = "rounded",
      title     = " " .. (title or "TR-181") .. " ",
      title_pos = "center",
    })
  end)

  if not ok then
    -- title_pos 미지원 Neovim 버전 대응 (0.9 미만)
    float_win = vim.api.nvim_open_win(float_buf, true, {
      relative = "editor",
      width    = win_w,
      height   = win_h,
      row      = row,
      col      = col,
      style    = "minimal",
      border   = "rounded",
    })
  end

  -- 플로팅 윈도우 내 키맵
  local opts = { buffer = float_buf, silent = true, noremap = true }

  -- q / ESC: 닫기
  vim.keymap.set("n", "q",     close_float, opts)
  vim.keymap.set("n", "<Esc>", close_float, opts)

  -- Enter: 커서 아래 경로로 show
  vim.keymap.set("n", "<CR>", function()
    local line = vim.api.nvim_get_current_line()
    local path = line:match("Device%.[%w%.%{%}i]+")
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
    local path = line:match("Device%.[%w%.%{%}i]+")
    if path then
      close_float()
      M.params(path)
    end
  end, opts)

  -- 구문 강조
  vim.api.nvim_buf_call(float_buf, function()
    vim.fn.matchadd("Keyword",    "\\[OBJ\\]")
    vim.fn.matchadd("String",     "\\[PAR\\]")
    vim.fn.matchadd("Identifier", "Device\\.[A-Za-z0-9.{}i]*")
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
  local lines = run_cmd("search", keyword, "--limit", tostring(M.config.search_limit))
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
  local lines = run_cmd("show", path)
  if #lines == 0 then
    vim.notify("TR-181: Not found: " .. path, vim.log.levels.WARN)
    return
  end
  open_float(lines, "TR-181: " .. path)
end

--- 커서 아래 TR-181 경로 자동 감지 후 show
function M.show_path_under_cursor()
  local line = vim.api.nvim_get_current_line()
  local col  = vim.api.nvim_win_get_cursor(0)[2] + 1

  local path = nil

  -- 라인에서 Device.XXX.YYY 패턴 모두 찾아 커서 위치와 겹치는 것 선택
  local search_start = 1
  while true do
    local s, e = line:find("Device%.[%w%.%{%}i]+", search_start)
    if not s then break end
    if s <= col and col <= e then
      path = line:sub(s, e)
      break
    end
    search_start = e + 1
  end

  -- 못 찾으면 커서 단어 사용
  if not path then
    path = vim.fn.expand("<cword>")
  end

  if not path or path == "" then
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
  local lines = run_cmd("params", path)
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
  local lines = run_cmd("tree", prefix, "--depth", tostring(depth))
  if #lines == 0 then
    vim.notify("TR-181: No objects under " .. prefix, vim.log.levels.WARN)
    return
  end
  open_float(lines, "TR-181 Tree: " .. prefix)
end

--- fzf 인터랙티브 검색 (하단 터미널 분할)
function M.fzf()
  local cmd = M.config.tr181_cmd .. " fzf"
  vim.cmd("botright 20split")
  vim.fn.termopen(cmd, {
    on_exit = function()
      -- 터미널 버퍼 자동 닫기
      vim.schedule(function()
        vim.cmd("bdelete!")
      end)
    end,
  })
  vim.cmd("startinsert")
end

--- 통계 보기
function M.stats()
  local lines = run_cmd("stats")
  if #lines == 0 then
    vim.notify("TR-181: Failed to get stats", vim.log.levels.ERROR)
    return
  end
  open_float(lines, "TR-181 Statistics")
end

-- ─── 자동완성 (omnifunc) ──────────────────────────────────────────────────────
-- 사용법: :set omnifunc=v:lua.require('tr181').omnifunc
function M.omnifunc(findstart, base)
  if findstart == 1 then
    local line = vim.api.nvim_get_current_line()
    local col  = vim.api.nvim_win_get_cursor(0)[2]
    local sub  = line:sub(1, col)
    local s    = sub:find("Device%.[%w%.%{%}i]*$")
    if s then
      return s - 1
    end
    return -3
  else
    local lines = run_cmd("list", base)
    local items = {}
    for _, l in ipairs(lines) do
      if type(l) == "string" then
        local path = l:match("Device%.[%w%.%{%}i.]+")
        if path then
          table.insert(items, {
            word = path,
            menu = "[TR-181]",
            kind = l:match("%[table%]") and "T" or "O",
          })
        end
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

  map("s", M.search_cword,            "Search (cursor word)")
  map("S", function() M.search() end, "Search (input)")
  map("p", function() M.params() end, "Params of object")
  map("o", function() M.show() end,   "Show object/param")
  map("l", M.show_path_under_cursor,  "Show path under cursor")
  map("f", M.fzf,                     "fzf interactive search")
  map("t", function() M.tree() end,   "Tree explorer")
  map("i", M.stats,                   "Statistics")

  -- 플로팅 윈도우 닫기 (전역)
  vim.keymap.set("n", p .. "q", close_float, { silent = true, desc = "TR-181: Close float" })
end

return M
