XmlSanitizeRx = /<[^>]+>/
LF = %(\n)

def to_absolute_uri abspath
  %(#{data.site.baseurl}#{abspath})
end

def pretty?
  config[:slim][:pretty]
end

def to_cdata html
  html.gsub(XmlSanitizeRx, '').tr(LF, ' ')
end

def preview?
  ENV['CONTEXT'] == 'deploy-preview'
end
