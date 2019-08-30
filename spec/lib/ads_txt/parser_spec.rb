require 'spec_helper'

describe AdsTxt::Parser do
  let(:content) do
    <<-TXT
# ads.txt file for example.com:
greenadexchange.com, 12345, DIRECT, d75815a79
blueadexchange.com, XF436, DIRECT # EOL comment
silverssp.com, ABE679, RESELLER
var=assignment
TXT
  end

  let(:parser) { AdsTxt::Parser.new(content) }

  context 'content description' do
    before { parser.parse }

    it 'returns data-records' do
      expect(parser.data_records).to eq([
        {
          account_type: 'DIRECT',
          certificate_authority_id: 'd75815a79',
          domain_name: 'greenadexchange.com',
          publisher_account_id: '12345'
        },
        {
          account_type: 'DIRECT',
          certificate_authority_id: nil,
          domain_name: 'blueadexchange.com',
          publisher_account_id: 'XF436',
        },
        {
          account_type: 'RESELLER',
          certificate_authority_id: nil,
          domain_name: 'silverssp.com',
          publisher_account_id: 'ABE679'
        }
      ])
    end

    it 'returns variables' do
      expect(parser.variables).to eq({ 'var' => ['assignment'] })
    end
  end

  context 'content validation' do
    it 'returns valid' do
      expect(parser.valid?).to be_truthy
    end

    context 'invalid content' do
      let(:content) do
        <<-TXT
# ads.txt file for example.com:
greenadexchange.com
22-1, 32, 23
silverssp.com, ABE679, RESELLER
TXT
      end

      it 'returns lines with wrong format' do
        expect(parser.valid?).to be_falsey
        expect(parser.errors).to eq(["greenadexchange.com", "22-1, 32, 23"])
      end
    end
  end
end