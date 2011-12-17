module SnippetsHelper
  def snippets_parent_name
    case @parent
    when ->(x) { x.respond_to?(:proxy_owner) }
      "#{@parent.proxy_owner.nickname}'s snippets"
    else
      "snippets"
    end
  end

  def filetype_suggesions
    [
      ['none (auto-detect)', ''],
      *Filetype.ordered.map {|ft| [ft.name, ft.id] }
    ]
  end
end
