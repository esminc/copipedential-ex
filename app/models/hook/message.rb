class Hook
  class Message
    include Rails.application.routes.url_helpers

    self.default_url_options = {protocol: 'https', host: 'copipedential.herokuapp.com'}

    def initialize(snippet)
      @snippet = snippet
    end

    def mention
      verb = @snippet.id_was.nil? ? 'pasted' : 'updated'
      receivers = @snippet.mentioneds.map(&:nickname).sort.join(' ')

      "#{receivers}: #{author_nickname} #{verb} snippet for you -- #{permalink}"
    end

    private

    def author_nickname
      @snippet.author.nickname
    end

    def permalink
      url_for(@snippet)
    end
  end
end

