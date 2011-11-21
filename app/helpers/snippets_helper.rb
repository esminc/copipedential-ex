module SnippetsHelper
  def snippets_parent_name
    case @parent
    when ->(x) { x.respond_to?(:proxy_owner) }
      "#{@parent.proxy_owner.nickname}'s snippets"
    else
      "snippets"
    end
  end

  # XXX CRUD able
  def filetype_suggesions
    [
      ['none (auto-detect)', ''],
      %w[Ruby ruby],
      %w[ERB erb],
      %w[YAML yaml],
      %w[JavaScript javascript],
      %w[Java java],
      %w[C c],
      %w[C++ cpp],
      %w[SQL sql],
      %w[XML xml],
    ]
  end
end
