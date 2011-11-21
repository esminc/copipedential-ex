module SnippetsHelper
  def snippets_parent_name
    case @parent
    when ->(x) { x.respond_to?(:proxy_owner) }
      "#{@parent.proxy_owner.nickname}'s snippets"
    else
      "snippets"
    end
  end

  def syntax(snippet, limit = nil)
    body = limit ? snippet.body.lines.first(limit).join : snippet.body
    CodeRay.scan(body, snippet.assumed_filetype.to_sym).div(line_numbers: :table, css: :style)
  end
end
