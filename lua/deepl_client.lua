local M = {}

function M.hit_api(text)
  local url = "https://api-free.deepl.com/v2/translate"
  local cmd = string.format(
    'curl -s -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "auth_key=%s&text=%s&target_lang=JA" %s | tee > ~/Desktop/deepl.log | jq -r ".translations[0].text"',
    vim.env.deepl_nvim_apikey,
    text,
    url
  )
  local handle = io.popen(cmd)
  local result = handle:read("*a")
  handle:close()
  return result or ""
end

return M
