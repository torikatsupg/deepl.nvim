local M = {}

function M.hit_api(text)
  local url = "https://api-free.deepl.com/v2/translate"
  local api_key = "dc80fc47-c98e-5f6d-411d-8ea6a3a6e1ef:fx"
  local cmd = string.format(
    'curl -s -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "auth_key=%s&text=%s&target_lang=JA" %s | jq -r ".translations[0].text"',
    api_key,
    text,
    url
  )
  local handle = io.popen(cmd)
  local result = handle:read("*a")
  handle:close()
  return result or ""
end

return M
