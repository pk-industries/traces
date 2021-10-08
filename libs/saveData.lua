--[[
MIT License

Copyright (c) 2017 Robert Herlihy

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

local saveData = {}
local finalStringTemp = "return { \r\n"
local function escape(str)
  local symbols = {
    bell = "\a",
    form_feed = "\f",
    new_line = "\n",
    carriage_return = "\r",
    verticle_tab = "\v",
    backslash = "\\",
    double_quote = "\"",
  }
  local escapedSymbols = {
    bell = "\\a",
    form_feed = "\\f",
    new_line = "\\n",
    carriage_return = "\\r",
    verticle_tab = "\\v",
    backslash = "\\\\",
    double_quote = "\\\"",
  }
  local str2 = str
  str2 = str2:gsub(symbols.backslash, escapedSymbols.backslash)
  for i,v in pairs(symbols) do
    if i ~= "backslash" then
      str2 = str2:gsub(v, escapedSymbols[i])
    end
  end
  return str2
end


local function formatData2(data)
  local finalString = finalStringTemp
  
  local function formatData1(data)
    local indTypeForm
      for i, v in pairs(data) do
        assert((type(i) ~= "table"), "Data table cannot have an table as a key reference")
        if type(i) == "string" then
          indTypeForm = "[\""..escape(i).."\"]"
        else
          indTypeForm = "["..tostring(i).."]"
        end
        if type(v) == "table" then
          finalString = finalString..indTypeForm.."= {\r\n"
          formatData1(v)
          finalString = finalString.."},\r\n"
        else
          if type(v) == "string" then v = [["]]..escape(v)..[["]] end
          finalString = finalString..indTypeForm.."="..v..",\r\n"
        end
      end
    finalString = finalString:sub(1, string.len(finalString)-3).."\r\n"
  end

  formatData1(data)
  finalString = finalString.."\r\n} "
  return finalString
end

function saveData.load(saveFile)
  local chunk, fileError = love.filesystem.load(saveFile)
  return chunk(), fileError
end

function saveData.save(data, saveFile)
  return love.filesystem.write(saveFile, formatData2(data))
end

return saveData
