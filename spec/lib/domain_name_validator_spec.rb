require 'spec_helper'

describe DomainNameValidator do
  it 'valid urls' do
    %w(
      localhost
      example.com
      example.technology
      this-is-a-long-label-which-is-exactly-63-chars-long-and-invalid.com
      some-very-very-very-very-long-domain-name.thats-valid-as-its-shorter-than-256-chars.thats-also-very-very-very-nested-in-a-lot-of-subsubsubdomains.another-long-subdomain.gee-this-it-department-should-really-learn-some-ux.oh-noes-not-another-one.example.com
      123.256
    ).each do |domain_name|
      expect(DomainNameValidator.valid?(domain_name)).to be_truthy
    end
  end

  it 'invalid urls' do
    %w(
      .d
      .com
      -a.co
      _yapper._gmail.google.com
    ).each do |domain_name|
      expect(DomainNameValidator.valid?(domain_name)).to be_falsey
    end

    a_long_domain = 'a' * 256
    expect(DomainNameValidator.valid?(a_long_domain)).to be_falsey
  end
end
