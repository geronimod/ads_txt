module AdsTxt
  class Parser
    ACCOUNT_TYPES = %w(DIRECT RESELLER).freeze
    DATA_RECORD_FIELDS = %i(
      domain_name
      publisher_account_id
      account_type
      certificate_authority_id
    )

    REXP_EMPTY               = /^\s*$/
    REXP_COMMENT             = /^\s*#/
    REXP_LINE                = /\r\n|\n|\r/
    REXP_VARIABLE_DEFINITION = /^([a-zA-Z]+)=(.+)$/

    attr_reader :errors, :variables, :data_records

    def initialize(content, options = {})
      @content      = content
      @options      = options
      @data_records = []
      @variables    = {}
      @errors       = []
    end

    def valid?
      @errors.clear
      parse
      @errors.empty?
    end

    def errors_detail
      "Invalid lines: %s" % @errors.join(' | ')
    end

    def parse
      lines.each do |line|
        next if comment?(line) || empty?(line)

        if variable_assignment?(line)
          process_variable_assigment(line)
        elsif data_record?(line)
          process_data_record(line)
        else
          @errors << line
        end
      end
    end

    private

    def lines
      @lines ||= @content.split(REXP_LINE)
    end

    def process_data_record(line)
      @data_records << Hash[DATA_RECORD_FIELDS.zip(parse_data_record(line))]
    end

    def process_variable_assigment(line)
      key, value = REXP_VARIABLE_DEFINITION.match(line).captures
      @variables[key] ||= []
      @variables[key] << value
    end

    def comment?(line)
      REXP_COMMENT === line
    end

    def empty?(line)
      REXP_EMPTY === line
    end

    def variable_assignment?(line)
      REXP_VARIABLE_DEFINITION === line
    end

    def domain?(domain)
      DomainNameValidator.valid?(domain)
    end

    # DATA RECORD:
    # 1 [required] Domain name of the advertising system
    # 2 [required] Publisher’s Account ID
    # 3 [required] Type of Account/Relationship
    # 4 [optional] Certification Authority ID
    def data_record?(line)
      domain, account_id, account_type, _ = parse_data_record(line)
      ACCOUNT_TYPES.include?(account_type.to_s.upcase) && domain?(domain)
    end

    def parse_data_record(line)
      strip_comment(line).split(',').map(&:strip)
    end

    def strip_comment(line)
      data, _ = line.split('#')
      data.strip
    end
  end
end