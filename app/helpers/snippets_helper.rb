module SnippetsHelper
  def syntax(snippet, limit = nil)
    body = limit ? snippet.body.lines.first(limit).join : snippet.body
    CodeRay.scan(body, snippet.assumed_filetype.to_sym).div(line_numbers: :table)
  end
end
