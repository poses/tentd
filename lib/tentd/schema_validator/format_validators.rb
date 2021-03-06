ApiValidator.format_validators['https://tent.io/formats/authorize-type-uri'] = lambda do |value|
  return true if value == 'all'
  begin
    uri = URI(value)
    uri.scheme && uri.host
  rescue URI::InvalidURIError, ArgumentError
    false
  end
end

ApiValidator.format_validators['https://tent.io/formats/page-uri'] = lambda do |value|
  # see pchar format in https://tools.ietf.org/html/rfc3986#appendix-A
  value && value =~ /\A\?[-~._,:@%!&"()*+,;=a-z0-9]{0,}\Z/i
end

ApiValidator.format_validators['uri-template'] = lambda do |value|
  return false unless String === value
  begin
    uri = URI(value.gsub(/[{}]/, ''))
    uri.scheme && uri.host
  rescue URI::InvalidURIError, ArgumentError
    false
  end
end
