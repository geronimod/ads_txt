# Validate Domain Names as outlined by RFC 2181
# TODO: extract it to its own gem
class DomainNameValidator
  REXP = /^(?:[a-z0-9](?:[a-z0-9\-]{0,61}[a-z0-9])?\.){0,126}(?:[a-z0-9](?:[a-z0-9\-]{0,61}[a-z0-9]))\.?$/i

  def self.valid?(domain)
    domain.size.between?(2, 255) && REXP === domain
  end
end