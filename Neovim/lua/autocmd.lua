local last_ime_on = false

-- インサートモードに入る時：直前がONだった場合のみ復元
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    if last_ime_on then
      vim.uv.spawn("zenhan.exe", { args = { "1" }, detached = true })
    end
  end,
})

-- インサートモードを抜ける時：状態を取得してOFFにする
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    local stdout = vim.uv.new_pipe(false)
    local handle
    handle = vim.uv.spawn("zenhan.exe", {
      stdio = { nil, stdout, nil },
    }, function()
      stdout:read_start(function(err, data)
        if data then
          local state = data:gsub("%s+", "")
          last_ime_on = (state == "1")
        end
        stdout:close()
        handle:close()
        vim.uv.spawn("zenhan.exe", { args = { "0" }, detached = true })
      end)
    end)
  end,
})
